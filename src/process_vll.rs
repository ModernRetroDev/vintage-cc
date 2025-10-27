use std::env;
use std::fs;
use std::path::Path;

use crate::vll::line_part::LinePart;

use crate::vll::builtins;
use crate::vll::process_arr8;
use crate::vll::process_arr16;
use crate::vll::process_break;
use crate::vll::process_call;
use crate::vll::process_close;
use crate::vll::process_else;
use crate::vll::process_endif;
use crate::vll::process_endloop;
use crate::vll::process_equals;
use crate::vll::process_equals_not;
use crate::vll::process_eval_eq;
use crate::vll::process_eval_neq;
use crate::vll::process_eval_logi_and;
use crate::vll::process_eval_lt;
use crate::vll::process_eval_lteq;
use crate::vll::process_eval_gt;
use crate::vll::process_eval_gteq;
use crate::vll::process_fn;
use crate::vll::process_get_alloc;
use crate::vll::process_get_length;
use crate::vll::process_goto;
use crate::vll::process_if;
use crate::vll::process_increment;
use crate::vll::process_label;
use crate::vll::process_lang_asm;
use crate::vll::process_load;
use crate::vll::process_loop;
use crate::vll::process_lshift;
use crate::vll::process_minus_equals;
use crate::vll::process_open;
use crate::vll::process_plus_equals;
use crate::vll::process_print;
use crate::vll::process_ref;
use crate::vll::process_rshift;
use crate::vll::process_setout;
use crate::vll::process_setup;
use crate::vll::process_shutdown;
use crate::vll::process_store;
use crate::vll::process_var;
use crate::vll::outputs;



fn show_usage() {
	println!("Usage: vintagecc FILE");
	println!();
}

fn load_source_file(fpath: &str) -> Option<String> {
    if !Path::new(fpath).exists() {
        println!("ERROR: Source file `{}` does not exist.", fpath);
        return None;
    }

	if fpath.ends_with(".vll") {
		let stop = fpath.len() - 4;
		let outpath = format!("{}.s", &fpath[0..stop]);
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

	if s.chars().nth(0) == Some('#') {
		return true
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
fn process_source(s: String) {
	let     lines = s.lines();
	let mut ln_no: u64 = 0;
	let mut next: LinePart;

	for line in lines {
		ln_no += 1;

		if line_is_blank(&line) {
			continue;
		}
		if line_is_comment(&line) {
			continue;
		}

		next = line_get_first(ln_no, line);

		if next.is_arr8() {
			if process_arr8::now(next) {
				return;
			}
			continue;
		}
		if next.is_arr16() {
			if process_arr16::now(next) {
				return;
			}
			continue;
		}
		if next.is_break() {
			if process_break::now(next) {
				return;
			}
			continue;
		}
		if next.is_call() {
			if process_call::now(next) {
				return;
			}
			continue;
		}
		if next.is_close() {
			if process_close::now(next) {
				return;
			}
			continue;
		}
		if next.is_else() {
			if process_else::now(next) {
				return;
			}
			continue;
		}
		if next.is_endfn() {
			// println!("  ^^^^^ endfn");
			continue;
		}
		if next.is_endif() {
			if process_endif::now(next) {
				return;
			}
			continue;
		}
		if next.is_endloop() {
			if process_endloop::now(next) {
				return;
			}
			continue;
		}
		if next.is_eval_eq() {
			if process_eval_eq::now(next) {
				return;
			}
			continue;
		}
		if next.is_eval_neq() {
			if process_eval_neq::now(next) {
				return;
			}
			continue;
		}
		if next.is_eval_logi_and() {
			if process_eval_logi_and::now(next) {
				return;
			}
			continue;
		}
		if next.is_eval_lt() {
			if process_eval_lt::now(next) {
				return;
			}
			continue;
		}
		if next.is_eval_lteq() {
			if process_eval_lteq::now(next) {
				return;
			}
			continue;
		}
		if next.is_eval_gteq() {
			if process_eval_gteq::now(next) {
				return;
			}
			continue;
		}
		if next.is_eval_gt() {
			if process_eval_gt::now(next) {
				return;
			}
			continue;
		}
		if next.is_equals() {
			if process_equals::now(next) {
				return;
			}
			continue;
		}
		if next.is_equals_not() {
			if process_equals_not::now(next) {
				return;
			}
			continue;
		}
		if next.is_fn() {
			if process_fn::now(next) {
				return;
			}
			continue;
		}
		if next.is_get_alloc() {
			if process_get_alloc::now(next) {
				return;
			}
			continue;
		}
		if next.is_get_length() {
			if process_get_length::now(next) {
				return;
			}
			continue;
		}
		if next.is_goto() {
			if process_goto::now(next) {
				return;
			}
			continue;
		}
		if next.is_if() {
			if process_if::now(next) {
				return;
			}
			continue;
		}
		if next.is_increment() {
			if process_increment::now(next) {
				return;
			}
			continue;
		}
		if next.is_label() {
			if process_label::now(next) {
				return;
			}
			continue;
		}
		if next.is_lang_asm() {
			if process_lang_asm::now(next) {
				return;
			}
			continue;
		}
		if next.is_load() {
			if process_load::now(next) {
				return;
			}
			continue;
		}
		if next.is_loop() {
			if process_loop::now(next) {
				return;
			}
			continue;
		}
		if next.is_lshift() {
			if process_lshift::now(next) {
				return;
			}
			continue;
		}
		if next.is_minus_equals() {
			if process_minus_equals::now(next) {
				return;
			}
			continue;
		}
		if next.is_open() {
			if process_open::now(next) {
				return;
			}
			continue;
		}
		if next.is_plus_equals() {
			if process_plus_equals::now(next) {
				return;
			}
			continue;
		}
		if next.is_print() {
			if process_print::now(next) {
				return;
			}
			continue;
		}
		if next.is_ref() {
			if process_ref::now(next) {
				return;
			}
			continue;
		}
		if next.is_rshift() {
			if process_rshift::now(next) {
				return;
			}
			continue;
		}
		if next.is_setout() {
			if process_setout::now(next) {
				return;
			}
			continue;
		}
		if next.is_setup() {
			if process_setup::now(next) {
				return;
			}
			continue;
		}
		if next.is_shutdown() {
			if process_shutdown::now(next) {
				return;
			}
			continue;
		}
		if next.is_store() {
			if process_store::now(next) {
				return;
			}
			continue;
		}
		if next.is_var() {
			if process_var::now(next) {
				return;
			}
			continue;
		}

		println!("!!![UNHANDLED] {}: {}", ln_no, line);
	}

	builtins::mark_required();
	if builtins::process() {
		return;
	}

	if outputs::process() {
		return
	}
	outputs::write();
}

pub fn process_vll() {
	let args: Vec<_> = env::args().collect();
	let source: Option<String>;

	if args.len() == 1 {
		show_usage();
		return;
	}

	outputs::set_platform("x16");

	source = load_source_file(&args[1]);
	match source {
		None => return,
		Some(source) => process_source(source),
	}
}
