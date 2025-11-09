use crate::vll::builtins;
use crate::vll::get;
use crate::vll::fn_args;
use crate::vll::outputs;

use crate::vll::line_part::LinePart;


fn as_type_u8(part: LinePart) -> bool {
    let varname      = part.get_next().next;
    let varname_part = part.get_next();
    let orval        = varname_part.get_next().next;
    let orval_part   = varname_part.get_next();
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

    if !fn_args::is_type_u8(&orval_part) {
        return true;
    }
    match fn_args::get_u8_value_str(&orval_part) {
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
    let orval        = varname_part.get_next().next;
    let orval_part   = varname_part.get_next();
    let orval_res: String;

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

    if orval_part.is_varname() {
        orval_res = get::var_fullname(&orval);

        match outputs::get_vartype(&orval_res) {
            Some(vtype) => {
                if vtype != "u16" {
                    println!(
                        "WARNING: ln:{} Expected a u16 type; got `{}`, which is type `{}`",
                        part.ln_no, orval, vtype)
                }
            },
            None => {},
        }

        outputs::mainfn_append(&format!("   lda {orval_res}"));
        outputs::mainfn_append(         "   sta r0");
        outputs::mainfn_append(&format!("   lda {varname_res}"));
        outputs::mainfn_append(         "   and r0");
        outputs::mainfn_append(&format!("   sta {varname_res}"));
        outputs::mainfn_append(&format!("   lda {orval_res}+1"));
        outputs::mainfn_append(         "   sta r0");
        outputs::mainfn_append(&format!("   lda {varname_res}+1"));
        outputs::mainfn_append(         "   and r0");
        outputs::mainfn_append(&format!("   sta {varname_res}+1"));

    } else {
        let orval_val = orval.parse::<i64>().unwrap();
        if orval_val <= 0xFFFF {

            outputs::mainfn_append(&format!("   lda #<{orval}"));
            outputs::mainfn_append(         "   sta r0");
            outputs::mainfn_append(&format!("   lda {varname_res}"));
            outputs::mainfn_append(         "   and r0");
            outputs::mainfn_append(&format!("   sta {varname_res}"));
            outputs::mainfn_append(&format!("   lda #>{orval}"));
            outputs::mainfn_append(         "   sta r0");
            outputs::mainfn_append(&format!("   lda {varname_res}+1"));
            outputs::mainfn_append(         "   and r0");
            outputs::mainfn_append(&format!("   sta {varname_res}+1"));

        } else {
            println!("ERROR: ln:{} Direct or of U16 value `{}` exceeds bounds.",
                part.ln_no, orval);
            return true;
        }
    }
    outputs::mainfn_append("");

    return false;
}

pub fn now(part: LinePart) -> bool {

    if part.next == "bitwise_and__u8" {
        return as_type_u8(part);

    } else if part.next == "bitwise_and__u16" {
        return as_type_u16(part);

    } else {
        println!(
            "ERROR: ln:{} Unhandled builtin function variant `{}`.",
            part.ln_no, part.next);
        return true;
    }
}
