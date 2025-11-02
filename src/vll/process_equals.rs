use crate::vll::fn_args;
use crate::vll::get;
use crate::vll::outputs;

use crate::vll::line_part::LinePart;


fn as_types_bool_bool(part: LinePart) -> bool {
    let lhs      = part.get_next().next;
    let lhs_part = part.get_next();
    let rhs      = lhs_part.get_next().next;
    let rhs_part = lhs_part.get_next();
    let lhs_res:  String;
    let rhs_res:  String;

    if !lhs_part.is_varname() {
        println!("ERROR: ln:{} Expected varname, got `{}`",
            part.ln_no, lhs);
        return true;
    }
    lhs_res = get::var_fullname(&lhs);

    //------------------------------------------------------------------------//
    // Extract the variable name                                              //
    //------------------------------------------------------------------------//
    let vartype: String;
    match outputs::get_vartype(&lhs_res) {
        Some(vtype) => { vartype = vtype; },
        None => {
            println!("ERROR: ln:{} Undeclared variable `{}`.",
                part.ln_no, lhs);
            return true;
        },
    }
    if vartype != "bool" {
        println!(
            "WARNING: ln:{} EQUALS: Expected a bool type; got `{}`, which is type `{}`",
            part.ln_no, lhs, vartype)
    }

    if rhs_part.is_varname() {
        rhs_res = get::var_fullname(&rhs);
    } else {
        if rhs == "false" {
            rhs_res = format!("#0");
        } else if rhs == "true" {
            rhs_res = format!("#1");
        } else {
            println!("ERROR: ln:{} Unsupported bool type `{}`; expected true or false.",
                part.ln_no, lhs);
            return true;
        }
    }

    outputs::mainfn_append(&format!("   ; equals__bool_bool {} {}",
        lhs, rhs));
    outputs::mainfn_append(&format!("   lda {}", rhs_res));
    outputs::mainfn_append(&format!("   sta {}", lhs_res));
    outputs::mainfn_append("");

    return false;
}

fn as_types_u8_u8(part: LinePart) -> bool {
    let lhs      = part.get_next().next;
    let lhs_part = part.get_next();
    let rhs      = lhs_part.get_next().next;
    let rhs_part = lhs_part.get_next();
    let lhs_res:  String;
    let rhs_res:  String;

    if !lhs_part.is_varname() {
        println!("ERROR: ln:{} Expected varname, got `{}`",
            part.ln_no, lhs);
        return true;
    }
    lhs_res = get::var_fullname(&lhs);

    //------------------------------------------------------------------------//
    // Extract the variable name                                              //
    //------------------------------------------------------------------------//
    let vartype: String;
    match outputs::get_vartype(&lhs_res) {
        Some(vtype) => { vartype = vtype; },
        None => {
            println!("ERROR: ln:{} Undeclared variable `{}`.",
                part.ln_no, lhs);
            return true;
        },
    }
    if vartype != "u8" {
        println!(
            "WARNING: ln:{} EQUALS: Expected a u8 type; got `{}`, which is type `{}`",
            part.ln_no, lhs, vartype)
    }

    if !fn_args::is_type_u8(&rhs_part) {
        return true;
    }
    match fn_args::get_u8_value_str(&rhs_part) {
        Some(val_str) => { rhs_res = val_str; },
        None => {
            println!("ERROR: ln:{} Failed to get u8 value of `{}`",
                part.ln_no, rhs_part.next);
            return true;
        },
    };

    outputs::mainfn_append(&format!("   ; equals__u8_u8 {} {}",
        lhs, rhs));
    outputs::mainfn_append(&format!("   lda {}", rhs_res));
    outputs::mainfn_append(&format!("   sta {}", lhs_res));
    outputs::mainfn_append("");

    return false;
}

fn as_types_u16_u16(part: LinePart) -> bool {
    let lhs      = part.get_next().next;
    let lhs_part = part.get_next();
    let rhs      = lhs_part.get_next().next;
    let rhs_part = lhs_part.get_next();
    let lhs_res:  String;
    let rhs_res:  String;

    if !lhs_part.is_varname() {
        println!("ERROR: ln:{} Expected varname, got `{}`",
            part.ln_no, lhs);
        return true;
    }
    lhs_res = get::var_fullname(&lhs);

    //------------------------------------------------------------------------//
    // Extract the variable name                                              //
    //------------------------------------------------------------------------//
    let vartype: String;
    match outputs::get_vartype(&lhs_res) {
        Some(vtype) => { vartype = vtype; },
        None => {
            println!("ERROR: ln:{} Undeclared variable `{}`.",
                part.ln_no, lhs);
            return true;
        },
    }
    if vartype != "u16" {
        println!(
            "WARNING: ln:{} EQUALS: Expected a u16 type; got `{}`, which is type `{}`",
            part.ln_no, lhs, vartype)
    }

    if !fn_args::is_type_u16(&rhs_part) {
        return true;
    }
    match fn_args::get_u16_value_str(&rhs_part) {
        Some(val_str) => { rhs_res = val_str; },
        None => {
            println!("ERROR: ln:{} Failed to get u16 value of `{}`",
                part.ln_no, rhs_part.next);
            return true;
        },
    };

    outputs::mainfn_append(&format!("   ; equals__u16_u16 {} {}",
        lhs, rhs));

    if rhs_res.starts_with("#") {
        outputs::mainfn_append(&format!("   lda #<{}", &rhs_res[1..]));
        outputs::mainfn_append(&format!("   sta {lhs_res}"));
        outputs::mainfn_append(&format!("   lda #>{}", &rhs_res[1..]));
        outputs::mainfn_append(&format!("   sta {lhs_res}+1"));
    } else {
        outputs::mainfn_append(&format!("   lda {rhs_res}"));
        outputs::mainfn_append(&format!("   sta {lhs_res}"));
        outputs::mainfn_append(&format!("   lda {rhs_res}+1"));
        outputs::mainfn_append(&format!("   sta {lhs_res}+1"));
    }

    outputs::mainfn_append("");

    return false;
}

fn as_types_file_file(part: LinePart) -> bool {
    let lhs      = part.get_next().next;
    let lhs_part = part.get_next();
    let rhs      = lhs_part.get_next().next;
    let rhs_part = lhs_part.get_next();
    let lhs_res:  String;
    let rhs_res:  String;

    if !lhs_part.is_varname() {
        println!("ERROR: ln:{} Expected varname, got `{}`",
            part.ln_no, lhs);
        return true;
    }
    lhs_res = get::var_fullname(&lhs);

    //------------------------------------------------------------------------//
    // Extract the variable name                                              //
    //------------------------------------------------------------------------//
    let vartype: String;
    match outputs::get_vartype(&lhs_res) {
        Some(vtype) => { vartype = vtype; },
        None => {
            println!("ERROR: ln:{} Undeclared variable `{}`.",
                part.ln_no, lhs);
            return true;
        },
    }
    if vartype != "file" && vartype != "file:ptr" {
        println!(
            "WARNING: ln:{} EQUALS: LHS Expected a file type; got `{}`, which is type `{}`",
            part.ln_no, lhs, vartype)
    }

    rhs_res = get::var_fullname(&rhs);

    let vartype_rhs: String;
    match outputs::get_vartype(&rhs_res) {
        Some(vtype) => { vartype_rhs = vtype; },
        None => {
            println!("ERROR: ln:{} Undeclared variable `{}`.",
                part.ln_no, rhs);
            return true;
        },
    }
    if vartype_rhs != "file" && vartype_rhs != "file:ptr" {
        println!(
            "WARNING: ln:{} EQUALS: RHS Expected a file type; got `{}`, which is type `{}`",
            part.ln_no, rhs, vartype_rhs)
    }

    outputs::mainfn_append(&format!("   ; equals__file_file {} {}",
        lhs, rhs));

    if rhs_res.starts_with("#") {
        outputs::mainfn_append(&format!("   lda #<{}", &rhs_res[1..]));
        outputs::mainfn_append(&format!("   sta {lhs_res}"));
        outputs::mainfn_append(&format!("   lda #>{}", &rhs_res[1..]));
        outputs::mainfn_append(&format!("   sta {lhs_res}+1"));
    } else {
        outputs::mainfn_append(&format!("   lda {rhs_res}"));
        outputs::mainfn_append(&format!("   sta {lhs_res}"));
        outputs::mainfn_append(&format!("   lda {rhs_res}+1"));
        outputs::mainfn_append(&format!("   sta {lhs_res}+1"));
    }

    outputs::mainfn_append("");

    return false;
}

fn as_types_u16_u8(part: LinePart, bool_as_u8: bool) -> bool {
    // set a u16 value from a u8 value
    let lhs      = part.get_next().next;
    let lhs_part = part.get_next();
    let rhs      = lhs_part.get_next().next;
    let rhs_part = lhs_part.get_next();
    let lhs_res:  String;
    let rhs_res:  String;

    if !lhs_part.is_varname() {
        println!("ERROR: ln:{} Expected varname, got `{}`",
            part.ln_no, lhs);
        return true;
    }
    lhs_res = get::var_fullname(&lhs);

    //------------------------------------------------------------------------//
    // Extract the variable name                                              //
    //------------------------------------------------------------------------//
    let vartype: String;
    match outputs::get_vartype(&lhs_res) {
        Some(vtype) => { vartype = vtype; },
        None => {
            println!("ERROR: ln:{} Undeclared variable `{}`.",
                part.ln_no, lhs);
            return true;
        },
    }
    if vartype != "u16" {
        println!(
            "WARNING: ln:{} EQUALS: Expected a u16 type; got `{}`, which is type `{}`",
            part.ln_no, lhs, vartype)
    }

    if bool_as_u8 {
        rhs_res = get::var_fullname(&rhs_part.next).clone();
    } else {
        if !fn_args::is_type_u8(&rhs_part) {
            println!("ERROR: ln:{} Provided value `{}`, is not of u8 type.",
                part.ln_no, rhs_part.next);
            return true;
        }
        match fn_args::get_u8_value_str(&rhs_part) {
            Some(val_str) => { rhs_res = val_str; },
            None => {
                println!("ERROR: ln:{} Failed to get u8 value of `{}`",
                    part.ln_no, rhs_part.next);
                return true;
            },
        };
    }

    if bool_as_u8 {
        outputs::mainfn_append(&format!("   ; equals__u16_bool {} {}",
            lhs, rhs));
    } else {
        outputs::mainfn_append(&format!("   ; equals__u16_u8 {} {}",
            lhs, rhs));
    }

    outputs::mainfn_append(&format!("   lda {rhs_res}"));
    outputs::mainfn_append(&format!("   sta {lhs_res}"));
    outputs::mainfn_append(&format!("   lda #0"));
    outputs::mainfn_append(&format!("   sta {lhs_res}+1"));

    outputs::mainfn_append("");

    return false;
}

pub fn now(part: LinePart) -> bool {

    if part.next == "equals__bool_bool" {
        return as_types_bool_bool(part);

    } else if part.next == "equals__file_file" {
        return as_types_file_file(part);

    } else if part.next == "equals__u8_u8" {
        return as_types_u8_u8(part);

    } else if part.next == "equals__u16_u16" {
        return as_types_u16_u16(part);

    } else if part.next == "equals__u16_u8" {
        return as_types_u16_u8(part, false);

    } else if part.next == "equals__u16_bool" {
        return as_types_u16_u8(part, true);

    } else {
        println!(
            "ERROR: ln:{} Unhandled builtin function variant `{}`.",
            part.ln_no, part.next);
        return true;
    }
}
