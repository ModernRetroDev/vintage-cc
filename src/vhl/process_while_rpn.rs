use crate::vhl::array;
use crate::vhl::fn_args;
use crate::vhl::outputs;

use crate::vhl::line_part::LinePart;


fn eval_part_is_op(part: &str) -> bool {
    match part {
        "+"  => { return true },
        "-"  => { return true },
        "|"  => { return true },
        "&"  => { return true },
        "<<" => { return true },
        ">>" => { return true },
        "<"  => { return true },
        ">"  => { return true },
        "<=" => { return true },
        ">=" => { return true },
        "==" => { return true },
        "!=" => { return true },
        "&&" => { return true },
        "||" => { return true },
        _ => { return false }
    }
}

fn is_direct_deref(epart: &str) -> bool {
    return epart.contains("@:");
}

fn is_valid_loop_label(loop_lbl: &str) -> bool {
    if !loop_lbl.starts_with("@") {
        return false;
    }
    if loop_lbl.len() <= 1 {
        return false;
    }
    if ! loop_lbl.chars().nth(1).unwrap().is_alphabetic() {
        return false;
    }

    for next in loop_lbl[2..].chars() {
        if next.is_alphabetic() {
            continue;
        }
        if next.is_digit(10) {
            continue;
        }
        if next == '_' {
            continue;
        }
        // else; invalid character
        return false;
    }

    return true;
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

pub fn now(part: LinePart) -> bool {
    let mut next:        LinePart;
    let mut eval_parts:  Vec<String>  = Vec::new();
    let mut loop_label:  Option<String> = None;
    let mut cur_stk_sz:  u8 = 0;
    let mut req_stk_sz:  u8 = 0;
    let mut req_elem_sz: u8 = 1;

    next = part.clone();
    if next.next != "while" {
        println!(
            "ERROR: ln:{} Expected `while` got `{}`.",
            part.ln_no, next.next);
        return true;
    }

    loop {
        next = next.get_next();
        if next.next == "" {
            break
        }
        if next.next == "{" {
            // check for a loop label
            next = next.get_next();

            if next.next == "" {
                // In this case, the `{` was the final entry
            } else if !next.next.starts_with("@") {
                println!(
                    "ERROR: ln:{} Loop labels must start with an `@` char; got `{}`.",
                    part.ln_no, next.next.chars().nth(0).unwrap());
                return true;
            } else if is_valid_loop_label(&next.next) {
                loop_label = Some(next.next[1..].to_string());

            } else {
                println!(
                    "ERROR: ln:{} Invalid loop label provided; got `{}`.",
                    part.ln_no, &next.next);
                return true;
            }
            break;
        } else if next.next.ends_with("{") {
            println!(
                "ERROR: ln:{} There must be at least one space between final operand and `{{`.",
                part.ln_no);
            return true;
        }

        eval_parts.push(next.next.clone());
    }

    //------------------------------------------------------------------------//
    // Determine the stack size required to accomplish this calculation.      //
    //------------------------------------------------------------------------//
    for epart in &eval_parts {
        if eval_part_is_op(&epart) {
            if req_stk_sz == 0 {
                println!(
                    "ERROR: ln:{} Operations can't be at start of RPN eval; got `{}`.",
                    part.ln_no, epart);
                return true;
            }
            cur_stk_sz -= 1;
        } else {
            cur_stk_sz += 1;
            if cur_stk_sz > req_stk_sz {
                req_stk_sz += 1;
            }
        }
    }

    //------------------------------------------------------------------------//
    // Determine the element size required to accomplish this calculation.    //
    //------------------------------------------------------------------------//
    for epart in &eval_parts {
        if eval_part_is_op(&epart) {
            continue;
        }

        let epart_type: Option<String> = 
            get_evalpart_basetype(part.ln_no, &epart);

        match epart_type {
            Some(vtype) => {
                if vtype == "u16" || vtype == "u16:ptr"  {
                    if req_elem_sz < 2 {
                        req_elem_sz = 2;
                    }
                } else if vtype == "u24" || vtype == "u24:ptr" {
                    if req_elem_sz < 3 {
                        req_elem_sz = 3;
                    }
                }
            },
            None => {
                if fn_args::is_type_u8(part.ln_no, epart, true) {
                } else if fn_args::is_type_u16(part.ln_no, epart, true) {
                    if req_elem_sz < 2 {
                        req_elem_sz = 2;
                    }
                } else if fn_args::is_type_u24(part.ln_no, epart, true) {
                    if req_elem_sz < 3 {
                        req_elem_sz = 3;
                    }
                } else {
                    println!(
                        "ERROR: ln:{} Unsupported variable/value `{}` in eval.",
                        part.ln_no, epart);
                    return true;
                }
            }
        }
    }

    outputs::set_cmpres_in_active_fn();
    outputs::update_active_fn_stack(req_stk_sz, req_elem_sz);

    //------------------------------------------------------------------------//
    // Create the evaluation operations (in order)                            //
    //------------------------------------------------------------------------//
    let stk_basename: String = match req_elem_sz {
        1 => {
            "_stk_8".to_string()
        },
        2 => {
            "_stk_16".to_string()
        },
        3 => {
            "_stk_24".to_string()
        },
        _ => {
            println!(
                "ERROR: ln:{} Stack elements of size `{}` not currently supported.",
                part.ln_no, req_elem_sz);
            return true;
        }
    };


    match loop_label {
        Some(label) => {
            outputs::blktypes_push(&format!("loop:{}", label));
        },
        None => {
            outputs::blktypes_push("loop");
        }
    }

    outputs::lines_main_push(&format!("    # while {}", part.rem));
    outputs::lines_main_push(         "    loop");

    cur_stk_sz = 0;
    for epart in &eval_parts {
        if eval_part_is_op(&epart) {
            if cur_stk_sz < 2 {
                println!(
                    "ERROR: ln:{} Operation `{}` not permitted on current stack of size`{}`.",
                    part.ln_no, &epart, cur_stk_sz);
                return true;
            }
            let stk_prev: u8 = cur_stk_sz -2;
            let stk_cur:  u8 = cur_stk_sz -1;
            match &epart[..] {
                "+" => {
                    match req_elem_sz {
                        1 => {
                            outputs::lines_main_push(
                                &format!("    plus_equals__u8_u8 .{}_{} .{}_{}", 
                                    stk_basename, stk_prev,
                                    stk_basename, stk_cur));
                        },
                        2 => {
                            outputs::lines_main_push(
                                &format!("    plus_equals__u16_u16 .{}_{} .{}_{}", 
                                    stk_basename, stk_prev,
                                    stk_basename, stk_cur));
                        },
                        3 => {
                            outputs::lines_main_push(
                                &format!("    plus_equals__u24_u24 .{}_{} .{}_{}", 
                                    stk_basename, stk_prev,
                                    stk_basename, stk_cur));
                        },
                        _ => {
                            println!(
                                "ERROR: ln:{} Stack elements of size `{}` not currently supported (2*).",
                                part.ln_no, req_elem_sz);
                            return true;
                        }
                    }
                },
                "-" => {
                    match req_elem_sz {
                        1 => {
                            outputs::lines_main_push(
                                &format!("    minus_equals__u8_u8 .{}_{} .{}_{}", 
                                    stk_basename, stk_prev,
                                    stk_basename, stk_cur));
                        },
                        2 => {
                            outputs::lines_main_push(
                                &format!("    minus_equals__u16_u16 .{}_{} .{}_{}", 
                                    stk_basename, stk_prev,
                                    stk_basename, stk_cur));
                        },
                        3 => {
                            outputs::lines_main_push(
                                &format!("    minus_equals__u24_u24 .{}_{} .{}_{}", 
                                    stk_basename, stk_prev,
                                    stk_basename, stk_cur));
                        },
                        _ => {
                            println!(
                                "ERROR: ln:{} Stack elements of size `{}` not currently supported (2*).",
                                part.ln_no, req_elem_sz);
                            return true;
                        }
                    }
                },
                "|" => {
                    match req_elem_sz {
                        1 => {
                            outputs::lines_main_push(
                                &format!("    bitwise_or__u8 .{}_{} .{}_{}", 
                                    stk_basename, stk_prev,
                                    stk_basename, stk_cur));
                        },
                        2 => {
                            outputs::lines_main_push(
                                &format!("    bitwise_or__u16 .{}_{} .{}_{}", 
                                    stk_basename, stk_prev,
                                    stk_basename, stk_cur));
                        },
                        3 => {
                            outputs::lines_main_push(
                                &format!("    bitwise_or__u24 .{}_{} .{}_{}", 
                                    stk_basename, stk_prev,
                                    stk_basename, stk_cur));
                        },
                        _ => {
                            println!(
                                "ERROR: ln:{} Stack elements of size `{}` not currently supported (2*).",
                                part.ln_no, req_elem_sz);
                            return true;
                        }
                    }
                },
                "&" => {
                    match req_elem_sz {
                        1 => {
                            outputs::lines_main_push(
                                &format!("    bitwise_and__u8 .{}_{} .{}_{}", 
                                    stk_basename, stk_prev,
                                    stk_basename, stk_cur));
                        },
                        2 => {
                            outputs::lines_main_push(
                                &format!("    bitwise_and__u16 .{}_{} .{}_{}", 
                                    stk_basename, stk_prev,
                                    stk_basename, stk_cur));
                        },
                        3 => {
                            outputs::lines_main_push(
                                &format!("    bitwise_and__u24 .{}_{} .{}_{}", 
                                    stk_basename, stk_prev,
                                    stk_basename, stk_cur));
                        },
                        _ => {
                            println!(
                                "ERROR: ln:{} Stack elements of size `{}` not currently supported (2*).",
                                part.ln_no, req_elem_sz);
                            return true;
                        }
                    }
                },
                "<<" => {
                    match req_elem_sz {
                        1 => {
                            outputs::lines_main_push(
                                &format!("    lshift__u8_n .{}_{} .{}_{}", 
                                    stk_basename, stk_prev,
                                    stk_basename, stk_cur));
                        },
                        2 => {
                            outputs::lines_main_push(
                                &format!("    lshift__u16_n .{}_{} .{}_{}", 
                                    stk_basename, stk_prev,
                                    stk_basename, stk_cur));
                        },
                        3 => {
                            outputs::lines_main_push(
                                &format!("    lshift__u24_n .{}_{} .{}_{}", 
                                    stk_basename, stk_prev,
                                    stk_basename, stk_cur));
                        },
                        _ => {
                            println!(
                                "ERROR: ln:{} Stack elements of size `{}` not currently supported (2*).",
                                part.ln_no, req_elem_sz);
                            return true;
                        }
                    }
                },
                ">>" => {
                    match req_elem_sz {
                        1 => {
                            outputs::lines_main_push(
                                &format!("    rshift__u8_n .{}_{} .{}_{}", 
                                    stk_basename, stk_prev,
                                    stk_basename, stk_cur));
                        },
                        2 => {
                            outputs::lines_main_push(
                                &format!("    rshift__u16_n .{}_{} .{}_{}", 
                                    stk_basename, stk_prev,
                                    stk_basename, stk_cur));
                        },
                        3 => {
                            outputs::lines_main_push(
                                &format!("    rshift__u24_n .{}_{} .{}_{}", 
                                    stk_basename, stk_prev,
                                    stk_basename, stk_cur));
                        },
                        _ => {
                            println!(
                                "ERROR: ln:{} Stack elements of size `{}` not currently supported (2*).",
                                part.ln_no, req_elem_sz);
                            return true;
                        }
                    }
                },
                "<" => {
                    match req_elem_sz {
                        1 => {
                            outputs::lines_main_push(
                                &format!("    eval_lt__u8 .{}_{} .{}_{} .{}_{}", 
                                    stk_basename, stk_prev,
                                    stk_basename, stk_prev,
                                    stk_basename, stk_cur));
                        },
                        2 => {
                            outputs::lines_main_push(
                                &format!("    eval_lt__u16 ._cmpres .{}_{} .{}_{}", 
                                    stk_basename, stk_prev,
                                    stk_basename, stk_cur));
                            outputs::lines_main_push(
                                &format!("    equals__u16_bool .{}_{} ._cmpres", 
                                    stk_basename, stk_prev));
                        },
                        3 => {
                            outputs::lines_main_push(
                                &format!("    eval_lt__u24 ._cmpres .{}_{} .{}_{}", 
                                    stk_basename, stk_prev,
                                    stk_basename, stk_cur));
                            outputs::lines_main_push(
                                &format!("    equals__u24_bool .{}_{} ._cmpres", 
                                    stk_basename, stk_prev));
                        },
                        _ => {
                            println!(
                                "ERROR: ln:{} Stack elements of size `{}` not currently supported (2*).",
                                part.ln_no, req_elem_sz);
                            return true;
                        }
                    }
                },
                ">" => {
                    match req_elem_sz {
                        1 => {
                            outputs::lines_main_push(
                                &format!("    eval_gt__u8 .{}_{} .{}_{} .{}_{}", 
                                    stk_basename, stk_prev,
                                    stk_basename, stk_prev,
                                    stk_basename, stk_cur));
                        },
                        2 => {
                            outputs::lines_main_push(
                                &format!("    eval_gt__u16 ._cmpres .{}_{} .{}_{}", 
                                    stk_basename, stk_prev,
                                    stk_basename, stk_cur));
                            outputs::lines_main_push(
                                &format!("    equals__u16_bool .{}_{} ._cmpres", 
                                    stk_basename, stk_prev));
                        },
                        3 => {
                            outputs::lines_main_push(
                                &format!("    eval_gt__u24 ._cmpres .{}_{} .{}_{}", 
                                    stk_basename, stk_prev,
                                    stk_basename, stk_cur));
                            outputs::lines_main_push(
                                &format!("    equals__u24_bool .{}_{} ._cmpres", 
                                    stk_basename, stk_prev));
                        },
                        _ => {
                            println!(
                                "ERROR: ln:{} Stack elements of size `{}` not currently supported (2*).",
                                part.ln_no, req_elem_sz);
                            return true;
                        }
                    }
                },
                "<=" => {
                    match req_elem_sz {
                        1 => {
                            outputs::lines_main_push(
                                &format!("    eval_lteq__u8 .{}_{} .{}_{} .{}_{}", 
                                    stk_basename, stk_prev,
                                    stk_basename, stk_prev,
                                    stk_basename, stk_cur));
                        },
                        2 => {
                            outputs::lines_main_push(
                                &format!("    eval_lteq__u16 ._cmpres .{}_{} .{}_{}", 
                                    stk_basename, stk_prev,
                                    stk_basename, stk_cur));
                            outputs::lines_main_push(
                                &format!("    equals__u16_bool .{}_{} ._cmpres", 
                                    stk_basename, stk_prev));
                        },
                        3 => {
                            outputs::lines_main_push(
                                &format!("    eval_lteq__u24 ._cmpres .{}_{} .{}_{}", 
                                    stk_basename, stk_prev,
                                    stk_basename, stk_cur));
                            outputs::lines_main_push(
                                &format!("    equals__u24_bool .{}_{} ._cmpres", 
                                    stk_basename, stk_prev));
                        },
                        _ => {
                            println!(
                                "ERROR: ln:{} Stack elements of size `{}` not currently supported (2*).",
                                part.ln_no, req_elem_sz);
                            return true;
                        }
                    }
                },
                ">=" => {
                    match req_elem_sz {
                        1 => {
                            outputs::lines_main_push(
                                &format!("    eval_gteq__u8 .{}_{} .{}_{} .{}_{}", 
                                    stk_basename, stk_prev,
                                    stk_basename, stk_prev,
                                    stk_basename, stk_cur));
                        },
                        2 => {
                            outputs::lines_main_push(
                                &format!("    eval_gteq__u16 ._cmpres .{}_{} .{}_{}", 
                                    stk_basename, stk_prev,
                                    stk_basename, stk_cur));
                            outputs::lines_main_push(
                                &format!("    equals__u16_bool .{}_{} ._cmpres", 
                                    stk_basename, stk_prev));
                        },
                        3 => {
                            outputs::lines_main_push(
                                &format!("    eval_gteq__u24 ._cmpres .{}_{} .{}_{}", 
                                    stk_basename, stk_prev,
                                    stk_basename, stk_cur));
                            outputs::lines_main_push(
                                &format!("    equals__u24_bool .{}_{} ._cmpres", 
                                    stk_basename, stk_prev));
                        },
                        _ => {
                            println!(
                                "ERROR: ln:{} Stack elements of size `{}` not currently supported (2*).",
                                part.ln_no, req_elem_sz);
                            return true;
                        }
                    }
                },
                "==" => {
                    match req_elem_sz {
                        1 => {
                            outputs::lines_main_push(
                                &format!("    eval_eq__u8 .{}_{} .{}_{} .{}_{}", 
                                    stk_basename, stk_prev,
                                    stk_basename, stk_prev,
                                    stk_basename, stk_cur));
                        },
                        2 => {
                            outputs::lines_main_push(
                                &format!("    eval_eq__u16 ._cmpres .{}_{} .{}_{}", 
                                    stk_basename, stk_prev,
                                    stk_basename, stk_cur));
                            outputs::lines_main_push(
                                &format!("    equals__u16_bool .{}_{} ._cmpres", 
                                    stk_basename, stk_prev));
                        },
                        3 => {
                            outputs::lines_main_push(
                                &format!("    eval_eq__u24 ._cmpres .{}_{} .{}_{}", 
                                    stk_basename, stk_prev,
                                    stk_basename, stk_cur));
                            outputs::lines_main_push(
                                &format!("    equals__u24_bool .{}_{} ._cmpres", 
                                    stk_basename, stk_prev));
                        },
                        _ => {
                            println!(
                                "ERROR: ln:{} Stack elements of size `{}` not currently supported (2*).",
                                part.ln_no, req_elem_sz);
                            return true;
                        }
                    }
                },
                "!=" => {
                    match req_elem_sz {
                        1 => {
                            outputs::lines_main_push(
                                &format!("    eval_neq__u8 .{}_{} .{}_{} .{}_{}", 
                                    stk_basename, stk_prev,
                                    stk_basename, stk_prev,
                                    stk_basename, stk_cur));
                        },
                        2 => {
                            outputs::lines_main_push(
                                &format!("    eval_neq__u16 ._cmpres .{}_{} .{}_{}", 
                                    stk_basename, stk_prev,
                                    stk_basename, stk_cur));
                            outputs::lines_main_push(
                                &format!("    equals__u16_bool .{}_{} ._cmpres", 
                                    stk_basename, stk_prev));
                        },
                        3 => {
                            outputs::lines_main_push(
                                &format!("    eval_neq__u24 ._cmpres .{}_{} .{}_{}", 
                                    stk_basename, stk_prev,
                                    stk_basename, stk_cur));
                            outputs::lines_main_push(
                                &format!("    equals__u24_bool .{}_{} ._cmpres", 
                                    stk_basename, stk_prev));
                        },
                        _ => {
                            println!(
                                "ERROR: ln:{} Stack elements of size `{}` not currently supported (2*).",
                                part.ln_no, req_elem_sz);
                            return true;
                        }
                    }
                },
                "&&" => {
                    match req_elem_sz {
                        1 => {
                            outputs::lines_main_push(
                                &format!("    eval_logi_and__u8 .{}_{} .{}_{} .{}_{}", 
                                    stk_basename, stk_prev,
                                    stk_basename, stk_prev,
                                    stk_basename, stk_cur));
                        },
                        2 => {
                            outputs::lines_main_push(
                                &format!("    eval_logi_and__u16 ._cmpres .{}_{} .{}_{}", 
                                    stk_basename, stk_prev,
                                    stk_basename, stk_cur));
                            outputs::lines_main_push(
                                &format!("    equals__u16_bool .{}_{} ._cmpres", 
                                    stk_basename, stk_prev));
                        },
                        3 => {
                            outputs::lines_main_push(
                                &format!("    eval_logi_and__u24 ._cmpres .{}_{} .{}_{}", 
                                    stk_basename, stk_prev,
                                    stk_basename, stk_cur));
                            outputs::lines_main_push(
                                &format!("    equals__u24_bool .{}_{} ._cmpres", 
                                    stk_basename, stk_prev));
                        },
                        _ => {
                            println!(
                                "ERROR: ln:{} Stack elements of size `{}` not currently supported (2*).",
                                part.ln_no, req_elem_sz);
                            return true;
                        }
                    }
                },                
                _ => {
                    println!(
                        "ERROR: ln:{} Unhandled operation type `{}`.",
                        part.ln_no, epart);
                    return true;
                }
            }
            cur_stk_sz -= 1;
            continue;
        }

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
                if vtype == "u8" || vtype == "u8:ptr" {
                    match fn_args::get_u8_value_str(part.ln_no, epart, true) {
                        Some(u8val) => {
                            resolved_arg = u8val.clone();
                        },
                        None => {
                            println!("ERROR: ln:{} Failed to get u8 value of `{}`",
                                part.ln_no, epart);
                            return true;
                        }
                    }

                    match req_elem_sz {
                        1 => {
                            outputs::lines_main_push(
                                &format!("    equals__u8_u8{} .{}_{} .{}", 
                                    epart_ptr_str, stk_basename, cur_stk_sz, resolved_arg));
                        },
                        2 => {
                            outputs::lines_main_push(
                                &format!("    equals__u16_u8{} .{}_{} .{}", 
                                    epart_ptr_str, stk_basename, cur_stk_sz, resolved_arg));
                        },
                        3 => {
                            outputs::lines_main_push(
                                &format!("    equals__u24_u8{} .{}_{} .{}", 
                                    epart_ptr_str, stk_basename, cur_stk_sz, resolved_arg));
                        },
                        _ => {
                            println!(
                                "ERROR: ln:{} Stack elements of size `{}` not currently supported (2).",
                                part.ln_no, req_elem_sz);
                            return true;
                        }
                    }
                } else if vtype == "u16" || vtype == "u16:ptr" {
                    match fn_args::get_u16_value_str(part.ln_no, epart, true) {
                        Some(u16val) => {
                            resolved_arg = u16val.clone();
                        },
                        None => {
                            println!("ERROR: ln:{} Failed to get u16 value of `{}`",
                                part.ln_no, epart);
                            return true;
                        }
                    }

                    match req_elem_sz {
                        2 => {
                            outputs::lines_main_push(
                                &format!("    equals__u16_u16{} .{}_{} .{}", 
                                    epart_ptr_str, stk_basename, cur_stk_sz, resolved_arg));
                        },
                        3 => {
                            outputs::lines_main_push(
                                &format!("    equals__u24_u16{} .{}_{} .{}", 
                                    epart_ptr_str, stk_basename, cur_stk_sz, resolved_arg));
                        },
                        _ => {
                            println!(
                                "ERROR: ln:{} Stack elements of size `{}` not currently supported (2).",
                                part.ln_no, req_elem_sz);
                            return true;
                        }
                    }
                } else if vtype == "u24" || vtype == "u24:ptr"  {
                    match fn_args::get_u24_value_str(part.ln_no, epart, true) {
                        Some(u24val) => {
                            resolved_arg = u24val.clone();
                        },
                        None => {
                            println!("ERROR: ln:{} Failed to get u24 value of `{}`",
                                part.ln_no, epart);
                            return true;
                        }
                    }

                    match req_elem_sz {
                        3 => {
                            outputs::lines_main_push(
                                &format!("    equals__u24_u24{} .{}_{} .{}", 
                                    epart_ptr_str, stk_basename, cur_stk_sz, resolved_arg));
                        },
                        _ => {
                            println!(
                                "ERROR: ln:{} Stack elements of size `{}` not currently supported (2).",
                                part.ln_no, req_elem_sz);
                            return true;
                        }
                    }
                } else {
                    println!(
                        "ERROR: ln:{} Unsupported element `{}`; type `{}`.",
                        part.ln_no, &epart, vtype);
                    return true;
                }
            },
            None => {
                if fn_args::is_type_u8(part.ln_no, epart, true) {
                    match req_elem_sz {
                        1 => {
                            outputs::lines_main_push(
                                &format!("    equals__u8_u8 .{}_{} {}", 
                                    stk_basename, cur_stk_sz, epart));
                        },
                        2 => {
                            outputs::lines_main_push(
                                &format!("    equals__u16_u8 .{}_{} {}", 
                                    stk_basename, cur_stk_sz, epart));
                        },
                        3 => {
                            outputs::lines_main_push(
                                &format!("    equals__u24_u8 .{}_{} {}", 
                                    stk_basename, cur_stk_sz, epart));
                        },
                        _ => {
                            println!(
                                "ERROR: ln:{} Stack elements of size `{}` not currently supported (4).",
                                part.ln_no, req_elem_sz);
                            return true;
                        },
                    }
                } else if fn_args::is_type_u16(part.ln_no, epart, true) {
                    match req_elem_sz {
                        2 => {
                            outputs::lines_main_push(
                                &format!("    equals__u16_u16 .{}_{} {}", 
                                    stk_basename, cur_stk_sz, epart));
                        },
                        3 => {
                            outputs::lines_main_push(
                                &format!("    equals__u24_u16 .{}_{} {}", 
                                    stk_basename, cur_stk_sz, epart));
                        },
                        _ => {
                            println!(
                                "ERROR: ln:{} Stack elements of size `{}` not currently supported (3_2).",
                                part.ln_no, req_elem_sz);
                            return true;
                        }
                    }
                } else if fn_args::is_type_u24(part.ln_no, epart, true) {
                    match req_elem_sz {
                        3 => {
                            outputs::lines_main_push(
                                &format!("    equals__u24_u24 .{}_{} {}", 
                                    stk_basename, cur_stk_sz, epart));
                        },
                        _ => {
                            println!(
                                "ERROR: ln:{} Stack elements of size `{}` not currently supported (3_2).",
                                part.ln_no, req_elem_sz);
                            return true;
                        }
                    }
                } else {
                    println!(
                        "ERROR: ln:{} Unsupported variable/value `{}` in eval.",
                        part.ln_no, epart);
                    return true;
                }
            }
        }
        cur_stk_sz += 1;
    }

    match req_elem_sz {
        1 => {
            outputs::lines_main_push(
                &format!("    equals__bool_bool ._cmpres .{}_0", stk_basename));
        },
        2 => {
            outputs::lines_main_push(
                &format!("    eval_neq__u16 ._cmpres .{}_0  0", stk_basename));
        },
        3 => {
            outputs::lines_main_push(
                &format!("    eval_neq__u24 ._cmpres .{}_0  0", stk_basename));
        },
        _ => {
            println!(
                "ERROR: ln:{} Stack elements of size `{}` not currently supported (3_3).",
                part.ln_no, req_elem_sz);
            return true;
        }
    }
    outputs::lines_main_push("    equals_not__bool_bool ._cmpres ._cmpres");
    outputs::lines_main_push("    if ._cmpres");
    outputs::lines_main_push("        break");
    outputs::lines_main_push("    endif");
    outputs::lines_main_push("");

    return false;
}
