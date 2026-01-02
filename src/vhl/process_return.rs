use crate::vhl::array;
use crate::vhl::fn_args;
use crate::vhl::outputs;

use crate::vhl::line_part::LinePart;

fn is_direct_deref(epart: &str) -> bool {
    return epart.contains("@:");
}

fn get_evalpart_basetype(ln_no: u64, epart: &str) -> Option<String> {
    if array::arg_is_array(epart) {
        match array::get_arraytype_basetype(ln_no, epart) {
            Some(btype) => {
                return Some(btype);
            },
            None => {
                return None;
            },
        }
    } else if epart.contains("@:") {
        match epart.find("@:") {
            Some(stop_ind) => {
                return Some(epart[..stop_ind].to_string());
            },
            None => {
                return None;
            }
        }
    } else {
        match outputs::get_vartype(epart) {
            Some(vtype) => {
                return Some(vtype);
            },
            None => {
                return None;
            },
        }
    }
}

fn get_return_vals(line: &str, ln_no: u64) -> Option<Vec<String>> {
    let mut fn_rets: Vec<String> = Vec::new();

    let mut multi:       bool   = false;
    let mut first:       bool   = true;
    let mut next_retval: String = "".to_string();
    let mut capture:     String = "retval".to_string();
    let mut skip:        bool   = true;

    let trimmed = line.trim();

    for c in trimmed.chars() {
        if skip {
            if c == 'n' {
                // start checking after the `n` from `return`.
                skip = false;
            }
            continue;
        }
        // else:
        if first {
            if c == ' ' || c == '\t' {
                continue;
            } else if c == '{' {
                return Some(fn_rets);
            }
            // else
            first = false;
        }

        if capture == "retval" {
            if c == ' ' || c == '\t' {
                if next_retval == "" {
                    // leading whitespace
                    continue;
                } else if multi {
                    println!(
                        "ERROR: ln:{} RETURN: Multi-return values must be separated by a `,` between each value.",
                        ln_no);
                    return None;
                } else {
                    fn_rets.push(next_retval.clone());
                    capture = "terminator".to_string();
                    first   = true;
                    continue;
                }
            } else if c == ';' {
                if multi {
                    println!(
                        "ERROR: ln:{} RETURN: Unexpected terminator in multi-value return; must end with `);`.",
                        ln_no);
                    return None;
                } else {
                    if next_retval == "" {
                        // this return has no return values
                        capture = "terminated".to_string();
                        break;
                    }
                    // end of a single return type
                    fn_rets.push(next_retval.clone());
                    capture = "terminated".to_string();
                    break;
                }
            } else if c == '(' {
                multi = true;
                if next_retval != "" {
                    println!(
                        "ERROR: ln:{} RETURN: For multi-return values; the `(` must occur first.",
                        ln_no);
                    return None;
                }
                continue;
            } else if c == ',' {
                if !multi {
                    println!(
                        "ERROR: ln:{} RETURN: Unexpected comma; multi-return values start with a `(`.",
                        ln_no);
                    return None;
                } else if next_retval == "" {
                    println!(
                        "ERROR: ln:{} RETURN: Empty/blank return value type provided.",
                        ln_no);
                    return None;
                } else {
                    // this should be a fine return value
                    fn_rets.push(next_retval.clone());
                    next_retval = "".to_string();
                    first         = true;
                }
            } else if c == ')' {
                if !multi {
                    println!(
                        "ERROR: ln:{} RETURN: Unexpected `)`; only used for multi-return values.",
                        ln_no);
                    return None;
                } else if next_retval == "" {
                    println!(
                        "ERROR: ln:{} RETURN: Empty/blank argument type provided.",
                        ln_no);
                    return None;
                } else {
                    // the final type of a multi-return function
                    fn_rets.push(next_retval.clone());
                    capture = "terminator".to_string();
                    first   = true;
                    continue;
                }
            } else {
                next_retval.push(c);
            }
        } else if capture == "terminator" {
            if c != ';' {
                println!(
                    "ERROR: ln:{} RETURN: Misisng line terminator.",
                    ln_no);
                return None;
            }
            capture = "terminated".to_string();
            break;
        }
    }
    if capture != "terminated" {
        println!(
            "ERROR: ln:{} RETURN: Misisng line terminator.",
            ln_no);
        return None;
    }

    return Some(fn_rets);
}

pub fn now(part: LinePart, line: &str) -> bool {
    let fn_name: String;
    let fn_rets: Vec<String>;

    let trimmed = line.trim();

    fn_name = outputs::get_active_fn();
    if fn_name == "".to_string() {
        println!(
            "ERROR: ln:{} Return can only be run within a function.",
            part.ln_no);
        return true;
    }

    fn_rets = match get_return_vals(line, part.ln_no) {
        Some(rets) => { rets },
        None => { return true; },
    };

    let provided_rets_count: u8 = fn_rets.len().try_into().unwrap();

    match outputs::get_required_fn_rets_count(&fn_name) {
        Some(req_rets) => {
            if req_rets != provided_rets_count {
                println!(
                    "ERROR: ln:{} RETURN: Function `{}` returns {} value(s); got {}.",
                    part.ln_no, fn_name, req_rets, provided_rets_count);
                return true;
            }
        },
        None => {
            println!(
                "ERROR: ln:{} RETURN: Failed to determine return vars for Function `{}`.",
                part.ln_no, fn_name);
            return true;
        }
    }

    outputs::lines_main_push(&format!("    # {}", trimmed));

    if provided_rets_count == 0 {
        outputs::lines_main_push("    return");
        outputs::lines_main_push("");
    } else {
        // println!("SET RETURN VALUES in FN `{}`", fn_name);
        let mut retvar_pos: usize = 0;
        while retvar_pos < provided_rets_count.into() {
            let ret_type = outputs::get_fn_ret_type_by_pos(
                &fn_name, retvar_pos).unwrap();

            let req_elem_sz: u8 = match &ret_type[..] {
                "u8"  => { 1 },
                "u16" => { 2 },
                "u24" => { 3 },
                "ptr" => { 2 },
                _     => {
                    println!(
                        "ERROR: ln:{} RETURN: Unsupported vartype `{}` in return.",
                        part.ln_no, ret_type);
                    return true;
                }
            };

            // get the evaluated return part and its associated type
            let epart: String = fn_rets[retvar_pos].clone();
            let epart_type: Option<String> = 
                get_evalpart_basetype(part.ln_no, &epart);
            let epart_ptr_str = match is_direct_deref(&epart) {
                true  => { "ptr".to_string() },
                false => {
                    match epart_type {
                        Some(ref epart_str) => {
                            if epart_str.ends_with(":ptr") {
                                "ptr".to_string()
                            } else {
                                "".to_string()
                            }
                        },
                        None => { "".to_string() },
                    }
                },
            };


            match epart_type {
                Some(vtype) => {
                    let resolved_arg: String;
                    if vtype == "u8" || vtype == "u8:ptr" || vtype == "char" {
                        if vtype == "u8:ptr" {
                            resolved_arg = epart.clone();
                        } else {
                            match fn_args::get_u8_value_str(part.ln_no, &epart, true) {
                                Some(u8val) => {
                                    resolved_arg = u8val.clone();
                                },
                                None => {
                                    println!("ERROR: ln:{} RETURN: Failed to get u8 value of `{}`",
                                        part.ln_no, epart);
                                    return true;
                                }
                            }
                        }

                        if req_elem_sz == 1 {
                            outputs::lines_main_push(
                                &format!("    equals__u8_u8{} ._ret_{} .{}", 
                                    epart_ptr_str, retvar_pos, resolved_arg));
                        } else if req_elem_sz == 2 {
                            outputs::lines_main_push(
                                &format!("    equals__u16_u8{} ._ret_{} .{}", 
                                    epart_ptr_str, retvar_pos, resolved_arg));
                        } else if req_elem_sz == 3 {
                            outputs::lines_main_push(
                                &format!("    equals__u24_u8{} ._ret_{} .{}", 
                                    epart_ptr_str, retvar_pos, resolved_arg));
                        } else {
                            println!(
                                "ERROR: ln:{} RETURN of element size `{}` not currently supported.",
                                part.ln_no, req_elem_sz);
                            return true;
                        }
                    } else if vtype == "u16" || vtype == "u16:ptr" {
                        if vtype == "u16:ptr" {
                            resolved_arg = epart.clone();
                        } else {
                            match fn_args::get_u16_value_str(part.ln_no, &epart, true) {
                                Some(u16val) => {
                                    resolved_arg = u16val.clone();
                                },
                                None => {
                                    println!("ERROR: ln:{} RETURN: Failed to get u16 value of `{}`",
                                        part.ln_no, epart);
                                    return true;
                                }
                            }
                        }

                        if req_elem_sz == 2 {
                            outputs::lines_main_push(
                                &format!("    equals__u16_u16{} ._ret_{} .{}", 
                                    epart_ptr_str, retvar_pos, resolved_arg));
                        } else if req_elem_sz == 3 {
                            outputs::lines_main_push(
                                &format!("    equals__u24_u16{} ._ret_{} .{}", 
                                    epart_ptr_str, retvar_pos, resolved_arg));
                        } else {
                            println!(
                                "ERROR: ln:{} RETURN of element size `{}` not currently supported.",
                                part.ln_no, req_elem_sz);
                            return true;
                        }
                    } else if vtype == "u24" || vtype == "u24:ptr" {
                        if vtype == "u24:ptr" {
                            resolved_arg = epart.clone();
                        } else {
                            match fn_args::get_u24_value_str(part.ln_no, &epart, true) {
                                Some(u24val) => {
                                    resolved_arg = u24val.clone();
                                },
                                None => {
                                    println!("ERROR: ln:{} RETURN: Failed to get u24 value of `{}`",
                                        part.ln_no, epart);
                                    return true;
                                }
                            }
                        }

                        if req_elem_sz == 3 {
                            outputs::lines_main_push(
                                &format!("    equals__u24_u24{} ._ret_{} .{}", 
                                    epart_ptr_str, retvar_pos, resolved_arg));
                        } else {
                            println!(
                                "ERROR: ln:{} RETURN of element size `{}` not currently supported.",
                                part.ln_no, req_elem_sz);
                            return true;
                        }
                    } else {
                        println!("ERROR: ln:{} RETURN: Unhandled vartype `{}` for `{}`.",
                            part.ln_no, vtype, &epart);
                        return true;
                    }
                },
                None => {
                    if fn_args::is_type_u8(part.ln_no, &epart, true) {
                        if req_elem_sz == 1 {
                            outputs::lines_main_push(
                                &format!("    equals__u8_u8 ._ret_{} {}", 
                                    retvar_pos, epart));
                        } else if req_elem_sz == 2 {
                            outputs::lines_main_push(
                                &format!("    equals__u16_u8 ._ret_{} {}", 
                                    retvar_pos, epart));
                        } else if req_elem_sz == 3 {
                            outputs::lines_main_push(
                                &format!("    equals__u24_u8 ._ret_{} {}", 
                                    retvar_pos, epart));
                        } else {
                            println!(
                                "ERROR: ln:{} RETURN of element size `{}` not currently supported.",
                                part.ln_no, req_elem_sz);
                            return true;
                        }
                    } else if fn_args::is_type_u16(part.ln_no, &epart, true) {
                        if req_elem_sz == 2 {
                            outputs::lines_main_push(
                                &format!("    equals__u16_u16 ._ret_{} {}", 
                                    retvar_pos, epart));
                        } else if req_elem_sz == 3 {
                            outputs::lines_main_push(
                                &format!("    equals__u24_u16 ._ret_{} {}", 
                                    retvar_pos, epart));
                        } else {
                            println!(
                                "ERROR: ln:{} RETURN of element size `{}` not currently supported.",
                                part.ln_no, req_elem_sz);
                            return true;
                        }
                    } else if fn_args::is_type_u24(part.ln_no, &epart, true) {
                        if req_elem_sz == 3 {
                            outputs::lines_main_push(
                                &format!("    equals__u24_u24 ._ret_{} {}", 
                                    retvar_pos, epart));
                        } else {
                            println!(
                                "ERROR: ln:{} RETURN of element size `{}` not currently supported.",
                                part.ln_no, req_elem_sz);
                            return true;
                        }
                    } else {
                        println!(
                            "ERROR: ln:{} RETURN: Unsupported variable/value `{}` in eval.",
                            part.ln_no, epart);
                        return true;
                    }
                }
            }
            retvar_pos += 1;
        }
        outputs::lines_main_push("    return");
        outputs::lines_main_push("");
    }

    return false;
}
