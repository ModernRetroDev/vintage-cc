use crate::vhl::outputs;


pub fn arg_is_array(arg: &str) -> bool {
    let vartype: String;

    match outputs::get_vartype(&arg) {
        Some(vtype) => {
            vartype = vtype.clone();
        },
        None => {
            return false
        }
    }

    if vartype.starts_with("array,") {
        return true;
    }
    return false;
}

fn get_arraytype(arg: &str) -> String {
    let vartype: String;

    vartype = outputs::get_vartype(&arg).unwrap();

    return vartype.clone();
}

fn get_arraytype_part(ln_no: u64, arg: &str, desired: &str) -> Option<String> {
    let     vartype:        String;
    let mut part:           u8  = 0;
    let mut n_elem_str:     String = "".to_string();
    let mut array_size_str: String = "".to_string();
    let mut base_type:      String = "".to_string();
    let mut uint_str:       String = "".to_string();

    vartype = get_arraytype(arg);

    //------------------------------------------------------------------------//
    // Get the array size, base type, and number of elements.                 //
    //------------------------------------------------------------------------//
    for c in vartype.chars() {
        match part {
            0 => {
                if c == ',' {
                    part += 1;
                    continue;
                }
            },
            1 => {
                if c == ',' {
                    part += 1;
                    
                    array_size_str = uint_str.clone();
                    // uint_str = "".to_string();
                    continue;
                } else {
                    uint_str.push(c);
                }
            },
            2 => {
                if c == ',' {
                    part += 1;
                    continue;
                } else {
                    base_type.push(c);
                }
            },
            3 => {
                if c == ',' {
                    break;
                } else {
                    n_elem_str.push(c);
                }
            },
            _ => {},
        }
    }

    match desired {
        "size" => {
            return Some(array_size_str.clone());
        },
        "basetype" => {
            return Some(base_type.clone());
        },
        "n_elem" => {
            return Some(n_elem_str.clone());
        },
        _ => {
            println!(
                "ERROR: ln:{} Unsupported desired part `{}` from arraytype.",
                ln_no, &desired);
            return None;
        }
    }
}

fn get_arraytype_size(ln_no: u64, arg: &str) -> Option<u8> {
    let array_size:     u8;
    let array_size_str: String;

    match get_arraytype_part(ln_no, arg, "size") {
        Some(asize) => {
            array_size_str = asize.clone();
        },
        None => {
            return None;
        }
    }

    match array_size_str.parse::<u8>() {
        Ok(uint) => {
            array_size = uint;
        },
        Err(_) => {
            println!(
                "ERROR: ln:{} Invalid array size `{}`.",
                ln_no, array_size_str);
            return None;
        }
    }

    return Some(array_size);
}

pub fn get_arraytype_basetype(ln_no: u64, arg: &str) -> Option<String> {
    let base_type: String;

    match get_arraytype_part(ln_no, arg, "basetype") {
        Some(btype) => {
            base_type = btype.clone();
        },
        None => {
            return None;
        }
    }

    return Some(base_type.clone())
}

fn get_arraytype_n_elem(ln_no: u64, arg: &str) -> Option<u64> {
    let n_elem:     u64;
    let n_elem_str: String;

    match get_arraytype_part(ln_no, arg, "n_elem") {
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
                "ERROR: ln:{} Invalid array size `{}`.",
                ln_no, n_elem_str);
            return None;
        }
    }

    return Some(n_elem);
}

pub fn get_array_index_size(ln_no: u64, arg: &str) -> Option<String> {
    let n_elem:     u64;

    match get_arraytype_n_elem(ln_no, arg) {
        Some(nelem) => {
            n_elem = nelem.clone();
        },
        None => {
            return None;
        }
    }    

    if n_elem <= 0xFF {
        return Some("u8".to_string());
    } else if n_elem <= 0xFFFF {
        return Some("u16".to_string());
    } else {
        return None;
    }

}

fn get_array_name(_ln_no: u64, arg: &str) -> Option<String> {
    let mut part:           u8  = 0;
    let mut array_name:     String = "".to_string();
    let mut elem_index_str: String = "".to_string();

    //------------------------------------------------------------------------//
    // Get the array name and the desired element index.                      //
    //------------------------------------------------------------------------//
    for c in arg.chars() {
        match part {
            0 => {
                if c == '[' {
                    part += 1;
                    continue;
                } else {
                    array_name.push(c);
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

    return Some(array_name.clone());
}

fn get_array_index(_ln_no: u64, arg: &str) -> Option<String> {
    let mut part:           u8  = 0;
    let mut array_name:     String = "".to_string();
    let mut elem_index_str: String = "".to_string();

    //------------------------------------------------------------------------//
    // Get the array name and the desired element index.                      //
    //------------------------------------------------------------------------//
    for c in arg.chars() {
        match part {
            0 => {
                if c == '[' {
                    part += 1;
                    continue;
                } else {
                    array_name.push(c);
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

// this always sets `_temp_ptr` to point at the indexed value
fn get_reference(ln_no: u64, arg: &str) -> bool {
    let     array_elem:     u64;
    let     array_size:     u8;
    let     array_name:     String;
    let     elem_index_str: String;
    let mut elem_index:     u64 = 0;
    let mut index_vartype:  Option<String> = None;

    outputs::set_array_ptr_in_active_fn();

    //------------------------------------------------------------------------//
    // Get the array size, base type, and number of elements.                 //
    //------------------------------------------------------------------------//
    match get_arraytype_size(ln_no, arg) {
        Some(asize) => { array_size = asize },
        None        => { return true },
    }
    match get_arraytype_n_elem(ln_no, arg) {
        Some(nelem) => { array_elem = nelem },
        None        => { return true },
    }

    //------------------------------------------------------------------------//
    // Get the array name and the desired element index.                      //
    //------------------------------------------------------------------------//
    match get_array_name(ln_no, arg) {
        Some(aname) => { array_name = aname },
        None        => { return true },
    }
    match get_array_index(ln_no, arg) {
        Some(index) => { elem_index_str = index },
        None        => { return true },
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

    match index_vartype {
        Some(vtype) => {
            //----------------------------------------------------------------//
            // The array is being indexed by a variable.                      //
            //----------------------------------------------------------------//
            let vtype_str = &vtype[..];
            match vtype_str {
                "u8" => {
                    if array_size != 8 {
                        println!(
                            "ERROR: ln:{} arr8 can only be indexed using a u8 value, not `{}`.",
                            ln_no, vtype_str);
                        return true;
                    }
                    outputs::lines_main_push(&format!(
                        "    ref__arr8 ._ptr .{} .{}", 
                        array_name, elem_index_str));
                },
                "u16" => {
                    if array_size != 16 {
                        println!(
                            "ERROR: ln:{} arr16 can only be indexed using a u16 value, not `{}`.",
                            ln_no, vtype_str);
                        return true;
                    }
                    outputs::lines_main_push(&format!(
                        "    ref__arr16 ._ptr .{} .{}", 
                        array_name, elem_index_str));
                },
                _ => {
                    println!(
                        "ERROR: ln:{} vartype `{}` can not be used to index into array.",
                        ln_no, vtype_str);
                    return true;
                }
            }
        },
        None => {
            //----------------------------------------------------------------//
            // The array is being indexed by a number literal.                //
            //----------------------------------------------------------------//
            match array_size {
                8 => {
                    if elem_index > 0xFF {
                        println!(
                            "ERROR: ln:{} value `{}` exceeds maximum possible array elements.",
                            ln_no, elem_index);
                        return true;
                    } else if elem_index >= array_elem {
                        println!(
                            "ERROR: ln:{} value `{}` exceeds allocated array elements of `{}`.",
                            ln_no, elem_index, array_elem);
                        return true;
                    } else {
                        outputs::lines_main_push(&format!(
                            "    ref__arr8 ._ptr .{} {}", 
                            array_name, elem_index));
                    }
                },
                16 => {
                    if elem_index > 0xFFFF {
                        println!(
                            "ERROR: ln:{} value `{}` exceeds maximum possible array elements.",
                            ln_no, elem_index);
                        return true;
                    } else if elem_index >= array_elem {
                        println!(
                            "ERROR: ln:{} value `{}` exceeds allocated array elements of `{}`.",
                            ln_no, elem_index, array_elem);
                        return true;
                    } else {
                        outputs::lines_main_push(&format!(
                            "    ref__arr16 ._ptr .{} {}", 
                            array_name, elem_index));
                    }
                },
                _ => {
                    println!(
                        "ERROR: ln:{} unsupported array size `{}`.",
                        ln_no, array_size);
                    return true;
                },
            }
        },
    }

    return false;
}

pub fn get_value(ln_no: u64, arg: &str) -> Option<String> {
    let array_name: String;
    let base_type:  String;

    if get_reference(ln_no, &arg) {
        return None;
    }

    match get_array_name(ln_no, arg) {
        Some(aname) => { array_name = aname },
        None        => { return None },
    }
    match get_arraytype_basetype(ln_no, arg) {
        Some(btype) => { base_type = btype.clone() },
        None        => { return None },
    }

    match &base_type[..] {
        "bool" => {
            outputs::mark_temptype_in_active_fn("var__bool _temp_bool");
            outputs::lines_main_push("    load__bool ._temp_bool ._ptr");
            return Some("_temp_bool".to_string());
        },
        "u8" => {
            outputs::mark_temptype_in_active_fn("var__u8 _temp_u8");
            outputs::lines_main_push("    load__u8 ._temp_u8 ._ptr");
            return Some("_temp_u8".to_string());
        },
        "u16" => {
            outputs::mark_temptype_in_active_fn("var__u16 _temp_u16");
            outputs::lines_main_push("    load__u16 ._temp_u16 ._ptr");
            return Some("_temp_u16".to_string());
        },
        _ => {
            println!("[TODO] Unsupported base type `{}` for array `{}`", 
                base_type, array_name);
            return None
        }
    }
}

pub fn store_value(ln_no: u64, arg: &str, val: &str) -> bool {
    let array_name: String;
    let base_type:  String;

    if get_reference(ln_no, &arg) {
        return true;
    }

    match get_array_name(ln_no, arg) {
        Some(aname) => { array_name = aname },
        None        => { return true },
    }
    match get_arraytype_basetype(ln_no, arg) {
        Some(btype) => { base_type = btype.clone() },
        None        => { return true },
    }

    // return Some(format!("_temp_{}", base_type));

    match &base_type[..] {
        "bool" => {
            outputs::lines_main_push(&format!("    store__bool ._ptr {}", val));
            return false;
        },
        "u8" => {
            outputs::lines_main_push(&format!("    store__u8 ._ptr {}", val));
            return false;
        },
        "u16" => {
            outputs::lines_main_push(&format!("    store__u16 ._ptr {}", val));
            return false;
        },
        _ => {
            println!("[TODO] Unsupported base type `{}` for array `{}`", 
                base_type, array_name);
            return true
        }
    }
}
