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
        _ => { return false }
    }
}

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

fn eval_is_increment(part: LinePart) -> bool {
    // Look for `1 +;` on the RHS of a `x =`
    let     varname:          String;
    let mut eval_parts:       Vec<String>  = Vec::new();
    let mut next:             LinePart;
    let mut terminated:       bool = false;

    varname = part.next.clone();

    next = part.get_next();

    loop {
        next = next.get_next();
        if next.next == "" {
            if !terminated {
                println!(
                    "ERROR: ln:{} Statements must end with a terminator; generally a `;`.",
                    next.ln_no);
                return true;
            }
            break;
        }
        let trimmed: String;
        if next.next.ends_with(";") {
            let stop_len = next.next.len() -1;
            trimmed = next.next[..stop_len].to_string();
            terminated = true;
        } else {
            trimmed = next.next.clone();
        }

        if terminated && trimmed.ends_with(";") {
            println!(
                "ERROR: ln:{} Only a single semicolon should occur at end of statement.",
                next.ln_no);
            return true;
        }

        eval_parts.push(trimmed.clone());
    }

    if eval_parts.len() == 3 {
        if eval_parts[0] != varname {
            return false;
        }
        if eval_parts[1] != "1"{
            return false;
        }
        if eval_parts[2] != "+"{
            return false;
        }
        return true;
    }
    return false;
}

fn eval_is_decrement(part: LinePart) -> bool {
    // Look for `1 -;` on the RHS of a `x =`
    let     varname:          String;
    let mut eval_parts:       Vec<String>  = Vec::new();
    let mut next:             LinePart;
    let mut terminated:       bool = false;

    varname = part.next.clone();

    next = part.get_next();

    loop {
        next = next.get_next();
        if next.next == "" {
            if !terminated {
                println!(
                    "ERROR: ln:{} Statements must end with a terminator; generally a `;`.",
                    next.ln_no);
                return true;
            }
            break;
        }
        let trimmed: String;
        if next.next.ends_with(";") {
            let stop_len = next.next.len() -1;
            trimmed = next.next[..stop_len].to_string();
            terminated = true;
        } else {
            trimmed = next.next.clone();
        }

        if terminated && trimmed.ends_with(";") {
            println!(
                "ERROR: ln:{} Only a single semicolon should occur at end of statement.",
                next.ln_no);
            return true;
        }

        eval_parts.push(trimmed.clone());
    }

    if eval_parts.len() == 3 {
        if eval_parts[0] != varname {
            return false;
        }
        if eval_parts[1] != "1"{
            return false;
        }
        if eval_parts[2] != "-"{
            return false;
        }
        return true;
    }
    return false;
}

pub fn now(part: LinePart) -> bool {
    let     varname:      String;
    let     var_is_ref:   bool;
    let     var_is_deref: bool;
    let mut next:         LinePart;
    let mut eval_parts:   Vec<String>  = Vec::new();
    let mut cur_stk_sz:   u8 = 0;
    let mut req_stk_sz:   u8 = 0;
    let mut req_elem_sz:  u8;
    let mut terminated:   bool = false;
    let mut deref_btype:  String = "".to_string();

    if part.next.starts_with("@") {
        var_is_ref = true;
        varname = part.next[1..].to_string();
    } else {
        var_is_ref = false;
        varname = part.next.clone();
    }

    if is_direct_deref(&varname) {
        var_is_deref = true;
    } else if outputs::get_vartype(&varname).is_none() {
        println!(
            "ERROR: ln:{} Unable to save evaluated value to undeclared variable `{}`.",
            part.ln_no, varname);
        return true;
    } else {
        var_is_deref = false;
    }

    next = part.get_next();
    if next.next != "=" {
        println!(
            "ERROR: ln:{} Eval RPN must have `=` follow a variable name, not `{}`.",
            part.ln_no, next.next);
        return true;
    }

    //------------------------------------------------------------------------//
    // Check for faster implementations: increment, decrement, `+=`, or `-=`. //
    //------------------------------------------------------------------------//
    if eval_is_increment(part.clone()) {
        let epart_type: Option<String> = 
            get_evalpart_basetype(part.ln_no, &varname);

        match epart_type {
            Some(vtype) => {
                match &vtype[..] {
                    "u8" => {
                        if array::arg_is_array(&varname) {
                            println!("TODO: EVAL_EQ: increment array value!!!");
                        } else {
                            outputs::lines_main_push(&format!("    # {} {}", varname, part.rem));
                            outputs::lines_main_push(&format!("    increment__u8 .{}", varname));
                            return false;
                        }
                    },
                    "u16" => {
                        if array::arg_is_array(&varname) {
                            println!("TODO: EVAL_EQ: increment array value!!!");
                        } else {
                            outputs::lines_main_push(&format!("    # {} {}", varname, part.rem));
                            outputs::lines_main_push(&format!("    increment__u16 .{}", varname));
                            return false;
                        }
                    },
                    "u24" => {
                        if array::arg_is_array(&varname) {
                            println!("TODO: EVAL_EQ: increment array value!!!");
                        } else {
                            outputs::lines_main_push(&format!("    # {} {}", varname, part.rem));
                            outputs::lines_main_push(&format!("    increment__u24 .{}", varname));
                            return false;
                        }
                    },
                    _ => {
                        println!(
                            "ERROR: ln:{} EVAL_EQ: Increment not supported for type `{}`.",
                            part.ln_no, vtype);
                        return true;
                    }
                }
            },
            None => {},
        }
    }
    if eval_is_decrement(part.clone()) {
        let epart_type: Option<String> = 
            get_evalpart_basetype(part.ln_no, &varname);

        match epart_type {
            Some(vtype) => {
                match &vtype[..] {
                    "u8" => {
                        if array::arg_is_array(&varname) {
                            println!("TODO: EVAL_EQ: decrement array value!!!");
                        } else {
                            outputs::lines_main_push(&format!("    # {} {}", varname, part.rem));
                            outputs::lines_main_push(&format!("    decrement__u8 .{}", varname));
                            return false;
                        }
                    },
                    "u16" => {
                        if array::arg_is_array(&varname) {
                            println!("TODO: EVAL_EQ: decrement array value!!!");
                        } else {
                            outputs::lines_main_push(&format!("    # {} {}", varname, part.rem));
                            outputs::lines_main_push(&format!("    decrement__u16 .{}", varname));
                            return false;
                        }
                    },
                    "u24" => {
                        if array::arg_is_array(&varname) {
                            println!("TODO: EVAL_EQ: decrement array value!!!");
                        } else {
                            outputs::lines_main_push(&format!("    # {} {}", varname, part.rem));
                            outputs::lines_main_push(&format!("    decrement__u24 .{}", varname));
                            return false;
                        }
                    },
                    _ => {
                        println!(
                            "ERROR: ln:{} EVAL_EQ: Decrement not supported for type `{}`.",
                            part.ln_no, vtype);
                        return true;
                    }
                }
            },
            None => {},
        }
    }

    //------------------------------------------------------------------------//
    // Else: Operation is more complicated; a stack will be required.         //
    //------------------------------------------------------------------------//
    loop {
        next = next.get_next();
        if next.next == "" {
            if !terminated {
                println!(
                    "ERROR: ln:{} Statements must end with a terminator; generally a `;`.",
                    part.ln_no);
                return true;
            }
            break;
        }
        let trimmed: String;
        if next.next.ends_with(";") {
            let stop_len = next.next.len() -1;
            trimmed = next.next[..stop_len].to_string();
            terminated = true;
        } else {
            trimmed = next.next.clone();
        }

        if terminated && trimmed.ends_with(";") {
            println!(
                "ERROR: ln:{} Only a single semicolon should occur at end of statement.",
                part.ln_no);
            return true;
        }

        eval_parts.push(trimmed.clone());
    }

    //------------------------------------------------------------------------//
    // Determine the stack size required to accomplish this calculation.      //
    //------------------------------------------------------------------------//
    for epart in &eval_parts {
        // println!("checking `{}`...", epart);
        if eval_part_is_op(&epart) {
            // println!("   ^^^ is_op");
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
    let mut ptr_suffix: String = "".to_string();
    let mut retval_btype: String = 
        get_evalpart_basetype(part.ln_no, &varname).unwrap();

    if var_is_deref {
        deref_btype = retval_btype.clone();
    } else if var_is_ref {
        if !retval_btype.ends_with(":ptr") {
            println!(
                "ERROR: ln:{} Reference addresses `@{}`may only be set for pointers.",
                part.ln_no, varname);
            return true;
        }
        retval_btype = "ptr".to_string();
    } else if retval_btype.ends_with(":ptr") {
        ptr_suffix = "ptr".to_string();
        retval_btype = retval_btype[..retval_btype.len()-4].to_string();
    }
    match &retval_btype[..] {
        "u8"  => { req_elem_sz = 1; },
        "u16" => { req_elem_sz = 2; },
        "u24" => { req_elem_sz = 3; },
        "ptr" => { req_elem_sz = 2; },
        _     => {
            println!(
                "ERROR: ln:{} Unsupported vartype for `{}` in eval.",
                part.ln_no, varname);
            return true;
        }
    }

    for epart in &eval_parts {
        if eval_part_is_op(&epart) {
            continue;
        }

        let epart_type: Option<String> = 
            get_evalpart_basetype(part.ln_no, &epart);

        match epart_type {
            Some(vtype) => {
                if vtype == "u16" {
                    if req_elem_sz < 2 {
                        req_elem_sz = 2;
                    }
                } else if vtype == "u24" {
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
    let eq_fn: String = match req_elem_sz {
        1 => { format!("equals__u8{}_u8", ptr_suffix) },
        2 => { 
            if retval_btype == "ptr" {
                format!("equals__ptr_u16")
            } else {
                format!("equals__u16{}_u16", ptr_suffix)
            }
        },
        3 => { 
            if retval_btype == "ptr" {
                format!("equals__ptr_u24")
            } else {
                format!("equals__u24{}_u24", ptr_suffix)
            }
        },
        _ => {
            println!(
                "ERROR: ln:{} Stack elements of size `{}` not currently supported (3).",
                part.ln_no, req_elem_sz);
            return true;
        },
    };

    outputs::lines_main_push(&format!("    # {} {}", varname, part.rem));

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
                    if req_elem_sz == 1 {
                        outputs::lines_main_push(
                            &format!("    plus_equals__u8_u8 .{}_{} .{}_{}", 
                                stk_basename, stk_prev,
                                stk_basename, stk_cur));
                    } else if req_elem_sz == 2 {
                        outputs::lines_main_push(
                            &format!("    plus_equals__u16_u16 .{}_{} .{}_{}", 
                                stk_basename, stk_prev,
                                stk_basename, stk_cur));
                    } else if req_elem_sz == 3 {
                        outputs::lines_main_push(
                            &format!("    plus_equals__u24_u24 .{}_{} .{}_{}", 
                                stk_basename, stk_prev,
                                stk_basename, stk_cur));
                    } else {
                        println!(
                            "ERROR: ln:{} Stack elements of size `{}` not currently supported (2*).",
                            part.ln_no, req_elem_sz);
                        return true;
                    }
                },
                "-" => {
                    if req_elem_sz == 1 {
                        outputs::lines_main_push(
                            &format!("    minus_equals__u8_u8 .{}_{} .{}_{}", 
                                stk_basename, stk_prev,
                                stk_basename, stk_cur));
                    } else if req_elem_sz == 2 {
                        outputs::lines_main_push(
                            &format!("    minus_equals__u16_u16 .{}_{} .{}_{}", 
                                stk_basename, stk_prev,
                                stk_basename, stk_cur));
                    } else if req_elem_sz == 3 {
                        outputs::lines_main_push(
                            &format!("    minus_equals__u24_u24 .{}_{} .{}_{}", 
                                stk_basename, stk_prev,
                                stk_basename, stk_cur));
                    } else {
                        println!(
                            "ERROR: ln:{} Stack elements of size `{}` not currently supported (2*).",
                            part.ln_no, req_elem_sz);
                        return true;
                    }
                },
                "|" => {
                    if req_elem_sz == 1 {
                        outputs::lines_main_push(
                            &format!("    bitwise_or__u8 .{}_{} .{}_{}", 
                                stk_basename, stk_prev,
                                stk_basename, stk_cur));
                    } else if req_elem_sz == 2 {
                        outputs::lines_main_push(
                            &format!("    bitwise_or__u16 .{}_{} .{}_{}", 
                                stk_basename, stk_prev,
                                stk_basename, stk_cur));
                    } else if req_elem_sz == 3 {
                        outputs::lines_main_push(
                            &format!("    bitwise_or__u24 .{}_{} .{}_{}", 
                                stk_basename, stk_prev,
                                stk_basename, stk_cur));
                    } else {
                        println!(
                            "ERROR: ln:{} Stack elements of size `{}` not currently supported (2*).",
                            part.ln_no, req_elem_sz);
                        return true;
                    }
                },
                "&" => {
                    if req_elem_sz == 1 {
                        outputs::lines_main_push(
                            &format!("    bitwise_and__u8 .{}_{} .{}_{}", 
                                stk_basename, stk_prev,
                                stk_basename, stk_cur));
                    } else if req_elem_sz == 2 {
                        outputs::lines_main_push(
                            &format!("    bitwise_and__u16 .{}_{} .{}_{}", 
                                stk_basename, stk_prev,
                                stk_basename, stk_cur));
                    } else if req_elem_sz == 3 {
                        outputs::lines_main_push(
                            &format!("    bitwise_and__u24 .{}_{} .{}_{}", 
                                stk_basename, stk_prev,
                                stk_basename, stk_cur));
                    } else {
                        println!(
                            "ERROR: ln:{} Stack elements of size `{}` not currently supported (2*).",
                            part.ln_no, req_elem_sz);
                        return true;
                    }
                },
                "<<" => {
                    if req_elem_sz == 1 {
                        outputs::lines_main_push(
                            &format!("    lshift__u8_n .{}_{} .{}_{}", 
                                stk_basename, stk_prev,
                                stk_basename, stk_cur));
                    } else if req_elem_sz == 2 {
                        outputs::lines_main_push(
                            &format!("    lshift__u16_n .{}_{} .{}_{}", 
                                stk_basename, stk_prev,
                                stk_basename, stk_cur));
                    } else if req_elem_sz == 3 {
                        outputs::lines_main_push(
                            &format!("    lshift__u24_n .{}_{} .{}_{}", 
                                stk_basename, stk_prev,
                                stk_basename, stk_cur));
                    } else {
                        println!(
                            "ERROR: ln:{} Stack elements of size `{}` not currently supported (2*).",
                            part.ln_no, req_elem_sz);
                        return true;
                    }
                },
                ">>" => {
                    if req_elem_sz == 1 {
                        outputs::lines_main_push(
                            &format!("    rshift__u8_n .{}_{} .{}_{}", 
                                stk_basename, stk_prev,
                                stk_basename, stk_cur));
                    } else if req_elem_sz == 2 {
                        outputs::lines_main_push(
                            &format!("    rshift__u16_n .{}_{} .{}_{}", 
                                stk_basename, stk_prev,
                                stk_basename, stk_cur));
                    } else {
                        println!(
                            "ERROR: ln:{} Stack elements of size `{}` not currently supported (2*).",
                            part.ln_no, req_elem_sz);
                        return true;
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
                if vtype == "u8" || vtype == "u8:ptr" || vtype == "char" {
                    if vtype == "u8:ptr" {
                        resolved_arg = epart.clone();
                    } else {
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
                    }

                    if req_elem_sz == 1 {
                        outputs::lines_main_push(
                            &format!("    equals__u8_u8{} .{}_{} .{}", 
                                epart_ptr_str, stk_basename, cur_stk_sz, resolved_arg));
                    } else if req_elem_sz == 2 {
                        outputs::lines_main_push(
                            &format!("    equals__u16_u8{} .{}_{} .{}", 
                                epart_ptr_str, stk_basename, cur_stk_sz, resolved_arg));
                    } else if req_elem_sz == 3 {
                        outputs::lines_main_push(
                            &format!("    equals__u24_u8{} .{}_{} .{}", 
                                epart_ptr_str, stk_basename, cur_stk_sz, resolved_arg));
                    } else {
                        println!(
                            "ERROR: ln:{} Stack elements of size `{}` not currently supported (2).",
                            part.ln_no, req_elem_sz);
                        return true;
                    }
                } else if vtype == "u16" || vtype == "u16:ptr" {
                    if vtype == "u16:ptr" {
                        resolved_arg = epart.clone();
                    } else {
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
                    }

                    if req_elem_sz == 2 {
                        outputs::lines_main_push(
                            &format!("    equals__u16_u16{} .{}_{} .{}", 
                                epart_ptr_str, stk_basename, cur_stk_sz, resolved_arg));
                    } else if req_elem_sz == 3 {
                        outputs::lines_main_push(
                            &format!("    equals__u24_u16{} .{}_{} .{}", 
                                epart_ptr_str, stk_basename, cur_stk_sz, resolved_arg));
                    } else {
                        println!(
                            "ERROR: ln:{} Stack elements of size `{}` not currently supported (3).",
                            part.ln_no, req_elem_sz);
                        return true;
                    }
                } else if vtype == "u24" || vtype == "u24:ptr" {
                    if vtype == "u24:ptr" {
                        resolved_arg = epart.clone();
                    } else {
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
                    }

                    if req_elem_sz == 3 {
                        outputs::lines_main_push(
                            &format!("    equals__u24_u24{} .{}_{} .{}", 
                                epart_ptr_str, stk_basename, cur_stk_sz, resolved_arg));
                    } else {
                        println!(
                            "ERROR: ln:{} Stack elements of size `{}` not currently supported (3).",
                            part.ln_no, req_elem_sz);
                        return true;
                    }
                } else {
                    println!("ERROR: ln:{} Unhandled vartype `{}` for `{}`.",
                        part.ln_no, vtype, &epart);
                    return true;
                }
            },
            None => {
                if fn_args::is_type_u8(part.ln_no, epart, true) {
                    if req_elem_sz == 1 {
                        outputs::lines_main_push(
                            &format!("    equals__u8_u8 .{}_{} {}", 
                                stk_basename, cur_stk_sz, epart));
                    } else if req_elem_sz == 2 {
                        outputs::lines_main_push(
                            &format!("    equals__u16_u8 .{}_{} {}", 
                                stk_basename, cur_stk_sz, epart));
                    } else if req_elem_sz == 3 {
                        outputs::lines_main_push(
                            &format!("    equals__u24_u8 .{}_{} {}", 
                                stk_basename, cur_stk_sz, epart));
                    } else {
                        println!(
                            "ERROR: ln:{} Stack elements of size `{}` not currently supported (4).",
                            part.ln_no, req_elem_sz);
                        return true;
                    }
                } else if fn_args::is_type_u16(part.ln_no, epart, true) {
                    if req_elem_sz == 2 {
                        outputs::lines_main_push(
                            &format!("    equals__u16_u16 .{}_{} {}", 
                                stk_basename, cur_stk_sz, epart));
                    } else if req_elem_sz == 3 {
                        outputs::lines_main_push(
                            &format!("    equals__u24_u16 .{}_{} {}", 
                                stk_basename, cur_stk_sz, epart));
                    } else {
                        println!(
                            "ERROR: ln:{} Stack elements of size `{}` not currently supported (3).",
                            part.ln_no, req_elem_sz);
                        return true;
                    }
                } else if fn_args::is_type_u24(part.ln_no, epart, true) {
                    if req_elem_sz == 3 {
                        outputs::lines_main_push(
                            &format!("    equals__u24_u24 .{}_{} {}", 
                                stk_basename, cur_stk_sz, epart));
                    } else {
                        println!(
                            "ERROR: ln:{} Stack elements of size `{}` not currently supported (3).",
                            part.ln_no, req_elem_sz);
                        return true;
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

    if array::arg_is_array(&varname) {
        let eval_final: String = format!(".{}_0", stk_basename);
        if array::store_value(part.ln_no, &varname, &eval_final) {
            return true;
        }
    } else if var_is_deref {
        let tempptr: String;
        let deref_eq_fn: String;
        let rhs_type = match req_elem_sz {
            1 => { format!("u8") },
            2 => { format!("u16") },
            3 => { format!("u24") },
            _ => {
                println!(
                    "ERROR: ln:{} Stack elements of size `{}` not currently supported (3).",
                    part.ln_no, req_elem_sz);
                return true;
            },
        };

        if deref_btype == "u8" {
            deref_eq_fn = format!("equals__u8ptr_{rhs_type}");
            tempptr = match fn_args::get_u8_value_str(part.ln_no, &varname, true) {
                Some(tempstr) => { tempstr }
                None => {
                    println!("ERROR: ln:{} Failed to get u8 deref of `{}`",
                        part.ln_no, varname);
                    return true;
                }
            }
        } else if deref_btype == "u16" {
            deref_eq_fn = format!("equals__u16ptr_{rhs_type}");
            tempptr = match fn_args::get_u16_value_str(part.ln_no, &varname, true) {
                Some(tempstr) => { tempstr }
                None => {
                    println!("ERROR: ln:{} Failed to get u16 deref of `{}`",
                        part.ln_no, varname);
                    return true;
                }
            }
        } else if deref_btype == "u24" {
            deref_eq_fn = format!("equals__u24ptr_{rhs_type}");
            tempptr = match fn_args::get_u24_value_str(part.ln_no, &varname, true) {
                Some(tempstr) => { tempstr }
                None => {
                    println!("ERROR: ln:{} Failed to get u24 deref of `{}`",
                        part.ln_no, varname);
                    return true;
                }
            }
        } else {
            println!("ERROR: ln:{} Unsupported type for deref of `{}`, got {}",
                part.ln_no, varname, deref_btype);
            return true;
        }

        outputs::lines_main_push(
            &format!("    {} .{} .{}_0", deref_eq_fn, tempptr, stk_basename));
    } else {
        outputs::lines_main_push(
            &format!("    {} .{} .{}_0", eq_fn, varname, stk_basename));
    }

    outputs::lines_main_push("");

    return false;
}
