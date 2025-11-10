use crate::vll::builtins;
use crate::vll::fn_args;
use crate::vll::get;
use crate::vll::outputs;

use crate::vll::line_part::LinePart;


fn as_types_u8_u8(part: LinePart) -> bool {
    let varname      = part.get_next().next;
    let varname_part = part.get_next();
    let sub        = varname_part.get_next().next;
    let sub_part   = varname_part.get_next();
    let resolved: String;

    if !varname_part.is_varname() {
        println!("ERROR: ln:{} Expected varname, got `{}`",
            part.ln_no, varname);
        return true;
    }

    //------------------------------------------------------------------------//
    // Extract the variable name                                              //
    //------------------------------------------------------------------------//
    let varname_full = get::var_fullname(&varname);
    match outputs::get_vartype(&varname_full) {
        Some(vtype) => {
            if vtype != "u8" {
                println!(
                    "WARNING: ln:{} Expected a u8 type; got `{}`, which is type `{}`",
                    part.ln_no, varname, vtype)
            }
        },
        None => {},
    }

    if !fn_args::is_type_u8(&sub_part) {
        return true;
    }
    match fn_args::get_u8_value_str(&sub_part) {
        Some(val_str) => { resolved = val_str; },
        None => { return true; },
    };

    outputs::mainfn_append(&format!("   ; minus_equals__u8_u8 {} {}",
        varname, sub));
    outputs::mainfn_append(&format!("   lda {}", varname_full));
    outputs::mainfn_append(         "   sec ; set carry");
    outputs::mainfn_append(&format!("   sbc {}", resolved));
    outputs::mainfn_append(&format!("   sta {}", varname_full));
    outputs::mainfn_append("");

    return false;
}

fn as_types_u16_u8(part: LinePart) -> bool {
    let varname      = part.get_next().next;
    let varname_part = part.get_next();
    let varname_res: String;
    let sub      = varname_part.get_next().next;
    let sub_part = varname_part.get_next();
    let sub_res: String;

    builtins::mark_as_used(&part.next);

    if !varname_part.is_varname() {
        println!("ERROR: ln:{} Expected varname, got `{}`",
            part.ln_no, varname);
        return true;
    }

    //------------------------------------------------------------------------//
    // Extract the variable name                                              //
    //------------------------------------------------------------------------//
    varname_res = get::var_fullname(&varname);
    match outputs::get_vartype(&varname_res) {
        Some(vtype) => {
            if vtype != "u16" {
                println!(
                    "WARNING: ln:{} Expected a u16 type; got `{}`, which is type `{}`",
                    part.ln_no, varname, vtype)
            }
        },
        None => {},
    }

    outputs::mainfn_append(&format!(
        "   ; minus_equals__u16_u8 {varname} {sub}"));

    if sub_part.is_varname() {
        sub_res = get::var_fullname(&sub);

        match outputs::get_vartype(&sub_res) {
            Some(vtype) => {
                if vtype != "u8" {
                    println!(
                        "WARNING: ln:{} Expected a u8 type; got `{}`, which is type `{}`",
                        part.ln_no, sub, vtype)
                }
            },
            None => {},
        }

        outputs::mainfn_append(&format!("   lda #<{varname_res}"));
        outputs::mainfn_append(         "   sta ZP_PTR_1");
        outputs::mainfn_append(&format!("   lda #>{varname_res}"));
        outputs::mainfn_append(         "   sta ZP_PTR_1+1");
        //
        outputs::mainfn_append(&format!("   lda #<{sub_res}"));
        outputs::mainfn_append(         "   sta ZP_PTR_2");
        outputs::mainfn_append(&format!("   lda #>{sub_res}"));
        outputs::mainfn_append(         "   sta ZP_PTR_2+1");
        //
        outputs::mainfn_append(         "   jsr _minus_equals__u16_u8");

    } else {
        let sub_val = sub.parse::<i64>().unwrap();
        if sub_val <= 0xFF {

            outputs::mainfn_append(&format!("   lda #<{varname_res}"));
            outputs::mainfn_append(         "   sta ZP_PTR_1");
            outputs::mainfn_append(&format!("   lda #>{varname_res}"));
            outputs::mainfn_append(         "   sta ZP_PTR_1+1");
            //
            outputs::mainfn_append(&format!("   lda #{sub}"));
            outputs::mainfn_append(         "   jsr _minus_equals__u16_u8d");

        } else {
            println!("ERROR: ln:{} Direct subtraction of U8 value `{}` exceeds bounds.",
                part.ln_no, sub);
            return true;
        }
    }
    outputs::mainfn_append("");

    return false;
}

fn as_types_u16_u16(part: LinePart) -> bool {
    let varname      = part.get_next().next;
    let varname_part = part.get_next();
    let varname_res: String;
    let sub        = varname_part.get_next().next;
    let sub_part   = varname_part.get_next();
    let sub_res: String;

    builtins::mark_as_used(&part.next);

    if !varname_part.is_varname() {
        println!("ERROR: ln:{} Expected varname, got `{}`",
            part.ln_no, varname);
        return true;
    }

    //------------------------------------------------------------------------//
    // Extract the variable name                                              //
    //------------------------------------------------------------------------//
    varname_res = get::var_fullname(&varname);
    match outputs::get_vartype(&varname_res) {
        Some(vtype) => {
            if vtype != "u16" {
                println!(
                    "WARNING: ln:{} Expected a u16 type; got `{}`, which is type `{}`",
                    part.ln_no, varname, vtype)
            }
        },
        None => {},
    }

    outputs::mainfn_append(&format!(
        "   ; minus_equals__u16_u16 {varname} {sub}"));

    if sub_part.is_varname() {
        sub_res = get::var_fullname(&sub);

        match outputs::get_vartype(&sub_res) {
            Some(vtype) => {
                if vtype != "u16" {
                    println!(
                        "WARNING: ln:{} Expected a u16 type; got `{}`, which is type `{}`",
                        part.ln_no, sub, vtype)
                }
            },
            None => {},
        }

        outputs::mainfn_append(&format!("   lda #<{varname_res}"));
        outputs::mainfn_append(         "   sta ZP_PTR_1");
        outputs::mainfn_append(&format!("   lda #>{varname_res}"));
        outputs::mainfn_append(         "   sta ZP_PTR_1+1");
        //
        outputs::mainfn_append(&format!("   lda #<{sub_res}"));
        outputs::mainfn_append(         "   sta ZP_PTR_2");
        outputs::mainfn_append(&format!("   lda #>{sub_res}"));
        outputs::mainfn_append(         "   sta ZP_PTR_2+1");
        //
        outputs::mainfn_append(         "   jsr _minus_equals__u16_u16");

    } else {
        let sub_val = sub.parse::<i64>().unwrap();
        if sub_val <= 0xFF {

            outputs::mainfn_append(&format!("   lda #<{varname_res}"));
            outputs::mainfn_append(         "   sta ZP_PTR_1");
            outputs::mainfn_append(&format!("   lda #>{varname_res}"));
            outputs::mainfn_append(         "   sta ZP_PTR_1+1");
            //
            outputs::mainfn_append(&format!("   lda #{sub}"));
            outputs::mainfn_append(         "   jsr _minus_equals__u16_u8d");

        } else if sub_val <= 0xFFFF {

            outputs::mainfn_append(&format!("   lda #<{varname_res}"));
            outputs::mainfn_append(         "   sta ZP_PTR_1");
            outputs::mainfn_append(&format!("   lda #>{varname_res}"));
            outputs::mainfn_append(         "   sta ZP_PTR_1+1");
            //
            outputs::mainfn_append(&format!("   lda #<{sub}"));
            outputs::mainfn_append(&format!("   ldx #>{sub}"));
            outputs::mainfn_append(         "   jsr _minus_equals__u16_u16d");

        } else {
            println!("ERROR: ln:{} Direct subtract of U16 value `{}` exceeds bounds.",
                part.ln_no, sub);
            return true;
        }
    }
    outputs::mainfn_append("");

    return false;
}

fn as_types_u24_u8(part: LinePart) -> bool {
    let varname      = part.get_next().next;
    let varname_part = part.get_next();
    let varname_res: String;
    let sub        = varname_part.get_next().next;
    let sub_part   = varname_part.get_next();
    let sub_res: String;

    builtins::mark_as_used("minus_equals__u24_u24d");

    if !varname_part.is_varname() {
        println!("ERROR: ln:{} Expected varname, got `{}`",
            part.ln_no, varname);
        return true;
    }

    //------------------------------------------------------------------------//
    // Extract the variable name                                              //
    //------------------------------------------------------------------------//
    varname_res = get::var_fullname(&varname);
    match outputs::get_vartype(&varname_res) {
        Some(vtype) => {
            if vtype != "u24" {
                println!(
                    "WARNING: ln:{} Expected a u24 type; got `{}`, which is type `{}`",
                    part.ln_no, varname, vtype)
            }
        },
        None => {},
    }

    outputs::mainfn_append(
        &format!("   ; minus_equals__u24_u8 {varname} {sub}"));

    if !fn_args::is_type_u8(&sub_part) {
        return true;
    }
    match fn_args::get_u8_value_str(&sub_part) {
        Some(val_str) => { sub_res = val_str; },
        None => { return true; },
    };

    outputs::mainfn_append(&format!("   lda #<{varname_res}"));
    outputs::mainfn_append(         "   sta ZP_PTR_1");
    outputs::mainfn_append(&format!("   lda #>{varname_res}"));
    outputs::mainfn_append(         "   sta ZP_PTR_1+1");
    //
    outputs::mainfn_append(&format!("   lda {sub_res}"));
    outputs::mainfn_append(         "   sta r0");
    outputs::mainfn_append(         "   lda #0");
    outputs::mainfn_append(         "   sta r0+1");
    outputs::mainfn_append(         "   lda #0");
    outputs::mainfn_append(         "   sta r0+2");
    //
    outputs::mainfn_append(         "   jsr _minus_equals__u24_u24d");
    outputs::mainfn_append("");

    return false;
}

fn as_types_u24_u16(part: LinePart) -> bool {
    let varname      = part.get_next().next;
    let varname_part = part.get_next();
    let varname_res: String;
    let sub        = varname_part.get_next().next;
    let sub_part   = varname_part.get_next();
    let sub_res: String;

    builtins::mark_as_used("minus_equals__u24_u24d");

    if !varname_part.is_varname() {
        println!("ERROR: ln:{} Expected varname, got `{}`",
            part.ln_no, varname);
        return true;
    }

    //------------------------------------------------------------------------//
    // Extract the variable name                                              //
    //------------------------------------------------------------------------//
    varname_res = get::var_fullname(&varname);
    match outputs::get_vartype(&varname_res) {
        Some(vtype) => {
            if vtype != "u24" {
                println!(
                    "WARNING: ln:{} Expected a u24 type; got `{}`, which is type `{}`",
                    part.ln_no, varname, vtype)
            }
        },
        None => {},
    }

    outputs::mainfn_append(&format!(
        "   ; minus_equals__u24_u16 {varname} {sub}"));

    if !fn_args::is_type_u16(&sub_part) {
        return true;
    }
    match fn_args::get_u16_value_str(&sub_part) {
        Some(val_str) => { sub_res = val_str; },
        None => { return true; },
    };

    if sub_part.is_varname() {
        outputs::mainfn_append(&format!("   lda #<{varname_res}"));
        outputs::mainfn_append(         "   sta ZP_PTR_1");
        outputs::mainfn_append(&format!("   lda #>{varname_res}"));
        outputs::mainfn_append(         "   sta ZP_PTR_1+1");
        //
        outputs::mainfn_append(&format!("   lda {sub_res}"));
        outputs::mainfn_append(         "   sta r0");
        outputs::mainfn_append(&format!("   lda {sub_res}+1"));
        outputs::mainfn_append(         "   sta r0+1");
        outputs::mainfn_append(         "   lda #0");
        outputs::mainfn_append(         "   sta r0+2");
        //
        outputs::mainfn_append(         "   jsr _minus_equals__u24_u24d");
    } else {
        let sub_val = &sub_res[1..].parse::<i64>().unwrap();
        let sub_hexstr: String = format!("{:04X}", sub_val);
        // b0 is the low byte
        let sub_hex_b0 = &sub_hexstr[2..4];
        // b1 is the high byte
        let sub_hex_b1 = &sub_hexstr[0..2];

        outputs::mainfn_append(&format!("   lda #<{varname_res}"));
        outputs::mainfn_append(         "   sta ZP_PTR_1");
        outputs::mainfn_append(&format!("   lda #>{varname_res}"));
        outputs::mainfn_append(         "   sta ZP_PTR_1+1");
        //
        outputs::mainfn_append(&format!("   lda #${sub_hex_b0}"));
        outputs::mainfn_append(         "   sta r0");
        outputs::mainfn_append(&format!("   lda #${sub_hex_b1}"));
        outputs::mainfn_append(         "   sta r0+1");
        outputs::mainfn_append(         "   lda #0");
        outputs::mainfn_append(         "   sta r0+2");
        //
        outputs::mainfn_append(         "   jsr _minus_equals__u24_u24d");
    }
    outputs::mainfn_append("");

    return false;
}

fn as_types_u24_u24(part: LinePart) -> bool {
    let varname      = part.get_next().next;
    let varname_part = part.get_next();
    let varname_res: String;
    let sub        = varname_part.get_next().next;
    let sub_part   = varname_part.get_next();
    let sub_res: String;

    if !varname_part.is_varname() {
        println!("ERROR: ln:{} Expected varname, got `{}`",
            part.ln_no, varname);
        return true;
    }

    //------------------------------------------------------------------------//
    // Extract the variable name                                              //
    //------------------------------------------------------------------------//
    varname_res = get::var_fullname(&varname);
    match outputs::get_vartype(&varname_res) {
        Some(vtype) => {
            if vtype != "u24" {
                println!(
                    "WARNING: ln:{} Expected a u24 type; got `{}`, which is type `{}`",
                    part.ln_no, varname, vtype)
            }
        },
        None => {},
    }

    outputs::mainfn_append(
        &format!("   ; minus_equals__u24_u24 {varname} {sub}"));


    if !fn_args::is_type_u24(&sub_part) {
        println!(
            "ERROR: ln:{} EQUALS: Expected a u24 type; got `{}` instead.",
            part.ln_no, sub);
        return true;
    }
    match fn_args::get_u24_value_str(&sub_part) {
        Some(val_str) => { sub_res = val_str; },
        None => {
            println!("ERROR: ln:{} Failed to get u24 value of `{}`",
                part.ln_no, sub_part.next);
            return true;
        },
    };


    if sub_res.starts_with("#") {
        builtins::mark_as_used("minus_equals__u24_u24d");

        let sub_val = &sub_res[1..].parse::<i64>().unwrap();
        let sub_hexstr: String = format!("{:06X}", sub_val);
        // b0 is the low byte
        let sub_hex_b0 = &sub_hexstr[4..6];
        // b1 is the med byte
        let sub_hex_b1 = &sub_hexstr[2..4];
        // b2 is the high byte
        let sub_hex_b2 = &sub_hexstr[0..2];

        outputs::mainfn_append(&format!("   lda #<{varname_res}"));
        outputs::mainfn_append(         "   sta ZP_PTR_1");
        outputs::mainfn_append(&format!("   lda #>{varname_res}"));
        outputs::mainfn_append(         "   sta ZP_PTR_1+1");
        //
        outputs::mainfn_append(&format!("   lda #${sub_hex_b0}"));
        outputs::mainfn_append(         "   sta r0");
        outputs::mainfn_append(&format!("   lda #${sub_hex_b1}"));
        outputs::mainfn_append(         "   sta r0+1");
        outputs::mainfn_append(&format!("   lda #${sub_hex_b2}"));
        outputs::mainfn_append(         "   sta r0+2");
        //
        outputs::mainfn_append(         "   jsr _minus_equals__u24_u24d");
    } else {
        builtins::mark_as_used("minus_equals__u24_u24");

        outputs::mainfn_append(&format!("   lda #<{varname_res}"));
        outputs::mainfn_append(         "   sta ZP_PTR_1");
        outputs::mainfn_append(&format!("   lda #>{varname_res}"));
        outputs::mainfn_append(         "   sta ZP_PTR_1+1");
        //
        outputs::mainfn_append(&format!("   lda #<{sub_res}"));
        outputs::mainfn_append(         "   sta ZP_PTR_2");
        outputs::mainfn_append(&format!("   lda #>{sub_res}"));
        outputs::mainfn_append(         "   sta ZP_PTR_2+1");
        //
        outputs::mainfn_append(         "   jsr _minus_equals__u24_u24");
    }
    outputs::mainfn_append("");

    return false;
}

pub fn now(part: LinePart) -> bool {

    if part.next == "minus_equals__u8_u8" {
        return as_types_u8_u8(part);

    } else if part.next == "minus_equals__u16_u8" {
        return as_types_u16_u8(part);

    } else if part.next == "minus_equals__u16_u16" {
        return as_types_u16_u16(part);

    } else if part.next == "minus_equals__u24_u8" {
        return as_types_u24_u8(part);

    } else if part.next == "minus_equals__u24_u16" {
        return as_types_u24_u16(part);

    } else if part.next == "minus_equals__u24_u24" {
        return as_types_u24_u24(part);

    } else {
        println!(
            "ERROR: ln:{} Unhandled builtin function variant `{}`.",
            part.ln_no, part.next);
        return true;
    }
}
