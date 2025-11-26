use crate::vhl::array;
use crate::vhl::outputs;


fn is_direct_deref(epart: &str) -> bool {
    return epart.contains("@:");
}

fn get_direct_deref_str(epart: &str) -> String {
    let stop_ind  = epart.find("@:").unwrap();
    let start_ind = stop_ind + 2;

    let btype:    String = epart[..stop_ind].to_string();
    let address:  String = epart[start_ind..].to_string();
    let tempname: String = format!("_temp_ptr_{}", btype);

    outputs::mark_temptype_in_active_fn(&format!("ptr__{} {}", btype, tempname));
    outputs::lines_main_push(
        &format!("    equals__ptr_u16 .{} {}", tempname, address));
    return tempname;
}

fn get_evalpart_basetype(ln_no: u64, epart: &str, deref_okay: bool) -> Option<String> {
    if array::arg_is_array(epart) {
        match array::get_arraytype_basetype(ln_no, epart) {
            Some(btype) => {
                return Some(btype);
            },
            None => {
                return None;
            },
        }
    } else if deref_okay && epart.contains("@:") {
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

fn resolve_array_val(ln_no: u64, epart: &str) -> Option<String>{
    if array::arg_is_array(epart) {
        return array::get_value(ln_no, epart);
    } else if outputs::varname_is_fn_arg_in_active_fn(epart) {
        return Some(outputs::get_fn_arg_varname_in_active_fn(epart).clone());
    } else {
        return Some(epart.to_string());
    }
}

pub fn resolve_varname(_ln_no: u64, epart: &str) -> Option<String>{
    if outputs::varname_is_fn_arg_in_active_fn(epart) {
        return Some(outputs::get_fn_arg_varname_in_active_fn(epart).clone());
    } else {
        return Some(epart.to_string());
    }
}

fn is_binary_literal(epart: &str) -> bool {
    let mut is_binary_lit: bool = false;
    if !epart.starts_with("0b") {
        return false;
    }

    for c in epart[2..].chars() {
        if c == '0' {
            is_binary_lit = true;
            continue;
        } else if c == '1' {
            is_binary_lit = true;
            continue;
        } else {
            return false;
        }
    }
    return is_binary_lit;
}
fn is_hex_literal(epart: &str) -> bool {
    let mut is_hex_lit: bool = false;
    if !epart.starts_with("0x") {
        return false;
    }

    for c in epart[2..].chars() {
        if c.is_ascii_hexdigit() {
            is_hex_lit = true;
            continue;
        } else {
            return false;
        }
    }
    return is_hex_lit;
}
fn is_uint_literal(epart: &str) -> bool {
    let mut is_uint_lit: bool = false;

    for c in epart.chars() {
        if c.is_digit(10) {
            is_uint_lit = true;
            continue;
        } else {
            return false;
        }
    }
    return is_uint_lit;
}

fn get_binary_literal_value(epart: &str) -> Option<u64> {
    let mut value:     u64 = 0;
    let mut bit_worth: u64 = 1;

    let reversed: String = epart.chars().rev().collect::<String>();

    for c in reversed.chars() {
        if c == 'b' {
            break;
        } else if c == '1' {
            value += bit_worth;
        }

        bit_worth = bit_worth*2;
    }
    return Some(value);
}
fn get_hex_literal_value(epart: &str) -> Option<u64> {
    let mut value:     u64 = 0;
    let mut bit_worth: u64 = 1;
    let mut nextval:   u64;

    let reversed: String = epart.chars().rev().collect::<String>();

    for c in reversed.chars() {
        if c == 'x' {
            break;
        }
        match c {
            'x'       => { break; },
            '0'       => { nextval = 0; },
            '1'       => { nextval = 1; },
            '2'       => { nextval = 2; },
            '3'       => { nextval = 3; },
            '4'       => { nextval = 4; },
            '5'       => { nextval = 5; },
            '6'       => { nextval = 6; },
            '7'       => { nextval = 7; },
            '8'       => { nextval = 8; },
            '9'       => { nextval = 9; },
            'a' | 'A' => { nextval = 10; },
            'b' | 'B' => { nextval = 11; },
            'c' | 'C' => { nextval = 12; },
            'd' | 'D' => { nextval = 13; },
            'e' | 'E' => { nextval = 14; },
            'f' | 'F' => { nextval = 15; },
            _ => { return None; }
        };

        value += bit_worth*nextval;

        bit_worth = bit_worth*16;
    }
    return Some(value);
}
fn get_uint_literal_value(epart: &str) -> Option<u64> {
    match epart.parse::<u64>() {
        Ok(value) => { return Some(value); },
        Err(_) => { return None; }
    }
}

pub fn is_type_u8(ln_no: u64, epart: &str, deref_okay: bool) -> bool {
    match get_evalpart_basetype(ln_no, epart, deref_okay) {
        Some(btype) => {
            if btype == "u8" {
                return true;
            } else if btype == "char" {
                return true;
            }
            return false;
        },
        None => {},
    }

    if is_binary_literal(epart) {
        let value = get_binary_literal_value(epart).unwrap();
        if value <= 255 {
            return true;
        } else {
            return false;
        }
    } else if is_hex_literal(epart) {
        let value = get_hex_literal_value(epart).unwrap();
        if value <= 255 {
            return true;
        } else {
            return false;
        }
    } else if is_uint_literal(epart) {
        let value = get_uint_literal_value(epart).unwrap();
        if value <= 255 {
            return true;
        } else {
            return false;
        }
    }

    return false;
}

pub fn get_u8_value_str(ln_no: u64, epart: &str, deref_okay: bool) -> Option<String> {
    if !is_type_u8(ln_no, epart, deref_okay) {
        return None
    }

    if is_binary_literal(epart) {
        return Some(epart.to_string());
    } else if is_hex_literal(epart) {
        return Some(epart.to_string());
    } else if is_uint_literal(epart) {
        return Some(epart.to_string());
    } else if is_direct_deref(epart) {
        return Some(get_direct_deref_str(epart));
    } else {
        return resolve_array_val(ln_no, epart);
    }
}

pub fn is_type_u16(ln_no: u64, epart: &str, deref_okay: bool) -> bool {
    match get_evalpart_basetype(ln_no, epart, deref_okay) {
        Some(btype) => {
            if btype == "u16" {
                return true;
            }
            return false;
        },
        None => {},
    }

    if is_binary_literal(epart) {
        let value = get_binary_literal_value(epart).unwrap();
        if value <= 0xFFFF {
            return true;
        } else {
            return false;
        }
    } else if is_hex_literal(epart) {
        let value = get_hex_literal_value(epart).unwrap();
        if value <= 0xFFFF {
            return true;
        } else {
            return false;
        }
    } else if is_uint_literal(epart) {
        let value = get_uint_literal_value(epart).unwrap();
        if value <= 0xFFFF {
            return true;
        } else {
            return false;
        }
    }

    return false;
}

pub fn get_u16_value_str(ln_no: u64, epart: &str, deref_okay: bool) -> Option<String> {
    if !is_type_u16(ln_no, epart, deref_okay) {
        return None
    }

    if is_binary_literal(epart) {
        return Some(epart.to_string());
    } else if is_hex_literal(epart) {
        return Some(epart.to_string());
    } else if is_uint_literal(epart) {
        return Some(epart.to_string());
    } else if is_direct_deref(epart) {
        return Some(get_direct_deref_str(epart));
    } else {
        return resolve_array_val(ln_no, epart);
    }
}

pub fn is_type_u24(ln_no: u64, epart: &str, deref_okay: bool) -> bool {
    match get_evalpart_basetype(ln_no, epart, deref_okay) {
        Some(btype) => {
            if btype == "u24" {
                return true;
            }
            return false;
        },
        None => {},
    }

    if is_binary_literal(epart) {
        let value = get_binary_literal_value(epart).unwrap();
        if value <= 0xFFFFFF {
            return true;
        } else {
            return false;
        }
    } else if is_hex_literal(epart) {
        let value = get_hex_literal_value(epart).unwrap();
        if value <= 0xFFFFFF {
            return true;
        } else {
            return false;
        }
    } else if is_uint_literal(epart) {
        let value = get_uint_literal_value(epart).unwrap();
        if value <= 0xFFFFFF {
            return true;
        } else {
            return false;
        }
    }

    return false;
}

pub fn get_u24_value_str(ln_no: u64, epart: &str, deref_okay: bool) -> Option<String> {
    if !is_type_u24(ln_no, epart, deref_okay) {
        return None
    }

    if is_binary_literal(epart) {
        return Some(epart.to_string());
    } else if is_hex_literal(epart) {
        return Some(epart.to_string());
    } else if is_uint_literal(epart) {
        return Some(epart.to_string());
    } else if is_direct_deref(epart) {
        return Some(get_direct_deref_str(epart));
    } else {
        return resolve_array_val(ln_no, epart);
    }
}