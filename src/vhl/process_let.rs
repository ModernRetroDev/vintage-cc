use crate::vhl::outputs;
use crate::vhl::fn_args;

use crate::vhl::line_part::LinePart;


fn get_array_basetype(arrtype: &str) -> String {
    let     substr: String = arrtype[1..].to_string();
    let mut btype: String = "".to_string();

    for c in substr.chars() {
        if c == ';' {
            break;
        }
        btype.push(c);
    }
    return btype;
}

fn get_array_length(arrtype: &str) -> String {
    let     substr: String = arrtype[1..].to_string();
    let mut capture: bool = false;
    let mut alen: String = "".to_string();

    for c in substr.chars() {
        if c == ';' {
            capture = true;
            continue;
        } else if c == ']' {
            break;
        }

        if capture {
            alen.push(c);
        }
    }
    return alen;
}

fn as_type_array(ln_no: u64, varname: &str, arrtype: &str, init_val: Option<String>) -> bool {
    let     btype: String;
    let     alen: String;
    let     array_sz: u8;
    let mut uval: u64 = 0;
    let     is_uint: bool;

    // println!("ln_no: `{}`, varname = `{}`, arrtype = `{}`", ln_no, varname, arrtype);
    btype = get_array_basetype(arrtype);
    alen = get_array_length(arrtype);

    // println!("btype = `{}`", btype);
    // println!("alen  = `{}`", alen);

    // see if the length is a unit value
    match alen.parse::<u64>() {
        Ok(val) => {
            uval = val;
            is_uint = true;
        },
        Err(_) => {
            is_uint = false;
        }
    }
    if !is_uint {
        println!(
            "ERROR: ln:{} Array of unsupported length `{}`.",
            ln_no, alen);
        return true;
    }

    let basetype_str = &btype[..];
    match basetype_str {
        "u8" => {},
        "u16" => {},
        _ => {
            println!(
                "ERROR: ln:{} Unsupported base type `{}` in array.",
                ln_no, btype);
            return true;
        }
    }

    if uval <= 0xFF+1 {
        array_sz = 8;
        match init_val {
            Some(ival) => {
                let ival_ss = ival[1..ival.len()-1].to_string();
                // strip out any contained spaces within the array values
                let ival_ss_trim = ival_ss.replace(" ", "");

                outputs::lines_vardecl_push(&format!("    arr8__{},{} {} = {}", 
                    btype, alen, varname, ival_ss_trim));
            },
            None => {
                outputs::lines_vardecl_push(&format!("    arr8__{},{} {}", 
                    btype, alen, varname));
            }
        }
    } else if uval <= 0xFFFF+1 {
        array_sz = 16;
        match init_val {
            Some(ival) => {
                let ival_ss = ival[1..ival.len()-1].to_string();
                // strip out any contained spaces within the array values
                let ival_ss_trim = ival_ss.replace(" ", "");
                outputs::lines_vardecl_push(&format!("    arr16__{},{} {} = {}", 
                    btype, alen, varname, ival_ss_trim));
            },
            None => {
                outputs::lines_vardecl_push(&format!("    arr16__{},{} {}", 
                    btype, alen, varname));
            }
        }
    } else {
        println!(
            "ERROR: ln:{} Array length `{}` beyond maximum supported value.",
            ln_no, alen);
        return true;
    }

    outputs::set_var_index(varname);
    outputs::varnames_append(varname);
    outputs::vartypes_append(
        &format!("array,{},{},{}", array_sz, btype, alen));

    return false;
}

fn as_type_bool(ln_no: u64, varname: &str, init_val: Option<String>) -> bool {
    outputs::lines_vardecl_push(&format!("    var__bool {}", varname));

    match init_val {
        Some(ival) => {
            let ival_str = &ival[..];
            match ival_str {
                "false" => {
                    outputs::lines_vardef_push(&format!(
                        "    equals__bool_bool .{} {}", varname, ival));
                },
                "true" => {
                    outputs::lines_vardef_push(&format!(
                        "    equals__bool_bool .{} {}", varname, ival));
                },
                _ => {
                    println!(
                        "ERROR: ln:{} Failed to parse bool value `{}`.",
                        ln_no, ival);
                    return true;
                }
            }
        },
        None => {},
    }

    outputs::set_var_index(varname);
    outputs::varnames_append(varname);
    outputs::vartypes_append("bool");

    return false;
}

fn as_type_file(_ln_no: u64, varname: &str, _init_val: Option<String>) -> bool {
    outputs::lines_vardecl_push(&format!("    var__file {}", varname));

    outputs::set_var_index(varname);
    outputs::varnames_append(varname);
    outputs::vartypes_append("file");

    return false;
}

fn get_ptr_basetype(ptrtype: &str) -> Option<String> {
    let mut btype: String = "".to_string();

    for c in ptrtype.chars() {
        if c == '@' {
            return Some(btype);
        }
        btype.push(c);
    }
    return None;
}

fn as_type_ptr(ln_no: u64, varname: &str, ptrtype_str: &str, init_val: Option<String>) -> bool {

    let ptrtype = match get_ptr_basetype(ptrtype_str) {
        Some(btype) => { btype },
        None => {
            println!("ERROR: ln:{} Unable to determine basetype of pointer `{}`",
                ln_no, ptrtype_str);
            return true;
        }
    };

    match init_val {
        Some(ival) => {
            match fn_args::get_u16_value_str(ln_no, &ival, false) {
                Some(u16val) => {
                    outputs::lines_vardef_push(&format!(
                        "    equals__ptr_u16 .{} {}", varname, u16val));
                },
                None => {
                    println!("ERROR: ln:{} Failed to get u16 value of `{}`",
                        ln_no, ival);
                    return true;
                }
            }
        },
        None => {
            // if ! ptrtype_str.ends_with(";") {
            //     println!("ptrtype_str = `{}`", ptrtype_str);
            //     println!(
            //         "ERROR: ln:{}: Line is missing a trailing line terminator.",
            //         ln_no);
            //     return true;
            // }
        }
    }

    outputs::lines_vardecl_push(&format!("    ptr__{} {}", &ptrtype, varname));

    outputs::set_var_index(varname);
    outputs::varnames_append(varname);
    outputs::vartypes_append(&format!("{}:ptr", &ptrtype));

    return false;
}

fn as_type_char(ln_no: u64, varname: &str, init_val: Option<String>) -> bool {
    outputs::lines_vardecl_push(&format!("    var__char {}", varname));

    match init_val {
        Some(ival) => {
            match fn_args::get_u8_value_str(ln_no, &ival, false) {
                Some(u8val) => {
                    outputs::lines_vardef_push(&format!(
                        "    equals__u8_u8 .{} {}", varname, u8val));
                },
                None => {
                    println!("ERROR: ln:{} Failed to get u8 value of `{}`",
                        ln_no, ival);
                    return true;
                }
            }
        },
        None => {},
    }

    outputs::set_var_index(varname);
    outputs::varnames_append(varname);
    outputs::vartypes_append("char");

    return false;
}

fn as_type_u8(ln_no: u64, varname: &str, init_val: Option<String>) -> bool {
    outputs::lines_vardecl_push(&format!("    var__u8 {}", varname));

    match init_val {
        Some(ival) => {
            match fn_args::get_u8_value_str(ln_no, &ival, false) {
                Some(u8val) => {
                    outputs::lines_vardef_push(&format!(
                        "    equals__u8_u8 .{} {}", varname, u8val));
                },
                None => {
                    println!("ERROR: ln:{} Failed to get u8 value of `{}`",
                        ln_no, ival);
                    return true;
                }
            }
        },
        None => {},
    }

    outputs::set_var_index(varname);
    outputs::varnames_append(varname);
    outputs::vartypes_append("u8");

    return false;
}

fn as_type_u16(ln_no: u64, varname: &str, init_val: Option<String>) -> bool {
    outputs::lines_vardecl_push(&format!("    var__u16 {}", varname));

    match init_val {
        Some(ival) => {
            match fn_args::get_u16_value_str(ln_no, &ival, false) {
                Some(u16val) => {
                    outputs::lines_vardef_push(&format!(
                        "    equals__u16_u16 .{} {}", varname, u16val));
                },
                None => {
                    println!("ERROR: ln:{} Failed to get u16 value of `{}`",
                        ln_no, ival);
                    return true;
                }
            }
        },
        None => {},
    }

    outputs::set_var_index(varname);
    outputs::varnames_append(varname);
    outputs::vartypes_append("u16");

    return false;
}

fn as_type_u24(ln_no: u64, varname: &str, init_val: Option<String>) -> bool {
    outputs::lines_vardecl_push(&format!("    var__u24 {}", varname));

    match init_val {
        Some(ival) => {
            match fn_args::get_u24_value_str(ln_no, &ival, false) {
                Some(u24val) => {
                    outputs::lines_vardef_push(&format!(
                        "    equals__u24_u24 .{} {}", varname, u24val));
                },
                None => {
                    println!("ERROR: ln:{} Failed to get u24 value of `{}`",
                        ln_no, ival);
                    return true;
                }
            }
        },
        None => {},
    }

    outputs::set_var_index(varname);
    outputs::varnames_append(varname);
    outputs::vartypes_append("u24");

    return false;
}

fn as_type_str8(ln_no: u64, varname: &str, init_val: Option<String>) -> bool {
    let str8len: usize;

    match init_val {
        Some(ival) => {
            str8len = ival.len();
            outputs::lines_vardecl_push(
                &format!("    var__str8 {} = {}", varname, ival));
        },
        None => {
            println!("TODO/ERROR: ln:{} Allocated strings without an init value",
                ln_no);
            return true;
        },
    }

    outputs::set_var_index(varname);
    outputs::varnames_append(varname);
    outputs::vartypes_append(&format!("str8;{str8len}"));

    return false;
}

fn vartype_is_arr(vtype: &str) -> bool {
    // println!("vartype_is_arr(`{}`)?", vtype);
    if vtype.starts_with("[") && 
            vtype.contains(";") && 
            vtype.ends_with("]") {
        // println!("vartype_is_arr(`{}`) YES!", vtype);
        return true;
    }
    // println!("vartype_is_arr(`{}`) NO!", vtype);
    return false;
}

pub fn now(part: LinePart) -> bool {
    //
    let defined:        bool;
    let varname:     String;
    let varname_len: usize;
    let varname_raw: LinePart;

    let colon_raw: LinePart;

    let equals_raw: LinePart;

    let mut vartype:     String;
    let     vartype_len: usize;
    let     vartype_raw: LinePart;
    let mut type_str:   String = "".to_string();

    let value:     String;
    let value_len: usize;
    let value_raw: LinePart;

    let init_value: Option<String>;

    varname_raw = part.get_next();
    varname_len = varname_raw.next.len()-1;
    if varname_raw.next.chars().nth(varname_len) == Some(':') {
        varname = varname_raw.next[..varname_len].to_string();

        vartype_raw = varname_raw.get_next();
        vartype     = vartype_raw.next.to_string();
    } else {
        varname = varname_raw.next.to_string();

        colon_raw = varname_raw.get_next();
        if colon_raw.next == ":" {
            vartype_raw = colon_raw.get_next();
            vartype     = vartype_raw.next.to_string();
        } else {
            if colon_raw.next.chars().nth(0) == Some(':') {
                println!(
                    "ERROR: ln:{} Let declartion must have space between colon and type; not `{}`.",
                    part.ln_no, colon_raw.next);
                return true;

            } else {
                println!(
                    "ERROR: ln:{} Let declaration is missing a colon after varname.",
                    part.ln_no);
                return true;
            }
        }
    }

    vartype_len = vartype.len()-1;
    if vartype.chars().nth(vartype_len) == Some(';') {
        vartype = (vartype[..vartype_len]).to_string();
        defined = false;
    } else {
        defined = true;
    }

    if defined {
        equals_raw = vartype_raw.get_next();

        if equals_raw.next.chars().nth(0) == Some('=') {
            if equals_raw.next != "=" {
                println!(
                    "ERROR: ln:{} Let declaration must have space between `=` and value.",
                    part.ln_no);
                return true;
            }
        }

        if vartype == "str" {
            //----------------------------------------------------------------//
            // Walk through the line finding the start and end quote location //
            //----------------------------------------------------------------//
            let mut escaped_char: bool = false;
            let mut end_copy:   bool = false;
            let mut start_copy: bool = true;
            let mut copy_chars: bool = false;
            let mut value_str:  String = "".to_string();

            for c in part.rem.chars() {
                if end_copy {
                    if c != ';' {
                        println!(
                            "ERROR: ln:{} Let declaration is missing a trailing semicolon.",
                            part.ln_no);
                        return true;
                    }
                    break;
                }
                if start_copy {
                    if c == '"' {
                        copy_chars = true;
                        start_copy = false;
                    }
                } else {
                    if !escaped_char {
                        match c {
                            '\\' => {
                                escaped_char = true;
                            },
                            '"' => {
                                // end of the string
                                end_copy = true
                            },
                            _ => {},
                        }
                        if c == '\\' {
                            escaped_char = true;
                        }
                    }
                }

                if copy_chars {
                    value_str.push(c)
                }
            }

            value = value_str.clone();
            init_value = Some(value);

        } else if vartype_is_arr(&vartype) {
            //----------------------------------------------------------------//
            // Walk through the line finding the open and close brackets.     //
            //----------------------------------------------------------------//
            let mut end_copy:   bool = false;
            let mut start_copy: bool = true;
            let mut copy_chars: bool = false;
            let mut value_str:  String = "".to_string();
            let mut start:      usize  = 0;

            // println!("vartype is array = `{}`", vartype);

            for c in part.rem.chars() {
                start += 1;
                if start_copy {
                    if c == '[' {
                        copy_chars = true;
                        start_copy = false;
                    }
                } else {
                    if c == ']' {
                        end_copy = true;
                    }
                }

                if copy_chars {
                    type_str.push(c)
                }
                if end_copy {
                    break;
                }
            }

            let final_part = part.rem[start..].to_string();
            // println!("final_part = `{}`", final_part);
            let mut expect_equals = true;
            start_copy = true;
            end_copy = false;
            copy_chars = false;
            for c in final_part.chars() {
                start += 1;
                if end_copy {
                    if c == ' ' {
                        continue;
                    }
                    if c != ';' {
                        println!(
                            "ERROR: ln:{} Let declaration is missing a trailing semicolon.",
                            part.ln_no);
                        return true;
                    }
                    break;
                }
                if expect_equals {
                    if c == ' ' || c == '\t' {
                        continue;
                    } else if c == '=' {
                        expect_equals = false;
                    } else if c == ';' {
                        // println!("Undefined array!!!");
                        break;
                    } else {
                        println!(
                            "ERROR: ln:{} Let declaration must have equals or semicolon after type.",
                            part.ln_no);
                        return true;
                    }

                }
                if start_copy {
                    if c == '[' {
                        copy_chars = true;
                        start_copy = false;
                    }
                } else {
                    if c == ']' {
                        end_copy = true;
                    }
                }

                if copy_chars {
                    value_str.push(c)
                }
            }

            // println!("`{}`, `{}`", type_str, value_str);

            value = value_str.clone();
            init_value = Some(value);
            //
        } else if vartype == "file" {
            init_value = None;
        } else {
            value_raw = equals_raw.get_next();
            value_len = value_raw.next.len()-1;

            if value_raw.next.chars().nth(value_len) != Some(';') {
                println!(
                    "ERROR: ln:{} Let declaration is missing a trailing semicolon.",
                    part.ln_no);
                return true;
            }
            value = value_raw.next[..value_len].to_string();
            init_value = Some(value);
        }
    } else {
        init_value = None;
    }

    let vartype_str = &vartype[..];
    if vartype_is_arr(&vartype) {
        // this is an array declaration/definition

        //--------------------------------------------------------------------//
        // Walk through the line finding the open and close brackets.         //
        //--------------------------------------------------------------------//
        let mut end_copy:   bool = false;
        let mut start_copy: bool = true;
        let mut copy_chars: bool = false;

        for c in part.rem.chars() {
            if start_copy {
                if c == '[' {
                    copy_chars = true;
                    start_copy = false;
                }
            } else {
                if c == ']' {
                    end_copy = true;
                }
            }

            if copy_chars {
                type_str.push(c)
            }
            if end_copy {
                break;
            }
        }

        return as_type_array(part.ln_no, &varname, &type_str, init_value);
    }

    if vartype_str.ends_with("@") || vartype_str.ends_with("@;") {
        return as_type_ptr(part.ln_no, &varname, &vartype_str, init_value);
    }

    match vartype_str {
        "bool" => {
            return as_type_bool(part.ln_no, &varname, init_value);
        },
        "char" => {
            return as_type_char(part.ln_no, &varname, init_value);
        },
        "file" => {
            return as_type_file(part.ln_no, &varname, init_value);
        },
        "u8" => {
            return as_type_u8(part.ln_no, &varname, init_value);
        },
        "u16" => {
            return as_type_u16(part.ln_no, &varname, init_value);
        },
        "u24" => {
            return as_type_u24(part.ln_no, &varname, init_value);
        },
        "str" => {
            return as_type_str8(part.ln_no, &varname, init_value);
        },
        _ => {
            println!(
                "ERROR: ln:{} Unhandled vartype `{}` provided to let.",
                part.ln_no, vartype);
            return true;            
        }
    }
}
