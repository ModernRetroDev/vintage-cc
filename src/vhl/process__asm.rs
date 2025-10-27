use crate::vhl::array;
use crate::vhl::outputs;

use crate::vhl::line_part::LinePart;


fn get_first_str_arg(line: &str) -> Option<String> {
    let mut next:   String = "".to_string();
    let mut rem:    String = "".to_string();
    let mut skip:   bool   = true;
    let mut first:  bool   = true;
    let mut in_str: bool   = true;
    let     part:   LinePart;

    let trimmed = line.trim();

    for c in trimmed.chars() {
        if skip {
            if c == ' ' {
                continue;
            }
            if c.is_ascii_alphabetic() || c.is_ascii_digit() || c == '_' {
                continue;
            }
            if c == '(' {
                skip = false;
                first = true;
                continue;
            } else {
                return None;
            }
        }
        if first {
            // make sure the string starts with a double quote mark.
            if c != '"' {
                return None;
            }
            first = false;
            in_str = true;
            next.push(c);
        } else if in_str {
            // continue reading till the second double quote mark.
            next.push(c);
            if c == '"' {
                in_str = false;
                break;
            }
        } else {
            next.push(c);
        }
    }

    return Some(next)
}

fn as_simple(line: &str, ln_no: u64) -> bool {
    let value_str: String;  

    value_str = get_first_str_arg(line).unwrap();

    outputs::lines_main_push(&format!("   lang_asm {}", value_str));

    return false;
}

fn is_simple_line(line: &str) -> bool {
    let value_str: String;  

    match get_first_str_arg(line) {
        Some(next_part) => {
            // println!("next_part = `{}`", next_part);
            value_str = next_part.clone();
        },
        None => { return false; }
    }

    match value_str.find("{}") {
        Some(_) => { return false; },
        None => { return true; }
    }
}

pub fn now(part: LinePart, line: &str) -> bool {

    if is_simple_line(&line) {
        return as_simple(&line, part.ln_no);
    } else {
        println!(
            "ERROR: ln:{} LANG_ASM: Unhandled function variant.",
            part.ln_no);
        return true;
    }

    return false;
}
