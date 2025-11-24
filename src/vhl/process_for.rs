use crate::vhl::array;
use crate::vhl::outputs;
use crate::vhl::type_strings;

use crate::vhl::line_part::LinePart;

fn is_str_var(varname: &str) -> bool {
    match outputs::get_vartype(varname) {
        Some(vtype) => {
            if vtype.starts_with("str8;") || vtype.starts_with("str16;") {
                return true;
            }
        },
        None => {},
    }
    return false;
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

fn is_for_loop(part: LinePart) -> Option<bool> {
    let mut next:       LinePart;
    let mut eval_parts: Vec<String>  = Vec::new();

    next = part.clone();
    if next.next != "for" {
        println!(
            "ERROR: ln:{} Expected `for` got `{}`.",
            part.ln_no, next.next);
        return None;
    }

    loop {
        next = next.get_next();
        if next.next == "" {
            break
        }
        if next.next == "{" {
            break;
        } else if next.next.ends_with("{") {
            println!(
                "ERROR: ln:{} There must be at least one space between loopable and `{{`.",
                part.ln_no);
            return None;
        }

        eval_parts.push(next.next.clone());
    }

    if eval_parts.len() != 3 {
        return Some(false);
    }

    let mut vtype = outputs::get_vartype(&eval_parts[0]);
    if vtype.is_some() || eval_parts[0] == "_" {
        // looks good thus far
    } else {
        println!(
            "ERROR: ln:{} FOR: Expected variable or `_`; got `{}`.",
            part.ln_no, eval_parts[0]);
        return None;
    }

    if eval_parts[1] != "in" {
        return Some(false)
    }

    vtype = outputs::get_vartype(&eval_parts[2]);
    if vtype.is_some() {
        return Some(true);
    }

    return Some(false);
}

fn is_for_all_loop(part: LinePart) -> Option<bool> {
    let mut next:       LinePart;
    let mut eval_parts: Vec<String>  = Vec::new();

    next = part.clone();
    if next.next != "for" {
        println!(
            "ERROR: ln:{} Expected `for` got `{}`.",
            part.ln_no, next.next);
        return None;
    }

    loop {
        next = next.get_next();
        if next.next == "" {
            break
        }
        if next.next == "{" {
            break;
        } else if next.next.ends_with("{") {
            println!(
                "ERROR: ln:{} There must be at least one space between loopable and `{{`.",
                part.ln_no);
            return None;
        }

        eval_parts.push(next.next.clone());
    }

    if eval_parts.len() != 4 {
        return Some(false);
    }

    let mut vtype = outputs::get_vartype(&eval_parts[0]);
    if vtype.is_some() || eval_parts[0] == "_" {
        // looks good thus far
    } else {
        println!(
            "ERROR: ln:{} FOR: Expected variable or `_`; got `{}`.",
            part.ln_no, eval_parts[0]);
        return None;
    }

    if eval_parts[1] != "in" {
        return Some(false)
    }

    if eval_parts[2] == "all" {
        println!(
            "ERROR: ln:{} FOR: Expected `[all]`; got `{}`.",
            part.ln_no, eval_parts[2]);
        return None;
    }
    if eval_parts[2] != "[all]" {
        return Some(false)
    }

    vtype = outputs::get_vartype(&eval_parts[3]);
    if vtype.is_some() {
        return Some(true);
    }

    return Some(false);
}

fn is_enumerated_for_loop(part: LinePart) -> Option<bool> {
    let mut next:       LinePart;
    let mut eval_parts: Vec<String>  = Vec::new();

    next = part.clone();
    if next.next != "for" {
        println!(
            "ERROR: ln:{} Expected `for` got `{}`.",
            part.ln_no, next.next);
        return None;
    }

    loop {
        next = next.get_next();
        if next.next == "" {
            break
        }
        if next.next == "{" {
            break;
        } else if next.next.ends_with("{") {
            println!(
                "ERROR: ln:{} There must be at least one space between loopable and `{{`.",
                part.ln_no);
            return None;
        }

        eval_parts.push(next.next.clone());
    }

    if eval_parts.len() != 5 {
        return Some(false);
    }

    if eval_parts[2] != "in" {
        return Some(false)
    }

    if eval_parts[3] == "enumerate" {
        println!(
            "ERROR: ln:{} FOR: Expected `[enumerate]`; got `{}`.",
            part.ln_no, eval_parts[3]);
        return None;
    }
    if eval_parts[3] != "[enumerate]" {
        return Some(false)
    }

    let mut vtype = outputs::get_vartype(&eval_parts[4]);
    if vtype.is_some() {
        return Some(true);
    }

    let mut ind_var: String = eval_parts[0].clone();
    if ind_var.ends_with(",") {
        ind_var = ind_var[..ind_var.len()-1].to_string();
    }

    vtype = outputs::get_vartype(&ind_var);
    if vtype.is_some() || ind_var == "_" {
        // looks good thus far
    } else {
        println!(
            "ERROR: ln:{} FOR: Expected index variable or `_`; got `{}`.",
            part.ln_no, eval_parts[0]);
        return None;
    }

    let loopnext_var: String = eval_parts[1].clone();

    vtype = outputs::get_vartype(&loopnext_var);
    if vtype.is_some() || loopnext_var == "_" {
        // looks good thus far
    } else {
        println!(
            "ERROR: ln:{} FOR: Expected loop_next variable or `_`; got `{}`.",
            part.ln_no, eval_parts[0]);
        return None;
    }

    return Some(false);
}

fn is_enumerated_for_all_loop(part: LinePart) -> Option<bool> {
    let mut next:       LinePart;
    let mut eval_parts: Vec<String>  = Vec::new();

    next = part.clone();
    if next.next != "for" {
        println!(
            "ERROR: ln:{} Expected `for` got `{}`.",
            part.ln_no, next.next);
        return None;
    }

    loop {
        next = next.get_next();
        if next.next == "" {
            break
        }
        if next.next == "{" {
            break;
        } else if next.next.ends_with("{") {
            println!(
                "ERROR: ln:{} There must be at least one space between loopable and `{{`.",
                part.ln_no);
            return None;
        }

        eval_parts.push(next.next.clone());
    }

    if eval_parts.len() != 5 {
        return Some(false);
    }

    if eval_parts[2] != "in" {
        return Some(false)
    }

    if eval_parts[3] == "enumerate,all" {
        println!(
            "ERROR: ln:{} FOR: Expected `[enumerate,all]`; got `{}`.",
            part.ln_no, eval_parts[3]);
        return None;
    }
    if eval_parts[3] == "all,enumerate" {
        println!(
            "ERROR: ln:{} FOR: Expected `[all,enumerate]`; got `{}`.",
            part.ln_no, eval_parts[3]);
        return None;
    }

    if eval_parts[3] == "[enumerate,all]" || eval_parts[3] == "[all,enumerate]" {
    } else {
        return Some(false)
    }

    let mut vtype = outputs::get_vartype(&eval_parts[4]);
    if vtype.is_some() {
        return Some(true);
    }

    let mut ind_var: String = eval_parts[0].clone();
    if ind_var.ends_with(",") {
        ind_var = ind_var[..ind_var.len()-1].to_string();
    }

    vtype = outputs::get_vartype(&ind_var);
    if vtype.is_some() || ind_var == "_" {
        // looks good thus far
    } else {
        println!(
            "ERROR: ln:{} FOR: Expected index variable or `_`; got `{}`.",
            part.ln_no, eval_parts[0]);
        return None;
    }

    let loopnext_var: String = eval_parts[1].clone();

    vtype = outputs::get_vartype(&loopnext_var);
    if vtype.is_some() || loopnext_var == "_" {
        // looks good thus far
    } else {
        println!(
            "ERROR: ln:{} FOR: Expected loop_next variable or `_`; got `{}`.",
            part.ln_no, eval_parts[0]);
        return None;
    }

    return Some(false);
}


fn as_for_loop(part: LinePart, all: bool) -> bool {
    let     get_loopable_next:   bool;
    let     loopable_is_str:     bool;
    let     vtype_loopable_next: String;
    let     basetype_loopable:   String;
    let     loopable_next:       String;
    let     loopable_varname:    String;
    let     index_type:          String;
    let     vtype_opt:           Option<String>;
    let mut loop_label:          Option<String> = None;
    let mut next:                LinePart;
    let mut eval_parts:          Vec<String>  = Vec::new();

    next = part.clone();
    if next.next != "for" {
        println!(
            "ERROR: ln:{} Expected `for` got `{}`.",
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
                "ERROR: ln:{} There must be at least one space between loopable and `{{`.",
                part.ln_no);
            return true;
        }

        eval_parts.push(next.next.clone());
    }

    if all {
        if eval_parts.len() != 4 {
            println!(
                "ERROR: ln:{} FOR: Expected 4 eval parts; got `{}`.",
                part.ln_no, eval_parts.len());
            return true;
        }
    } else {
        if eval_parts.len() != 3 {
            println!(
                "ERROR: ln:{} FOR: Expected 3 eval parts; got `{}`.",
                part.ln_no, eval_parts.len());
            return true;
        }
    }

    loopable_next = eval_parts[0].clone();
    vtype_opt = outputs::get_vartype(&loopable_next);
    if loopable_next == "_" {
        get_loopable_next = false;
        vtype_loopable_next = "_".to_string();
    } else {
        match vtype_opt {
            Some(vt) => {
                vtype_loopable_next = vt.clone();
            },
            None => {
                println!(
                    "ERROR: ln:{} FOR: Expected variable or `_`; got `{}`.",
                    part.ln_no, loopable_next);
                return true;
            },
        }
        get_loopable_next = true;
    }

    if eval_parts[1] != "in" {
        println!(
            "ERROR: ln:{} FOR: Expected `in`; got `{}`.",
            part.ln_no, eval_parts[1]);
        return true;
    }

    if all {
        loopable_varname = eval_parts[3].clone();
    } else {
        loopable_varname = eval_parts[2].clone();
    }

    if is_str_var(&loopable_varname) {
        loopable_is_str = true;
    } else {
        loopable_is_str = false;
    }

    //------------------------------------------------------------------------//
    // Make sure the loopable variable is actually loopable.                  //
    //------------------------------------------------------------------------//
    if array::arg_is_array(&loopable_varname) {
        match array::get_arraytype_basetype(part.ln_no, &loopable_varname) {
            Some(btype) => {
                basetype_loopable = btype.clone();
            },
            None => {
                println!(
                    "ERROR: ln:{} FOR: Failed to get basetype for array `{}`.",
                    part.ln_no, loopable_varname);
                return true;
            }
        }
    } else if loopable_is_str {
        basetype_loopable = "char".to_string();
    } else {
        basetype_loopable = outputs::get_vartype(
            &loopable_varname).unwrap();
    }

    if get_loopable_next {
        if vtype_loopable_next != basetype_loopable {
            println!(
                "ERROR: ln:{} FOR: Loopable next variable `{}` must be type `{}`; got `{}`.",
                part.ln_no, loopable_next, basetype_loopable, vtype_loopable_next);
            return true;
        }
    }
    //------------------------------------------------------------------------//
    // If things are still okay at this point; we should be good to go.       //
    //------------------------------------------------------------------------//
    if loopable_is_str {
        let str_vtype: String = outputs::get_vartype(&loopable_varname).unwrap();
        if str_vtype.starts_with("str8;") {
            index_type = "u8".to_string();
        } else {
            index_type = "u16".to_string();
        }
        outputs::loop_ctr_types_push(&index_type);
    } else {
        match array::get_array_index_size(part.ln_no, &loopable_varname) {
            Some(ind_size) => {
                outputs::loop_ctr_types_push(&ind_size);
                match &ind_size[..] {
                    "u8" => { index_type = ind_size.clone(); },
                    "u16" => { index_type = ind_size.clone(); },
                    _ => {
                        println!(
                            "ERROR: ln:{} FOR: unsupported index type `{}`.",
                            part.ln_no, ind_size);
                        return true;
                    },
                };
            },
            None => {
                println!(
                    "ERROR: ln:{} FOR: unable to determine index type for `{}`.",
                    part.ln_no, loopable_varname);
                return true;
            },
        }
    }

    let eq_fn:        String;
    let get_alloc_fn: String;
    let get_len_fn:   String;
    let loop_len_var: String;
    let eval_fn:      String;
    let increment_fn: String;

    match &index_type[..] {
        "u8" => {
            eq_fn        = "equals__u8_u8".to_string();
            get_alloc_fn = "get_alloc__arr8".to_string();
            get_len_fn   = "get_length__arr8".to_string();
            eval_fn      = "eval_eq__u8".to_string();
            loop_len_var = "_loop_len_u8".to_string();
            increment_fn = "increment__u8".to_string();
        },
        "u16" => {
            eq_fn        = "equals__u16_u16".to_string();
            get_alloc_fn = "get_alloc__arr16".to_string();
            get_len_fn   = "get_length__arr16".to_string();
            eval_fn      = "eval_eq__u16".to_string();
            loop_len_var = "_loop_len_u16".to_string();
            increment_fn = "increment__u16".to_string();
        },
        _ => {
            println!(
                "ERROR: ln:{} FOR: unsupported index type for `{}`.",
                part.ln_no, loopable_varname);
            return true;
        },
    };

    let lpvar_eq_fn: String = match &basetype_loopable[..] {
        "char" => {
            "equals__u8_u8ptr".to_string()
        },
        "u8" => {
            "equals__u8_u8ptr".to_string()
        },
        "u16" => {
            "equals__u16_u16ptr".to_string()
        },
        _ => {
            println!(
                "ERROR: ln:{} FOR: Unsupported basetype loopable `{}`.",
                part.ln_no, basetype_loopable);
            return true;
        }
    };

    let temp_loop_ctr_var: String = outputs::get_loop_ctr_tempvar().unwrap();

    match loop_label {
        Some(label) => {
            outputs::blktypes_push(&format!("loop:{}", label));
        },
        None => {
            outputs::blktypes_push("loop");
        }
    }

    outputs::lines_main_push(&format!("    # for {}", part.rem));
    outputs::lines_main_push(&format!("    {} .{} 0", eq_fn, temp_loop_ctr_var));
    //------------------------------------------------------------------------//
    // now set the value of loopable_next (if desired)                        //
    //------------------------------------------------------------------------//
    let mut resolved_arg: String = "".to_string();
    if get_loopable_next {
        let indexed_var: String = format!("{}[{}]", 
            &loopable_varname, &temp_loop_ctr_var);
        if loopable_is_str {
            resolved_arg = match type_strings::get_value_ptr(part.ln_no, &indexed_var) {
                Some(temp_var) => { temp_var.clone() },
                None => { return true },
            };
        } else {
            resolved_arg = match array::get_value_ptr(part.ln_no, &indexed_var) {
                Some(temp_var) => { temp_var.clone() },
                None => { return true },
            };
        }
    }

    if all {
        outputs::lines_main_push(&format!("    {} .{} .{}", 
            get_alloc_fn, loop_len_var, loopable_varname));
        outputs::lines_main_push(         "    loop");
    } else {
        outputs::lines_main_push(         "    loop");
        outputs::lines_main_push(&format!("        {} .{} .{}", 
            get_len_fn, loop_len_var, loopable_varname));
    }

    outputs::set_cmpres_in_active_fn();
    outputs::lines_main_push(&format!("        {} ._cmpres .{} .{}", 
        eval_fn, loop_len_var, temp_loop_ctr_var));
    outputs::lines_main_push(         "        if ._cmpres");
    outputs::lines_main_push(         "            break");
    outputs::lines_main_push(         "        endif");

    if get_loopable_next {
        outputs::lines_main_push(&format!("        {} .{} .{}", 
            lpvar_eq_fn, loopable_next, resolved_arg));
        match &index_type[..] {
            "u8" => {
                outputs::lines_main_push(
                    &format!("        increment__ptr .{}", resolved_arg));
            },
            "u16" => {
                outputs::lines_main_push(
                    &format!("        plus_equals__ptr_u8 .{} 2", resolved_arg));
            },
            _ => {
                println!(
                    "ERROR: ln:{} FOR: Unsupported basetype loopable `{}`.",
                    part.ln_no, basetype_loopable);
                return true;
            }
        }
    }

    outputs::lines_main_push(&format!("        {} .{}", increment_fn, temp_loop_ctr_var));
    outputs::lines_main_push(         "");

    return false;
}

fn as_enumerated_for_loop(part: LinePart, all: bool) -> bool {
    let     get_loopable_next:    bool;
    let     get_loopable_index:   bool;
    let     loopable_is_str:     bool;
    let     vtype_loopable_index: String;
    let     vtype_loopable_next:  String;
    let     basetype_loopable:    String;
    let mut loopable_index:       String;
    let     loopable_next:        String;
    let     loopable_varname:     String;
    let     index_type:           String;
    let mut loop_label:  Option<String> = None;
    let mut vtype_opt:            Option<String>;
    let mut next:                 LinePart;
    let mut eval_parts:           Vec<String>  = Vec::new();

    next = part.clone();
    if next.next != "for" {
        println!(
            "ERROR: ln:{} Expected `for` got `{}`.",
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
                "ERROR: ln:{} There must be at least one space between loopable and `{{`.",
                part.ln_no);
            return true;
        }

        eval_parts.push(next.next.clone());
    }

    if eval_parts.len() != 5 {
        println!(
            "ERROR: ln:{} FOR: expected 5 eval parts; got `{}`.",
            part.ln_no, eval_parts.len());
        return true;
    }

    loopable_index = eval_parts[0].clone();
    if loopable_index.ends_with(",") {
        loopable_index = loopable_index[..loopable_index.len()-1].to_string();
        if loopable_index.ends_with(",") {
            println!(
                "ERROR: ln:{} FOR: Too many commas following loopindex_var `{}`.",
                part.ln_no, loopable_index);
            return true;
        }
    }
    vtype_opt = outputs::get_vartype(&loopable_index);
    if loopable_index == "_" {
        get_loopable_index = false;
        vtype_loopable_index = "_".to_string();
    } else {
        match vtype_opt {
            Some(vt) => {
                vtype_loopable_index = vt.clone();
            },
            None => {
                println!(
                    "ERROR: ln:{} FOR: Expected variable or `_`; got `{}`.",
                    part.ln_no, loopable_index);
                return true;
            },
        }
        get_loopable_index = true;
    }

    loopable_next = eval_parts[1].clone();
    vtype_opt = outputs::get_vartype(&loopable_next);
    if loopable_next == "_" {
        get_loopable_next = false;
        vtype_loopable_next = "_".to_string();
    } else {
        match vtype_opt {
            Some(vt) => {
                vtype_loopable_next = vt.clone();
            },
            None => {
                println!(
                    "ERROR: ln:{} FOR: Expected variable or `_`; got `{}`.",
                    part.ln_no, loopable_next);
                return true;
            },
        }
        get_loopable_next = true;
    }

    if eval_parts[2] != "in" {
        println!(
            "ERROR: ln:{} FOR: Expected `in`; got `{}`.",
            part.ln_no, eval_parts[2]);
        return true;
    }

    loopable_varname = eval_parts[4].clone();

    if is_str_var(&loopable_varname) {
        loopable_is_str = true;
    } else {
        loopable_is_str = false;
    }

    //------------------------------------------------------------------------//
    // Make sure the loopable variable is actually loopable.                  //
    //------------------------------------------------------------------------//
    if array::arg_is_array(&loopable_varname) {
        match array::get_arraytype_basetype(part.ln_no, &loopable_varname) {
            Some(btype) => {
                basetype_loopable = btype.clone();
            },
            None => {
                println!(
                    "ERROR: ln:{} FOR: Failed to get basetype for array `{}`.",
                    part.ln_no, loopable_varname);
                return true;
            }
        }
    } else if is_str_var(&loopable_varname) {
        basetype_loopable = "char".to_string();
    } else {
        basetype_loopable = outputs::get_vartype(
            &loopable_varname).unwrap();
    }

    if get_loopable_next {
        if vtype_loopable_next != basetype_loopable {
            println!(
                "ERROR: ln:{} FOR: Loopable next variable `{}` must be type `{}`; got `{}`.",
                part.ln_no, loopable_next, basetype_loopable, vtype_loopable_next);
            return true;
        }
    }

    //------------------------------------------------------------------------//
    // If things are still okay at this point; we should be good to go.       //
    //------------------------------------------------------------------------//
    if is_str_var(&loopable_varname) {
        let str_vtype: String = outputs::get_vartype(&loopable_varname).unwrap();
        if str_vtype.starts_with("str8;") {
            index_type = "u8".to_string();
        } else {
            index_type = "u16".to_string();
        }
        outputs::loop_ctr_types_push(&index_type);
    } else {
        match array::get_array_index_size(part.ln_no, &loopable_varname) {
            Some(ind_size) => {
                outputs::loop_ctr_types_push(&ind_size);
                match &ind_size[..] {
                    "u8" => { index_type = ind_size.clone(); },
                    "u16" => { index_type = ind_size.clone(); },
                    _ => {
                        println!(
                            "ERROR: ln:{} FOR: unsupported index type `{}`.",
                            part.ln_no, ind_size);
                        return true;
                    },
                };
            },
            None => {
                println!(
                    "ERROR: ln:{} FOR: unable to determine index type for `{}`.",
                    part.ln_no, loopable_varname);
                return true;
            },
        }
    }

    if get_loopable_index {
        if vtype_loopable_index != index_type {
            println!(
                "ERROR: ln:{} FOR: Loopable index variable `{}` must be type `{}`; got `{}`.",
                part.ln_no, loopable_index, index_type, vtype_loopable_index);
            return true;
        }
    }

    let eq_fn:        String;
    let get_alloc_fn: String;
    let get_len_fn:   String;
    let loop_len_var: String;
    let eval_fn:      String;
    let increment_fn: String;

    match &index_type[..] {
        "u8" => {
            eq_fn        = "equals__u8_u8".to_string();
            get_alloc_fn = "get_alloc__arr8".to_string();
            get_len_fn   = "get_length__arr8".to_string();
            eval_fn      = "eval_eq__u8".to_string();
            loop_len_var = "_loop_len_u8".to_string();
            increment_fn = "increment__u8".to_string();
        },
        "u16" => {
            eq_fn        = "equals__u16_u16".to_string();
            get_alloc_fn = "get_alloc__arr16".to_string();
            get_len_fn   = "get_length__arr16".to_string();
            eval_fn      = "eval_eq__u16".to_string();
            loop_len_var = "_loop_len_u16".to_string();
            increment_fn = "increment__u16".to_string();
        },
        _ => {
            println!(
                "ERROR: ln:{} FOR: unsupported index type for `{}`.",
                part.ln_no, loopable_varname);
            return true;
        },
    };

    let lpvar_eq_fn: String = match &basetype_loopable[..] {
        "char" => {
            "equals__u8_u8ptr".to_string()
        },
        "u8" => {
            "equals__u8_u8ptr".to_string()
        },
        "u16" => {
            "equals__u16_u16ptr".to_string()
        },
        _ => {
            println!(
                "ERROR: ln:{} FOR: Unsupported basetype loopable `{}`.",
                part.ln_no, basetype_loopable);
            return true;
        }
    };

    let temp_loop_ctr_var: String = outputs::get_loop_ctr_tempvar().unwrap();

    match loop_label {
        Some(label) => {
            outputs::blktypes_push(&format!("loop:{}", label));
        },
        None => {
            outputs::blktypes_push("loop");
        }
    }

    outputs::lines_main_push(&format!("    # for {}", part.rem));
    outputs::lines_main_push(&format!("    {} .{} 0", eq_fn, temp_loop_ctr_var));
    //------------------------------------------------------------------------//
    // now set the value of loopable_next (if desired)                        //
    //------------------------------------------------------------------------//
    let mut resolved_arg: String = "".to_string();
    if get_loopable_next {
        let indexed_var: String = format!("{}[{}]", 
            &loopable_varname, &temp_loop_ctr_var);

        if loopable_is_str {
            resolved_arg = match type_strings::get_value_ptr(part.ln_no, &indexed_var) {
                Some(temp_var) => { temp_var.clone() },
                None => { return true },
            };
        } else {
            resolved_arg = match array::get_value_ptr(part.ln_no, &indexed_var) {
                Some(temp_var) => { temp_var.clone() },
                None => { return true },
            };
        }
    }

    if all {
        outputs::lines_main_push(&format!("    {} .{} .{}", 
            get_alloc_fn, loop_len_var, loopable_varname));
        outputs::lines_main_push(         "    loop");
    } else {
        outputs::lines_main_push(         "    loop");
        outputs::lines_main_push(&format!("        {} .{} .{}", 
            get_len_fn, loop_len_var, loopable_varname));
    }

    outputs::set_cmpres_in_active_fn();
    outputs::lines_main_push(&format!("        {} ._cmpres .{} .{}", 
        eval_fn, loop_len_var, temp_loop_ctr_var));
    outputs::lines_main_push(         "        if ._cmpres");
    outputs::lines_main_push(         "            break");
    outputs::lines_main_push(         "        endif");
    //------------------------------------------------------------------------//
    // now set the value of loopable_next (if desired)                        //
    //------------------------------------------------------------------------//
    if get_loopable_next {
        outputs::lines_main_push(&format!("        {} .{} .{}", 
            lpvar_eq_fn, loopable_next, resolved_arg));
        match &index_type[..] {
            "u8" => {
                outputs::lines_main_push(
                    &format!("        increment__ptr .{}", resolved_arg));
            },
            "u16" => {
                outputs::lines_main_push(
                    &format!("        plus_equals__ptr_u8 .{} 2", resolved_arg));
            },
            _ => {
                println!(
                    "ERROR: ln:{} FOR: Unsupported basetype loopable `{}`.",
                    part.ln_no, basetype_loopable);
                return true;
            }
        }
    }
    //------------------------------------------------------------------------//
    // now set the value of loopable_index (if desired)                       //
    //------------------------------------------------------------------------//
    if get_loopable_index {
        outputs::lines_main_push(&format!("        {} .{} .{}", 
            eq_fn, loopable_index, temp_loop_ctr_var));
    }

    outputs::lines_main_push(&format!("        {} .{}", increment_fn, temp_loop_ctr_var));
    outputs::lines_main_push(         "");

    return false;
}

pub fn now(part: LinePart) -> bool {
    let next: LinePart;

    next = part.clone();
    if next.next != "for" {
        println!(
            "ERROR: ln:{} Expected `for` got `{}`.",
            part.ln_no, next.next);
        return true;
    }

    match is_for_loop(part.clone()) {
        Some(unmodified) => {
            if unmodified {
                return as_for_loop(part.clone(), false);
            }
        },
        None => {
            return true;
        }
    }

    match is_for_all_loop(part.clone()) {
        Some(unmodified) => {
            if unmodified {
                return as_for_loop(part.clone(), true);
            }
        },
        None => {
            return true;
        }
    }

    match is_enumerated_for_loop(part.clone()) {
        Some(enumerated) => {
            if enumerated {
                return as_enumerated_for_loop(part.clone(), false);
            }
        },
        None => {
            // there was an error in checking for an enumerated loop
            return true;
        }
    }

    match is_enumerated_for_all_loop(part.clone()) {
        Some(enumerated) => {
            if enumerated {
                return as_enumerated_for_loop(part.clone(), true);
            }
        },
        None => {
            // there was an error in checking for an enumerated loop
            return true;
        }
    }

    return false;
}
