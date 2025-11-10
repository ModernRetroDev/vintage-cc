use crate::vll::builtins;
use crate::vll::get;
use crate::vll::fn_args;
use crate::vll::outputs;

use crate::vll::line_part::LinePart;


fn as_type_u8(part: LinePart) -> bool {
    let varname      = part.get_next().next;
    let varname_part = part.get_next();
    let andval        = varname_part.get_next().next;
    let andval_part   = varname_part.get_next();
    let resolved: String;

    if !varname_part.is_varname() {
        println!("ERROR: ln:{} Expected varname, got `{}`",
            part.ln_no, varname);
        return true;
    }

    //------------------------------------------------------------------------//
    // Extract the variable name                                              //
    //------------------------------------------------------------------------//
    let varname_res = get::var_fullname(&varname);
    match outputs::get_vartype(&varname_res) {
        Some(vtype) => {
            if vtype != "u8" {
                println!(
                    "WARNING: ln:{} Expected a u8 type; got `{}`, which is type `{}`",
                    part.ln_no, varname, vtype)
            }
        },
        None => {},
    }

    if !fn_args::is_type_u8(&andval_part) {
        return true;
    }
    match fn_args::get_u8_value_str(&andval_part) {
        Some(val_str) => { resolved = val_str; },
        None => { return true; },
    };

    outputs::mainfn_append(&format!("   ; bitwise_and__u8 {varname}"));
    outputs::mainfn_append(&format!("   lda {resolved}"));
    outputs::mainfn_append(         "   sta r0");
    outputs::mainfn_append(&format!("   lda {varname_res}"));
    outputs::mainfn_append(         "   and r0");
    outputs::mainfn_append(&format!("   sta {varname_res}"));
    outputs::mainfn_append("");

    return false;
}

fn as_type_u16(part: LinePart) -> bool {
    let varname      = part.get_next().next;
    let varname_part = part.get_next();
    let varname_res: String;
    let andval        = varname_part.get_next().next;
    let andval_part   = varname_part.get_next();
    let andval_res: String;

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

    outputs::mainfn_append(&format!("   ; bitwise_and__u16 {varname}"));

    if andval_part.is_varname() {
        andval_res = get::var_fullname(&andval);

        match outputs::get_vartype(&andval_res) {
            Some(vtype) => {
                if vtype != "u16" {
                    println!(
                        "WARNING: ln:{} Expected a u16 type; got `{}`, which is type `{}`",
                        part.ln_no, andval, vtype)
                }
            },
            None => {},
        }

        outputs::mainfn_append(&format!("   lda {andval_res}"));
        outputs::mainfn_append(         "   sta r0");
        outputs::mainfn_append(&format!("   lda {varname_res}"));
        outputs::mainfn_append(         "   and r0");
        outputs::mainfn_append(&format!("   sta {varname_res}"));
        outputs::mainfn_append(&format!("   lda {andval_res}+1"));
        outputs::mainfn_append(         "   sta r0");
        outputs::mainfn_append(&format!("   lda {varname_res}+1"));
        outputs::mainfn_append(         "   and r0");
        outputs::mainfn_append(&format!("   sta {varname_res}+1"));

    } else {
        let andval_val = andval.parse::<i64>().unwrap();
        if andval_val <= 0xFFFF {

            outputs::mainfn_append(&format!("   lda #<{andval}"));
            outputs::mainfn_append(         "   sta r0");
            outputs::mainfn_append(&format!("   lda {varname_res}"));
            outputs::mainfn_append(         "   and r0");
            outputs::mainfn_append(&format!("   sta {varname_res}"));
            outputs::mainfn_append(&format!("   lda #>{andval}"));
            outputs::mainfn_append(         "   sta r0");
            outputs::mainfn_append(&format!("   lda {varname_res}+1"));
            outputs::mainfn_append(         "   and r0");
            outputs::mainfn_append(&format!("   sta {varname_res}+1"));

        } else {
            println!("ERROR: ln:{} Direct and of U16 value `{}` exceeds bounds.",
                part.ln_no, andval);
            return true;
        }
    }
    outputs::mainfn_append("");

    return false;
}

fn as_type_u24(part: LinePart) -> bool {
    let varname      = part.get_next().next;
    let varname_part = part.get_next();
    let varname_res: String;
    let andval        = varname_part.get_next().next;
    let andval_part   = varname_part.get_next();
    let andval_res: String;

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

    outputs::mainfn_append(&format!("   ; bitwise_and__u24 {varname}"));


    if !fn_args::is_type_u24(&andval_part) {
        println!(
            "ERROR: ln:{} EQUALS: Expected a u24 type; got `{}` instead.",
            part.ln_no, andval);
        return true;
    }
    match fn_args::get_u24_value_str(&andval_part) {
        Some(val_str) => { andval_res = val_str; },
        None => {
            println!("ERROR: ln:{} Failed to get u24 value of `{}`",
                part.ln_no, andval_part.next);
            return true;
        },
    };

    if andval_res.starts_with("#") {
        let andval_val = &andval_res[1..].parse::<i64>().unwrap();
        let andval_hexstr: String = format!("{:06X}", andval_val);
        // b0 is the low byte
        let andval_hex_b0 = &andval_hexstr[4..6];
        // b1 is the med byte
        let andval_hex_b1 = &andval_hexstr[2..4];
        // b2 is the high byte
        let andval_hex_b2 = &andval_hexstr[0..2];

        outputs::mainfn_append(&format!("   lda #${andval_hex_b0}"));
        outputs::mainfn_append(         "   sta r0");
        outputs::mainfn_append(&format!("   lda {varname_res}"));
        outputs::mainfn_append(         "   and r0");
        outputs::mainfn_append(&format!("   sta {varname_res}"));
        //
        outputs::mainfn_append(&format!("   lda #${andval_hex_b1}"));
        outputs::mainfn_append(         "   sta r0");
        outputs::mainfn_append(&format!("   lda {varname_res}+1"));
        outputs::mainfn_append(         "   and r0");
        outputs::mainfn_append(&format!("   sta {varname_res}+1"));
        //
        outputs::mainfn_append(&format!("   lda #${andval_hex_b2}"));
        outputs::mainfn_append(         "   sta r0");
        outputs::mainfn_append(&format!("   lda {varname_res}+2"));
        outputs::mainfn_append(         "   and r0");
        outputs::mainfn_append(&format!("   sta {varname_res}+2"));
    } else {
        outputs::mainfn_append(&format!("   lda {andval_res}"));
        outputs::mainfn_append(         "   sta r0");
        outputs::mainfn_append(&format!("   lda {varname_res}"));
        outputs::mainfn_append(         "   and r0");
        outputs::mainfn_append(&format!("   sta {varname_res}"));
        //
        outputs::mainfn_append(&format!("   lda {andval_res}+1"));
        outputs::mainfn_append(         "   sta r0");
        outputs::mainfn_append(&format!("   lda {varname_res}+1"));
        outputs::mainfn_append(         "   and r0");
        outputs::mainfn_append(&format!("   sta {varname_res}+1"));
        //
        outputs::mainfn_append(&format!("   lda {andval_res}+2"));
        outputs::mainfn_append(         "   sta r0");
        outputs::mainfn_append(&format!("   lda {varname_res}+2"));
        outputs::mainfn_append(         "   and r0");
        outputs::mainfn_append(&format!("   sta {varname_res}+2"));
    }
    outputs::mainfn_append("");

    return false;
}

pub fn now(part: LinePart) -> bool {

    if part.next == "bitwise_and__u8" {
        return as_type_u8(part);

    } else if part.next == "bitwise_and__u16" {
        return as_type_u16(part);

    } else if part.next == "bitwise_and__u24" {
        return as_type_u24(part);

    } else {
        println!(
            "ERROR: ln:{} Unhandled builtin function variant `{}`.",
            part.ln_no, part.next);
        return true;
    }
}
