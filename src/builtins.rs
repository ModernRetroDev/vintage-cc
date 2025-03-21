#![allow(static_mut_refs)]

use crate::outputs;

use std::env;
use std::fs;
use std::path::Path;

static mut USED_BUILTIN_FNS: Vec<String> = Vec::new();


fn get_builtin_path() -> Option<String> {
    let builtin_path: String;

    match env::var("VINTAGECC_BUILTINS_PATH") {
        Ok(bpath) => {
            builtin_path = bpath.to_string();
        },
        Err(_) => {
            builtin_path = "builtin".to_string();
        }
    }

    if !Path::new(&builtin_path).exists() {
        println!("ERROR: Built-in source path `{}` does not exist.",
            builtin_path);
        println!(" ... Consider setting envvar `VINTAGECC_BUILTINS_PATH`.");
        return None;
    }

    return Some(builtin_path);
}

fn get_fn_requirements(fnname: &str) -> Option<Vec<String>> {
    //------------------------------------------------------------------------//
    // Get list of other built-in functions required for this one.            //
    //------------------------------------------------------------------------//
    let mut reqs: Vec<String> = Vec::new();
    let     fpath: String;

    match get_builtin_path() {
        Some(bpath) => {
            fpath = format!("{}/{}/6502/{}.s", 
                bpath, outputs::get_platform(), fnname);
        },
        None => {
            return None;
        }
    }

    if !Path::new(&fpath).exists() {
        println!("ERROR: Built-in source file `{}` does not exist.", fpath);
        return None;
    }

    let contents = fs::read_to_string(&fpath).unwrap();
    let lines = contents.lines();

    for line in lines {
        let trimmed = line.trim();
        if trimmed == ";[BUILTIN-BLOCK-START]".to_string() {
            break;
        }
        if trimmed.starts_with(";REQUIRES ") {
            let reqname_raw = &trimmed[9..];
            let reqname = reqname_raw.trim();
            reqs.push(reqname.to_string());
        }
    }

    if reqs.len() > 0 {
        return Some(reqs)
    }

    return None
}

fn get_fn_lines(fnname: &str) -> Option<Vec<String>> {
    //------------------------------------------------------------------------//
    // Get list of other built-in functions required for this one.            //
    //------------------------------------------------------------------------//
    let mut fn_lines: Vec<String> = Vec::new();
    let mut extract_lns: bool = false;
    let     fpath: String;

    match get_builtin_path() {
        Some(bpath) => {
            fpath = format!("{}/{}/6502/{}.s", 
                bpath, outputs::get_platform(), fnname);
        },
        None => {
            return None;
        }
    }

    if !Path::new(&fpath).exists() {
        println!("ERROR: Built-in source file `{}` does not exist.", fpath);
        return None;
    }

    let contents = fs::read_to_string(&fpath).unwrap();
    let lines = contents.lines();

    for line in lines {
        let trimmed = line.trim();
        if extract_lns {
            fn_lines.push(line.to_string());
        } else if trimmed == ";[BUILTIN-BLOCK-START]".to_string() {
            extract_lns = true;
        }
    }

    return Some(fn_lines);
}

pub fn mark_as_used(fnname: &str) {
    let mut present: bool = false;
    unsafe {
        for used in USED_BUILTIN_FNS.iter() {
            if *used == fnname.to_string() {
                present = true;
                break;
            }
        }

        if !present {
            USED_BUILTIN_FNS.push(fnname.to_string());
        }
    }
}

pub fn mark_required() {
    //------------------------------------------------------------------------//
    // Process the list of built-in functions in use; make sure that any      //
    // other built-in function required for these are also added.             //
    //------------------------------------------------------------------------//
    unsafe {
        for fn_name in USED_BUILTIN_FNS.iter() {
            match get_fn_requirements(fn_name) {
                Some(reqs) => {
                    for req in reqs {
                        mark_as_used(&req);
                    }
                },
                None => {},
            }
        }
    }
    //------------------------------------------------------------------------//
    // Sort the remaining list of built-in functions.                         //
    //------------------------------------------------------------------------//
}

pub fn process() -> bool {
    unsafe {
        USED_BUILTIN_FNS.sort();
        for fn_name in USED_BUILTIN_FNS.clone() {
            outputs::builtin_append(&format!(".global _{}", &fn_name));
        }
        outputs::builtin_append("");
        outputs::builtin_append("");

        for fn_name in USED_BUILTIN_FNS.clone() {
            match get_fn_lines(&fn_name) {
                Some(lines) => {
                    for ln in lines {
                        outputs::builtin_append(&ln);
                    }
                    outputs::builtin_append("");
                    outputs::builtin_append("");
                },
                None => {
                    // error case...
                    return true
                }
            }
        }
    }
    return false
}