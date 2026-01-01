use std::env;
use std::fs;
use std::path::Path;

use crate::runconfig;

use crate::vhl::line_part::LinePart;
use crate::vhl::preproc;

use crate::vhl::process__asm;

use crate::vhl::process_break;
use crate::vhl::process_continue;
use crate::vhl::process_endblk;
use crate::vhl::process_eval_eq_rpn;
use crate::vhl::process_def;
use crate::vhl::process_fn;
use crate::vhl::process_fn_call;
use crate::vhl::process_for;
use crate::vhl::process_if_rpn;
use crate::vhl::process_let;
use crate::vhl::process_loop;
use crate::vhl::process_println;
use crate::vhl::process_return;
use crate::vhl::process_while_rpn;

use crate::vhl::process_methods_file;

use crate::vhl::outputs;


fn show_usage() {
    println!("Usage: vintagecc FILE");
    println!();
}

fn load_source_file(fpath: &str) -> Option<String> {
    if !Path::new(fpath).exists() {
        println!("ERROR: Source file `{}` does not exist.", fpath);
        return None;
    }

    if fpath.ends_with(".vnt") {
        let stop = fpath.len() - 4;
        let outpath = format!("{}.vll", &fpath[0..stop]);
        outputs::set_output_filename(&outpath);
    }

    let contents = fs::read_to_string(&fpath).unwrap();

    return Some(contents);
}

fn line_is_blank(line: &str) -> bool {
    if line.trim().len() == 0 {
        return true
    }
    return false
}

fn line_is_comment(line: &str) -> bool {
    let s = line.trim();
    if s.len() == 0 {
        return false
    }

    if s.chars().nth(0) == Some('/') && s.chars().nth(1) == Some('/'){
        return true
    }
    return false
}

fn line_is_eval_eq_rpn(ln_no: u64, line: &str) -> bool {
    let varname: LinePart = line_get_first(ln_no, line);
    let rpn_eq:  LinePart = varname.get_next();

    if varname.next.starts_with('(') {
        if line.contains('=') {
            // this is likely a multi-value return from a function call
            return true;
        }
    } else if varname.next.contains('(') {
        // otherwise, this is probably just a function call.
        return false;
    }

    match &rpn_eq.next[..] {
        "=" | "+=" | "-=" | "&=" | "|=" | "<<=" | ">>=" => {
            return true
        },
        _ => {},
    }

    return false
}

fn line_get_first(ln_no: u64, line: &str) -> LinePart {
    let mut next:    String = "".to_string();
    let mut rem:     String = "".to_string();
    let mut first:   bool   = true;
    let mut leading: bool   = true;
    let     part:    LinePart;

    let trimmed = line.trim();

    for c in trimmed.chars() {
        if first {
            // read in first word of line; stop on whitespace
            if c == ' ' || c == '\t' {
                first = false;
                continue;
            }
            next = format!("{}{}", next, c);
        } else if leading {
            // skip over whitespace between next and remainder
            if c == ' ' || c == '\t' {
                continue;
            }
            rem = format!("{}", c);
            leading = false
        } else {
            rem = format!("{}{}", rem, c);
        }
    }

    part = LinePart{ln_no, next, rem};
    return part
}

// returns true if it exits for an abnormal reason
fn process_source(s: String) -> bool {
    let     lines = s.lines();
    let mut ln_no: u64 = 0;
    let mut next: LinePart;

    // make sure defblock is initially inactive
    outputs::set_active_defblk("~");

    for line in lines {
        ln_no += 1;

        if line_is_blank(&line) {
            continue;
        }
        if line_is_comment(&line) {
            continue;
        }

        if outputs::defblk_is_active() {
            next = line_get_first(ln_no, &line);
            if next.is_endblk() {
                if process_endblk::now(next) {
                    return true;
                }
                continue;
            }

            if preproc::load_def(ln_no, &line) {
                return true;
            }
            continue;
        }

        let res_line: String;
        match preproc::resolve_line(ln_no, line) {
            Some(res) => {
                res_line = res.clone();
            },
            None => {
                return true;
            }
        }

        next = line_get_first(ln_no, &res_line);

        if next.is__asm() {
            if process__asm::now(next, &res_line) {
                return true;
            }
            continue;
        }

        if next.is_break() {
            if process_break::now(next) {
                return true;
            }
            continue;
        }
        if next.is_def() {
            if process_def::now(next, &res_line) {
                return true;
            }
            continue;
        }
        if next.is_continue() {
            if process_continue::now(next) {
                return true;
            }
            continue;
        }
        if line_is_eval_eq_rpn(ln_no, &res_line) {
            if process_eval_eq_rpn::now(next, &res_line) {
                return true;
            }
            continue;
        }

        if next.is_endblk() {
            if process_endblk::now(next) {
                return true;
            }
            continue;
        }
        if next.is_let() {
            if process_let::now(next) {
                return true;
            }
            continue;
        }
        if next.is_loop() {
            if process_loop::now(next) {
                return true;
            }
            continue;
        }
        if next.is_fn() {
            if process_fn::now(next, &res_line) {
                return true;
            }
            continue;
        }
        if next.is_for() {
            if process_for::now(next) {
                return true;
            }
            continue;
        }
        if next.is_if_rpn() {
            if process_if_rpn::now(next) {
                return true;
            }
            continue;
        }
        if next.is_file_method() {
            if process_methods_file::now(next, &res_line) {
                return true;
            }
            continue;
        }
        if next.is_return() {
            if process_return::now(next, &res_line) {
                return true;
            }
            continue;
        }

        if next.is_println() {
            if process_println::now(next, &res_line, None) {
                return true;
            }
            continue;
        }
        if next.is_while() {
            if process_while_rpn::now(next) {
                return true;
            }
            continue;
        }

        if next.is_fn_call() {
            //----------------------------------------------------------------//
            // This one needs to be last as it will match built-in functions. //
            //----------------------------------------------------------------//
            if process_fn_call::now(next, &res_line) {
                return true;
            }
            continue;
        }

        println!("!!![UNHANDLED] {}: {}", ln_no, &res_line);
    }

    outputs::write();
    return false;
}

pub fn process_vhl(cfg: runconfig::RunCfg) {
    let args: Vec<_> = env::args().collect();
    let source: Option<String>;
    let failed: bool;

    if args.len() == 1 {
        show_usage();
        return;
    }

    let platform: String = cfg.target.clone().unwrap();
    outputs::set_platform(&platform);

    let srcfile: String = cfg.srcfile.clone().unwrap();
    source = load_source_file(&srcfile);
    match source {
        None => { failed = true; },
        Some(source) => failed = process_source(source),
    }

    if failed {
        std::process::exit(1);
    }
    std::process::exit(0);
}
