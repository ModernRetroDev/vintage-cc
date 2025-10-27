use crate::vll::get;
use crate::vll::outputs;

use crate::vll::line_part::LinePart;


fn is_binary_literal(part: &LinePart) -> bool {
    let mut is_binary_lit: bool = false;
    if !part.next.starts_with("0b") {
        return false;
    }

    for c in part.next[2..].chars() {
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
fn is_hex_literal(part: &LinePart) -> bool {
    let mut is_hex_lit: bool = false;
    if !part.next.starts_with("0x") {
        return false;
    }

    for c in part.next[2..].chars() {
        if c.is_ascii_hexdigit() {
            is_hex_lit = true;
            continue;
        } else {
            return false;
        }
    }
    return is_hex_lit;
}
fn is_uint_literal(part: &LinePart) -> bool {
    let mut is_uint_lit: bool = false;

    for c in part.next.chars() {
        if c.is_digit(10) {
            is_uint_lit = true;
            continue;
        } else {
            return false;
        }
    }
    return is_uint_lit;
}

fn get_binary_literal_value(part: &LinePart) -> Option<u64> {
    let mut value:     u64 = 0;
    let mut bit_worth: u64 = 1;

    let reversed: String = part.next.chars().rev().collect::<String>();

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
fn get_hex_literal_value(part: &LinePart) -> Option<u64> {
    let mut value:     u64 = 0;
    let mut bit_worth: u64 = 1;
    let mut nextval:   u64 = 0;

    let reversed: String = part.next.chars().rev().collect::<String>();

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
fn get_uint_literal_value(part: &LinePart) -> Option<u64> {
    match part.next.parse::<u64>() {
        Ok(value) => { return Some(value); },
        Err(_) => { return None; }
    }
}

pub fn is_type_u8(part: &LinePart) -> bool {
    if part.is_varname() {
        let part_res = get::var_fullname(&part.next);
        //--------------------------------------------------------------------//
        // Extract the variable name                                          //
        //--------------------------------------------------------------------//
        let vartype: String;
        match outputs::get_vartype(&part_res) {
            Some(vtype) => { vartype = vtype; },
            None => { return false; },
        }
        if vartype == "u8" {
            return true;
        }
        return false;
    } else if is_binary_literal(&part) {
        let value = get_binary_literal_value(&part).unwrap();
        if value <= 255 {
            return true;
        } else {
            return false;
        }
    } else if is_hex_literal(&part) {
        let value = get_hex_literal_value(&part).unwrap();
        if value <= 255 {
            return true;
        } else {
            return false;
        }
    } else if is_uint_literal(&part) {
        let value = get_uint_literal_value(&part).unwrap();
        if value <= 255 {
            return true;
        } else {
            return false;
        }
    }

    return false;
}

pub fn get_u8_value_str(part: &LinePart) -> Option<String> {
    if !is_type_u8(part) {
        return None
    }

    if part.is_varname() {
        return Some(get::var_fullname(&part.next));
    } else if is_binary_literal(&part) {
        match get_binary_literal_value(&part) {
            Some(value) => { return Some(format!("#{}", value)); }
            None =>        { return None; }
        };
    } else if is_hex_literal(&part) {
        match get_hex_literal_value(&part) {
            Some(value) => { return Some(format!("#{}", value)); }
            None =>        { return None; }
        };
    } else if is_uint_literal(&part) {
        match get_uint_literal_value(&part) {
            Some(value) => { return Some(format!("#{}", value)); }
            None =>        { return None; }
        };
    }

    return None;
}

pub fn is_type_u16(part: &LinePart) -> bool {
    if part.is_varname() {
        let part_res = get::var_fullname(&part.next);
        //--------------------------------------------------------------------//
        // Extract the variable name                                          //
        //--------------------------------------------------------------------//
        let vartype: String;
        match outputs::get_vartype(&part_res) {
            Some(vtype) => { vartype = vtype; },
            None => { return false; },
        }
        if vartype == "u16" {
            return true;
        }
        return false;
    } else if is_binary_literal(&part) {
        let value = get_binary_literal_value(&part).unwrap();
        if value <= 0xFFFF {
            return true;
        } else {
            return false;
        }
    } else if is_hex_literal(&part) {
        let value = get_hex_literal_value(&part).unwrap();
        if value <= 0xFFFF {
            return true;
        } else {
            return false;
        }
    } else if is_uint_literal(&part) {
        let value = get_uint_literal_value(&part).unwrap();
        if value <= 0xFFFF {
            return true;
        } else {
            return false;
        }
    }

    return false;
}

pub fn get_u16_value_str(part: &LinePart) -> Option<String> {
    if !is_type_u16(part) {
        return None
    }

    if part.is_varname() {
        return Some(get::var_fullname(&part.next));
    } else if is_binary_literal(&part) {
        match get_binary_literal_value(&part) {
            Some(value) => { return Some(format!("#{}", value)); }
            None =>        { return None; }
        };
    } else if is_hex_literal(&part) {
        match get_hex_literal_value(&part) {
            Some(value) => { return Some(format!("#{}", value)); }
            None =>        { return None; }
        };
    } else if is_uint_literal(&part) {
        match get_uint_literal_value(&part) {
            Some(value) => { return Some(format!("#{}", value)); }
            None =>        { return None; }
        };
    }

    return None;
}