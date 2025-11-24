use crate::vhl::outputs;


pub fn arg_is_strings_index(arg: &str) -> bool {
    let mut varname:   String = "".to_string();
    let mut indexpart: String = "".to_string();
    let mut part:    u8     = 0;

    //------------------------------------------------------------------------//
    // Get the array size and number of elements.                             //
    //------------------------------------------------------------------------//
    for c in arg.chars() {
        match part {
            0 => {
                if c == '[' {
                    part += 1;
                    continue;
                } else {
                    varname.push(c);
                }
            },
            1 => {
                if c == ']' {
                    break;
                } else if c == ' ' || c == '\t' {
                    continue
                } else {
                    indexpart.push(c);
                }
            },
            _ => {},
        }
    }

    match outputs::get_vartype(&arg) {
        Some(vtype) => {
            if ! (vtype.starts_with("str8;") || vtype.starts_with("str16;")) {
                return false;
            }
        },
        None => {
            return false
        }
    }

    if indexpart.len() != 0 {
        return true;
    }
    return false;
}

fn get_stringtype(arg: &str) -> String {
    let vartype: String;

    vartype = outputs::get_vartype(&arg).unwrap();

    return vartype.clone();
}

fn get_stringtype_part(ln_no: u64, arg: &str, desired: &str) -> Option<String> {
    let     vartype:      String;
    let mut part:         u8  = 0;
    let mut strtype_str:  String = "".to_string();
    let mut str_size_str: String = "".to_string();

    vartype = get_stringtype(arg);

    //------------------------------------------------------------------------//
    // Get the array size and number of elements.                             //
    //------------------------------------------------------------------------//
    for c in vartype.chars() {
        match part {
            0 => {
                if c == ';' {
                    part += 1;
                    continue;
                } else {
                    strtype_str.push(c);
                }
            },
            1 => {
                str_size_str.push(c);
            },
            _ => {},
        }
    }

    if !(strtype_str == "str8" || strtype_str == "str16") {
        println!(
            "ERROR: ln:{} Unsupported string type `{}`.",
            ln_no, &strtype_str);
        return None;
    }

    match desired {
        "size" => {
            if strtype_str == "str8" {
                return Some("8".to_string());
            } else {
                return Some("16".to_string());
            }
        },
        "n_elem" => {
            return Some(str_size_str.clone());
        },
        _ => {
            println!(
                "ERROR: ln:{} Unsupported desired part `{}` from stringtype.",
                ln_no, &desired);
            return None;
        }
    }
}

fn get_stringtype_size(ln_no: u64, arg: &str) -> Option<u8> {
    let string_size:     u8;
    let string_size_str: String;

    match get_stringtype_part(ln_no, arg, "size") {
        Some(ssize) => {
            string_size_str = ssize.clone();
        },
        None => {
            return None;
        }
    }

    match string_size_str.parse::<u8>() {
        Ok(uint) => {
            string_size = uint;
        },
        Err(_) => {
            println!(
                "ERROR: ln:{} Invalid string size `{}`.",
                ln_no, string_size_str);
            return None;
        }
    }

    return Some(string_size);
}

fn get_stringtype_n_elem(ln_no: u64, arg: &str) -> Option<u64> {
    let n_elem:     u64;
    let n_elem_str: String;

    match get_stringtype_part(ln_no, arg, "n_elem") {
        Some(nelem) => {
            n_elem_str = nelem.clone();
        },
        None => {
            return None;
        }
    }

    match n_elem_str.parse::<u64>() {
        Ok(uint) => {
            n_elem = uint;
        },
        Err(_) => {
            println!(
                "ERROR: ln:{} Invalid string size `{}`.",
                ln_no, n_elem_str);
            return None;
        }
    }

    return Some(n_elem);
}

fn get_string_name(_ln_no: u64, arg: &str) -> Option<String> {
    let mut part:           u8  = 0;
    let mut string_name:    String = "".to_string();
    let mut elem_index_str: String = "".to_string();

    //------------------------------------------------------------------------//
    // Get the string name and the desired element index.                     //
    //------------------------------------------------------------------------//
    for c in arg.chars() {
        match part {
            0 => {
                if c == '[' {
                    part += 1;
                    continue;
                } else {
                    string_name.push(c);
                }
            },
            1 => {
                if c == ']' {
                    break;
                } else {
                    elem_index_str.push(c);
                }
            },
            _ => {},
        }
    }

    return Some(string_name.clone());
}

fn get_string_index(_ln_no: u64, arg: &str) -> Option<String> {
    let mut part:           u8  = 0;
    let mut string_name:    String = "".to_string();
    let mut elem_index_str: String = "".to_string();

    //------------------------------------------------------------------------//
    // Get the string name and the desired element index.                     //
    //------------------------------------------------------------------------//
    for c in arg.chars() {
        match part {
            0 => {
                if c == '[' {
                    part += 1;
                    continue;
                } else {
                    string_name.push(c);
                }
            },
            1 => {
                if c == ']' {
                    break;
                } else {
                    elem_index_str.push(c);
                }
            },
            _ => {},
        }
    }

    return Some(elem_index_str.clone());
}

// Returns name of ptr to use for referencing. If unique == false, `_temp_ptr`
// will be used; otherwise a unique pointer name will be returned.
fn get_reference(ln_no: u64, arg: &str, unique: bool) -> Option<String> {
    let     string_elem:    u64;
    let     string_size:    u8;
    let     string_name:    String;
    let     elem_index_str: String;
    let     ptr_varname:    String;
    let mut elem_index:     u64 = 0;
    let mut index_vartype:  Option<String> = None;

    outputs::set_array_ptr_in_active_fn();

    //------------------------------------------------------------------------//
    // Get the string size and number of elements.                            //
    //------------------------------------------------------------------------//
    match get_stringtype_size(ln_no, arg) {
        Some(asize) => { string_size = asize },
        None        => { return None },
    }
    match get_stringtype_n_elem(ln_no, arg) {
        Some(nelem) => { string_elem = nelem },
        None        => { return None },
    }

    //------------------------------------------------------------------------//
    // Get the string name and the desired element index.                     //
    //------------------------------------------------------------------------//
    match get_string_name(ln_no, arg) {
        Some(aname) => { string_name = aname },
        None        => { return None },
    }
    match get_string_index(ln_no, arg) {
        Some(index) => { elem_index_str = index },
        None        => { return None },
    }


    match outputs::get_vartype(&elem_index_str) {
        Some(vtype) => {
            index_vartype = Some(vtype.to_string());
        },
        None => {},
    }

    match elem_index_str.parse::<u64>() {
        Ok(uint) => {
            elem_index = uint;
        },
        Err(_) => {},
    }

    ptr_varname = match unique {
        true => {
            outputs::get_unique_ptr_var("char").unwrap()
        },
        false => {
            "_temp_ptr".to_string()
        },
    };

    match index_vartype {
        Some(vtype) => {
            //----------------------------------------------------------------//
            // The string is being indexed by a variable.                     //
            //----------------------------------------------------------------//
            let vtype_str = &vtype[..];
            match vtype_str {
                "u8" => {
                    if string_size != 8 {
                        println!(
                            "ERROR: ln:{} str16 can only be indexed using a u16 value, not `{}`.",
                            ln_no, vtype_str);
                        return None;
                    }
                    outputs::lines_main_push(&format!(
                        "    ref__str8 .{} .{} .{}", 
                        ptr_varname, string_name, elem_index_str));
                },
                "u16" => {
                    if string_size != 16 {
                        println!(
                            "ERROR: ln:{} str8 can only be indexed using a u8 value, not `{}`.",
                            ln_no, vtype_str);
                        println!("elem_index_str = `{}`", elem_index_str);
                        return None;
                    }
                    outputs::lines_main_push(&format!(
                        "    ref__str16 .{} .{} .{}", 
                        ptr_varname, string_name, elem_index_str));
                },
                _ => {
                    println!(
                        "ERROR: ln:{} vartype `{}` can not be used to index into string.",
                        ln_no, vtype_str);
                    return None;
                }
            }
        },
        None => {
            //----------------------------------------------------------------//
            // The string is being indexed by a number literal.                //
            //----------------------------------------------------------------//
            match string_size {
                8 => {
                    if elem_index > 0xFF {
                        println!(
                            "ERROR: ln:{} value `{}` exceeds maximum possible string elements.",
                            ln_no, elem_index);
                        return None;
                    } else if elem_index >= string_elem {
                        println!(
                            "ERROR: ln:{} value `{}` exceeds allocated string elements of `{}`.",
                            ln_no, elem_index, string_elem);
                        return None;
                    } else {
                        outputs::lines_main_push(&format!(
                            "    ref__str8 .{} .{} {}", 
                            ptr_varname, string_name, elem_index));
                    }
                },
                16 => {
                    if elem_index > 0xFFFF {
                        println!(
                            "ERROR: ln:{} value `{}` exceeds maximum possible string elements.",
                            ln_no, elem_index);
                        return None;
                    } else if elem_index >= string_elem {
                        println!(
                            "ERROR: ln:{} value `{}` exceeds allocated string elements of `{}`.",
                            ln_no, elem_index, string_elem);
                        return None;
                    } else {
                        outputs::lines_main_push(&format!(
                            "    ref__str16 .{} .{} {}", 
                            ptr_varname, string_name, elem_index));
                    }
                },
                _ => {
                    println!(
                        "ERROR: ln:{} unsupported string size `{}`.",
                        ln_no, string_size);
                    return None;
                },
            }
        },
    }

    return Some(ptr_varname);
}

pub fn get_value_ptr(ln_no: u64, arg: &str) -> Option<String> {
    let unique_val_ptr: String;

    match get_reference(ln_no, &arg, true) {
        Some(uptr) => {
            unique_val_ptr = uptr.clone();
        },
        None => {
            return None;
        }
    }

    return Some(unique_val_ptr);
}

pub fn get_value(ln_no: u64, arg: &str) -> Option<String> {
    if get_reference(ln_no, &arg, false).is_none() {
        return None;
    }

    outputs::mark_temptype_in_active_fn("var__char _temp_char");
    outputs::lines_main_push("    equals__u8_u8ptr ._temp_char ._temp_ptr");
    return Some("_temp_char".to_string());
}

// pub fn store_value(ln_no: u64, arg: &str, val: &str) -> bool {
//     let array_name: String;
//     let base_type:  String;

//     match get_array_name(ln_no, arg) {
//         Some(aname) => { array_name = aname },
//         None        => { return true },
//     }
//     match get_arraytype_basetype(ln_no, arg) {
//         Some(btype) => { base_type = btype.clone() },
//         None        => { return true },
//     }

//     if get_reference(ln_no, &arg, &base_type, false).is_none() {
//         return true;
//     }

//     match &base_type[..] {
//         "bool" => {
//             outputs::lines_main_push(
//                 &format!("    equals__boolptr_bool ._temp_ptr {}", val));
//             return false;
//         },
//         "u8" => {
//             outputs::lines_main_push(
//                 &format!("    equals__u8ptr_u8 ._temp_ptr {}", val));
//             return false;
//         },
//         "u16" => {
//             outputs::lines_main_push(
//                 &format!("    equals__u16ptr_u16 ._temp_ptr {}", val));
//             return false;
//         },
//         _ => {
//             println!("[TODO] array::store_value: Unsupported base type `{}` for array `{}`", 
//                 base_type, array_name);
//             return true
//         }
//     }
// }
