use crate::vhl::array;
use crate::vhl::outputs;

use crate::vhl::line_part::LinePart;


fn get_supplied_basetype(ln_no: u64, supplied: &str) -> Option<String> {
    let mut basetype: String = "".to_string();

    if array::arg_is_array(supplied) {
        match array::get_arraytype_basetype(ln_no, supplied) {
            Some(btype) => {
                basetype = btype.clone();
            },
            None => {},
        }
    } else if outputs::varname_is_fn_arg_in_active_fn(supplied) {
        basetype = outputs::get_fn_arg_type_by_name(
            &outputs::get_active_fn(), supplied).unwrap().clone();
    } else {
        match outputs::get_vartype(supplied) {
            Some(vtype) => {
                basetype = vtype.clone();
            },
            None => {},
        }
    }

    if basetype != "" {
        return Some(basetype);
    }

    if supplied.parse::<u8>().is_ok() {
        return Some("u8".to_string());
    } else if supplied.parse::<u16>().is_ok() {
        return Some("u16".to_string());
    }

    return None;
}

fn resolve_supplied_arg(ln_no: u64, supplied: &str) -> Option<String> {
    let resolved_arg: String;

    if array::arg_is_array(&supplied) {
        match array::get_value(ln_no, &supplied) {
            Some(temp_var) => {
                resolved_arg = format!(".{}", temp_var);
            },
            None => { return None },
        }
    } else if outputs::varname_is_fn_arg_in_active_fn(supplied) {
        resolved_arg = format!(".{}",
            outputs::get_fn_arg_varname_in_active_fn(supplied));
    } else if outputs::get_vartype(supplied).is_some() {
        resolved_arg = format!(".{}", supplied);
    } else {
        resolved_arg = supplied.to_string();
    }

    return Some(resolved_arg);
}

fn is_simple_fn_call(part: &LinePart) -> bool {
    let mut first_part:   String = "".to_string();
    let mut first_char:   bool   = false;
    let mut expect_paren: bool   = false;

    for c in part.next.chars() {
        if first_char {
            if !c.is_ascii_alphabetic() {
                return false;
            }
            first_part.push(c);
            first_char = false;
            continue;
        } else if expect_paren {
            if c != ')' {
                return false;
            }
            // else
            return true;
        }

        // else
        if c.is_ascii_alphabetic() || c.is_ascii_digit() || c == '_' {
            first_part.push(c);
            continue;
        }
        // else
        if c == '(' {
            first_part.push(c);
            expect_paren = true;
            continue;
        } else {
            return false;
        }
    }
    return false
}

fn is_fn_call_with_args(part: &LinePart) -> bool {
    let mut first_part:  String = "".to_string();
    let mut first_arg:   String = "".to_string();
    let mut first_char:  bool   = true;
    let mut expect_args: bool   = false;

    for c in part.next.chars() {
        if first_char {
            if !c.is_ascii_alphabetic() {
                return false;
            }
            first_part.push(c);
            first_char = false;
            continue;
        } else if expect_args {
            if c == ')' {
                if first_arg.len() == 0 {
                    return false;
                }
                return true;
            }
            // else
            first_arg.push(c);
            continue
        }

        // else
        if c.is_ascii_alphabetic() || c.is_ascii_digit() || c == '_' {
            first_part.push(c);
            continue;
        }
        // else
        if c == '(' {
            first_part.push(c);
            expect_args = true;
            continue;
        } else {
            return false;
        }
    }

    if first_arg.len() != 0 {
        return true;
    }
    return false;
}

fn as_simple_fn_call(part: &LinePart) -> bool {
    let mut fn_name:   String = "".to_string();
    let mut first_char:   bool   = false;

    for c in part.next.chars() {
        if first_char {
            if !c.is_ascii_alphabetic() {
                println!(
                    "ERROR: ln:{} FN_CALL: fn_names must start with alpha char; got `{}`.",
                    part.ln_no, c);
                return true;
            }
            fn_name.push(c);
            first_char = false;
            continue;
        }

        // else
        if c.is_ascii_alphabetic() || c.is_ascii_digit() || c == '_' {
            fn_name.push(c);
            continue;
        }
        // else
        if c == '(' {
            // end of function name
            break;
        } else {
            println!(
                "ERROR: ln:{} FN_CALL: Unexpected char `{}` in fn_name.",
                part.ln_no, c);
            return true;
        }
    }

    if !part.next.ends_with(';') {
        println!(
            "ERROR: ln:{} FN_CALL: line is missing a trailing semicolon.",
            part.ln_no);
        return true;
    }

    if !outputs::fn_is_defined(&fn_name) {
        println!(
            "ERROR: ln:{} FN_CALL: Function `{}` is undefined.",
            part.ln_no, fn_name);
        return true;
    }
    if outputs::get_active_fn() == fn_name {
        println!(
            "ERROR: ln:{} FN_CALL: Recursive function calls not allowed.",
            part.ln_no);
        return true;
    }
    match outputs::get_required_fn_arg_count(&fn_name) {
        Some(req_args) => {
            if req_args != 0 {
                println!(
                    "ERROR: ln:{} FN_CALL: Function `{}` requires {} args; got 0.",
                    part.ln_no, fn_name, req_args);
                return true;
            }
        },
        None => {
            println!(
                "ERROR: ln:{} FN_CALL: Failed to determine required args for Function `{}`.",
                part.ln_no, fn_name);
            return true;
        }
    }

    // otherwise we should be good to go.
    outputs::lines_main_push(&format!("    call {}", fn_name));
    outputs::lines_main_push("");

    return false
}

fn as_fn_call_with_args(line: &str, ln_no: u64) -> bool {
    let mut fn_name:     String = "".to_string();
    let mut next_arg:    String = "".to_string();
    let mut first_char:  bool   = false;
    let mut expect_arg:  bool   = false;
    let mut expect_term: bool   = false;
    let mut fn_args: Vec<String> = Vec::new();

    let trimmed = line.trim();
    for c in trimmed.chars() {
        if first_char {
            if !c.is_ascii_alphabetic() {
                println!(
                    "ERROR: ln:{} FN_CALL: fn_names must start with alpha char; got `{}`.",
                    ln_no, c);
                return true;
            }
            fn_name.push(c);
            first_char = false;
            continue;
        } else if expect_arg {
            if c == ',' {
                let trimmed_arg = next_arg.trim();
                if trimmed_arg.len() == 0 {
                    println!(
                        "ERROR: ln:{} FN_CALL: Expected argument, got `,`.",
                        ln_no);
                    return true;
                }
                // else:
                fn_args.push(trimmed_arg.to_string());
                next_arg = "".to_string();
                continue;
            } else if c == ')' {
                let trimmed_arg = next_arg.trim();
                if trimmed_arg.len() == 0 {
                    println!(
                        "ERROR: ln:{} FN_CALL: Expected argument, got `)`.",
                        ln_no);
                    return true;
                }
                // else:
                fn_args.push(trimmed_arg.to_string());
                expect_arg  = false;
                expect_term = true;
                continue;
            }
            // else:
            next_arg.push(c);
            continue;

        } else if expect_term {
            if c == ' ' || c == '\t' {
                continue;
            } else if c == ';' {
                // looks like a standard terminator; break now
                expect_term = false;
                break;
            } else {
                println!(
                    "ERROR: ln:{} FN_CALL: Expected line terminator; got `{}`.",
                    ln_no, c);
                return true;
            }
        }

        // else
        if c.is_ascii_alphabetic() || c.is_ascii_digit() || c == '_' {
            fn_name.push(c);
            continue;
        }
        // else
        if c == '(' {
            // end of function name
            expect_arg = true;
            continue;
        } else {
            println!(
                "ERROR: ln:{} FN_CALL: Unexpected char `{}` in fn_name.",
                ln_no, c);
            return true;
        }
    }

    if expect_term {
        println!(
            "ERROR: ln:{} FN_CALL: Line is missing a trailing line terminator.",
            ln_no);
        return true;
    }

    if !outputs::fn_is_defined(&fn_name) {
        println!(
            "ERROR: ln:{} FN_CALL: Function `{}` is undefined.",
            ln_no, fn_name);
        return true;
    }
    if outputs::get_active_fn() == fn_name {
        println!(
            "ERROR: ln:{} FN_CALL: Recursive function calls not allowed.",
            ln_no);
        return true;
    }

    let provided_arg_count: u8 = fn_args.len().try_into().unwrap();

    match outputs::get_required_fn_arg_count(&fn_name) {
        Some(req_args) => {
            if req_args != provided_arg_count {
                println!(
                    "ERROR: ln:{} FN_CALL: Function `{}` requires {} args; got {}.",
                    ln_no, fn_name, req_args, provided_arg_count);
                return true;
            }
        },
        None => {
            println!(
                "ERROR: ln:{} FN_CALL: Failed to determine required args for Function `{}`.",
                ln_no, fn_name);
            return true;
        }
    }

    let mut arg_ctr: usize = 0;
    for arg in &fn_args {
        // println!("ARG[?] = `{}`", arg);
        let supplied_type: String = match get_supplied_basetype(ln_no, arg) {
            Some(btype) => {
                if btype.starts_with("str8;") {
                    "str".to_string()
                } else if btype.starts_with("str16;") {
                    "str".to_string()
                } else {
                    btype
                }
            },
            None => {
                println!(
                    "ERROR: ln:{} FN_CALL: Unable to determine type for `{}`.",
                    ln_no, arg);
                return true;
            }
        };

        let fn_argname: String = outputs::get_fn_arg_varname_by_pos(
            &fn_name, arg_ctr).unwrap();
        let next_argtype: String = outputs::get_fn_arg_type_by_pos(
            &fn_name, arg_ctr).unwrap();
        let resolved_arg: String = resolve_supplied_arg(ln_no, arg).unwrap();

        outputs::lines_main_push(&format!(
            "    equals__{}_{} .{}.{} {}", 
            next_argtype, supplied_type, fn_name, fn_argname, resolved_arg));
        arg_ctr += 1;
    }

    // otherwise we should be good to go.
    outputs::lines_main_push(&format!("    call {}", fn_name));
    outputs::lines_main_push("");

    return false
}

pub fn now(part: LinePart, line: &str) -> bool {

    outputs::lines_main_push(&format!("    # {}", line.trim()));

    if is_simple_fn_call(&part) {
        return as_simple_fn_call(&part);
    } else if is_fn_call_with_args(&part) {
        return as_fn_call_with_args(line, part.ln_no);
    } else {
        println!(
            "ERROR: ln:{} FN_CALL: Unsupported type of function call.",
            part.ln_no);
        return true;
    }
}
