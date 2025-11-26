use crate::vll::builtins;
use crate::vll::get;
use crate::vll::outputs;

use crate::vll::line_part::LinePart;


fn as_type_arr8(part: LinePart) -> bool {
    let     ptrname      = part.get_next().next;
    let     ptrname_part = part.get_next();
    let     array        = ptrname_part.get_next().next;
    let     array_part   = ptrname_part.get_next();
    let     index        = array_part.get_next().next;
    let     index_part   = array_part.get_next();
    let     ptrname_res: String;
    let     index_res:   String;
    let mut array_res:   String;

    builtins::mark_as_used("ref__arr8");

    //------------------------------------------------------------------------//
    // Check for input errors.                                                //
    //------------------------------------------------------------------------//
    if !ptrname_part.is_varname() {
        println!("ERROR: ln:{} Expected varname, got `{}`",
            part.ln_no, ptrname);
        return true;
    }

    if !array_part.is_varname() {
        println!("ERROR: ln:{} Invalid input. Expected arr8 var; got `{}`",
            part.ln_no, array);
        return true;
    }

    //------------------------------------------------------------------------//
    // Extract the variable name                                              //
    //------------------------------------------------------------------------//
    ptrname_res = get::var_fullname(&ptrname);
    match outputs::get_vartype(&ptrname_res) {
        Some(vtype) => {
            if !(vtype == "ptr" || vtype.ends_with(":ptr")) {
                println!(
                    "ERROR: ln:{} Expected a ptr type; got `{}`, which is type `{}`",
                    part.ln_no, ptrname, vtype);
                return true;
            }
        },
        None => {},
    }

    //------------------------------------------------------------------------//
    // Extract the array name                                                 //
    //------------------------------------------------------------------------//
    array_res = get::arr8_fullname(&array);

    if outputs::get_arr8type(&array_res).is_none() {
        array_res = get::var_fullname(&array);
        if outputs::get_arr8type(&array_res).is_none() {
            println!("ERROR: ln:{} Expected an arr8 type; got `{}` instead",
                part.ln_no, array);
            return true;
        }
    }

    //------------------------------------------------------------------------//
    // Extract the array index                                                //
    //------------------------------------------------------------------------//
    if index_part.is_varname() {
        index_res = get::var_fullname(&index);

        match outputs::get_vartype(&index_res) {
            Some(vtype) => {
                if vtype != "u8" {
                    println!(
                        "ERROR: ln:{} Expected a u8 type; got `{}`, which is type `{}`",
                        part.ln_no, index, vtype)
                }
            },
            None => {},
        }

    } else {
        index_res = format!("#{}", index);
    }


    outputs::mainfn_append(&format!("   ; ref__arr8 {} {} {}",
        ptrname, array, index));
    //
    outputs::mainfn_append(&format!("   lda #<{}", ptrname_res));
    outputs::mainfn_append(         "   sta ZP_PTR_1");
    outputs::mainfn_append(&format!("   lda #>{}", ptrname_res));
    outputs::mainfn_append(         "   sta ZP_PTR_1+1");
    
    outputs::mainfn_append(&format!("   lda #<{}", array_res));
    outputs::mainfn_append(         "   sta ZP_PTR_2");
    outputs::mainfn_append(&format!("   lda #>{}", array_res));
    outputs::mainfn_append(         "   sta ZP_PTR_2+1");
    //
    if index_res.starts_with("#") {
        outputs::mainfn_append(&format!("   lda #<{}", &index_res[1..]));
        outputs::mainfn_append(         "   sta r0");
    } else {
        outputs::mainfn_append(&format!("   lda {index_res}"));
        outputs::mainfn_append(         "   sta r0");
    }
    //
    outputs::mainfn_append(         "   jsr _ref__arr8");
    outputs::mainfn_append("");

    return false;
}

fn as_type_arr16(part: LinePart) -> bool {
    let ptrname      = part.get_next().next;
    let ptrname_part = part.get_next();
    let array        = ptrname_part.get_next().next;
    let array_part   = ptrname_part.get_next();
    let index        = array_part.get_next().next;
    let index_part   = array_part.get_next();
    let array_res:   String;
    let ptrname_res: String;
    let index_res:   String;

    builtins::mark_as_used("ref__arr16");

    //------------------------------------------------------------------------//
    // Check for input errors.                                                //
    //------------------------------------------------------------------------//
    if !ptrname_part.is_varname() {
        println!("ERROR: ln:{} Expected varname, got `{}`",
            part.ln_no, ptrname);
        return true;
    }

    if !array_part.is_varname() {
        println!("ERROR: ln:{} Invalid input. Expected arr16 var; got `{}`",
            part.ln_no, array);
        return true;
    }

    //------------------------------------------------------------------------//
    // Extract the variable name                                              //
    //------------------------------------------------------------------------//
    ptrname_res = get::var_fullname(&ptrname);
    match outputs::get_vartype(&ptrname_res) {
        Some(vtype) => {
            if vtype != "ptr" {
                println!(
                    "ERROR: ln:{} Expected a ptr type; got `{}`, which is type `{}`",
                    part.ln_no, ptrname, vtype);
                return true;
            }
        },
        None => {},
    }

    //------------------------------------------------------------------------//
    // Extract the array name                                                 //
    //------------------------------------------------------------------------//
    array_res = get::arr16_fullname(&array);
    if outputs::get_arr16type(&array_res).is_none() {
        println!("ERROR: ln:{} Expected an arr16 type; got `{}` instead",
            part.ln_no, array);
        return true;
    }

    //------------------------------------------------------------------------//
    // Extract the array index                                                //
    //------------------------------------------------------------------------//
    if index_part.is_varname() {
        index_res = get::var_fullname(&index);

        match outputs::get_vartype(&index_res) {
            Some(vtype) => {
                if vtype != "u16" {
                    println!(
                        "ERROR: ln:{} Expected a u16 type; got `{}`, which is type `{}`",
                        part.ln_no, index, vtype)
                }
            },
            None => {},
        }

    } else {
        index_res = format!("#{}", index);
    }


    outputs::mainfn_append(&format!("   ; ref__arr16 {} {} {}",
        ptrname, array, index));
    //
    outputs::mainfn_append(&format!("   lda #<{}", ptrname_res));
    outputs::mainfn_append(         "   sta ZP_PTR_1");
    outputs::mainfn_append(&format!("   lda #>{}", ptrname_res));
    outputs::mainfn_append(         "   sta ZP_PTR_1+1");
    
    outputs::mainfn_append(&format!("   lda #<{}", array_res));
    outputs::mainfn_append(         "   sta ZP_PTR_2");
    outputs::mainfn_append(&format!("   lda #>{}", array_res));
    outputs::mainfn_append(         "   sta ZP_PTR_2+1");
    //
    if index_res.starts_with("#") {
        outputs::mainfn_append(&format!("   lda #<{}", &index_res[1..]));
        outputs::mainfn_append(         "   sta r0");
        outputs::mainfn_append(&format!("   lda #>{}", &index_res[1..]));
        outputs::mainfn_append(         "   sta r0+1");
    } else {
        outputs::mainfn_append(&format!("   lda {index_res}"));
        outputs::mainfn_append(         "   sta r0");
        outputs::mainfn_append(&format!("   lda {index_res}+1"));
        outputs::mainfn_append(         "   sta r0+1");
    }
    //
    outputs::mainfn_append(         "   jsr _ref__arr16");
    outputs::mainfn_append("");

    return false;
}

fn as_type_str8(part: LinePart) -> bool {
    let ptrname      = part.get_next().next;
    let ptrname_part = part.get_next();
    let string       = ptrname_part.get_next().next;
    let string_part  = ptrname_part.get_next();
    let index        = string_part.get_next().next;
    let index_part   = string_part.get_next();
    let ptrname_res: String;
    let index_res:   String;
    let string_res:  String;

    builtins::mark_as_used("ref__arr8");

    //------------------------------------------------------------------------//
    // Check for input errors.                                                //
    //------------------------------------------------------------------------//
    if !ptrname_part.is_varname() {
        println!("ERROR: ln:{} Expected varname, got `{}`",
            part.ln_no, ptrname);
        return true;
    }

    if !string_part.is_varname() {
        println!("ERROR: ln:{} Invalid input. Expected str8 var; got `{}`",
            part.ln_no, string);
        return true;
    }

    //------------------------------------------------------------------------//
    // Extract the variable name                                              //
    //------------------------------------------------------------------------//
    ptrname_res = get::var_fullname(&ptrname);
    match outputs::get_vartype(&ptrname_res) {
        Some(vtype) => {
            if !(vtype == "ptr" || vtype.ends_with(":ptr")) {
                println!(
                    "ERROR: ln:{} Expected a ptr type; got `{}`, which is type `{}`",
                    part.ln_no, ptrname, vtype);
                return true;
            }
        },
        None => {},
    }

    //------------------------------------------------------------------------//
    // Extract the string name                                                //
    //------------------------------------------------------------------------//
    string_res = get::var_fullname(&string);

    //------------------------------------------------------------------------//
    // Extract the string index                                               //
    //------------------------------------------------------------------------//
    if index_part.is_varname() {
        index_res = get::var_fullname(&index);

        match outputs::get_vartype(&index_res) {
            Some(vtype) => {
                if vtype != "u8" {
                    println!(
                        "ERROR: ln:{} Expected a u8 type; got `{}`, which is type `{}`",
                        part.ln_no, index, vtype)
                }
            },
            None => {},
        }

    } else {
        index_res = format!("#{}", index);
    }


    outputs::mainfn_append(&format!("   ; ref__str8 {} {} {}",
        ptrname, string, index));
    //
    outputs::mainfn_append(&format!("   lda #<{}", ptrname_res));
    outputs::mainfn_append(         "   sta ZP_PTR_1");
    outputs::mainfn_append(&format!("   lda #>{}", ptrname_res));
    outputs::mainfn_append(         "   sta ZP_PTR_1+1");
    
    outputs::mainfn_append(&format!("   lda #<{}", string_res));
    outputs::mainfn_append(         "   sta ZP_PTR_2");
    outputs::mainfn_append(&format!("   lda #>{}", string_res));
    outputs::mainfn_append(         "   sta ZP_PTR_2+1");
    //
    if index_res.starts_with("#") {
        outputs::mainfn_append(&format!("   lda #<{}", &index_res[1..]));
        outputs::mainfn_append(         "   sta r0");
    } else {
        outputs::mainfn_append(&format!("   lda {index_res}"));
        outputs::mainfn_append(         "   sta r0");
    }
    //
    outputs::mainfn_append(         "   jsr _ref__arr8");
    outputs::mainfn_append("");

    return false;
}

fn as_type_str16(part: LinePart) -> bool {
    let ptrname      = part.get_next().next;
    let ptrname_part = part.get_next();
    let string       = ptrname_part.get_next().next;
    let string_part  = ptrname_part.get_next();
    let index        = string_part.get_next().next;
    let index_part   = string_part.get_next();
    let ptrname_res: String;
    let index_res:   String;
    let string_res:  String;

    builtins::mark_as_used("ref__arr16");

    //------------------------------------------------------------------------//
    // Check for input errors.                                                //
    //------------------------------------------------------------------------//
    if !ptrname_part.is_varname() {
        println!("ERROR: ln:{} Expected varname, got `{}`",
            part.ln_no, ptrname);
        return true;
    }

    if !string_part.is_varname() {
        println!("ERROR: ln:{} Invalid input. Expected str16 var; got `{}`",
            part.ln_no, string);
        return true;
    }

    //------------------------------------------------------------------------//
    // Extract the variable name                                              //
    //------------------------------------------------------------------------//
    ptrname_res = get::var_fullname(&ptrname);
    match outputs::get_vartype(&ptrname_res) {
        Some(vtype) => {
            if !(vtype == "ptr" || vtype.ends_with(":ptr")) {
                println!(
                    "ERROR: ln:{} Expected a ptr type; got `{}`, which is type `{}`",
                    part.ln_no, ptrname, vtype);
                return true;
            }
        },
        None => {},
    }

    //------------------------------------------------------------------------//
    // Extract the string name                                                //
    //------------------------------------------------------------------------//
    string_res = get::var_fullname(&string);

    //------------------------------------------------------------------------//
    // Extract the string index                                               //
    //------------------------------------------------------------------------//
    if index_part.is_varname() {
        index_res = get::var_fullname(&index);

        match outputs::get_vartype(&index_res) {
            Some(vtype) => {
                if vtype != "u16" {
                    println!(
                        "ERROR: ln:{} Expected a u16 type; got `{}`, which is type `{}`",
                        part.ln_no, index, vtype)
                }
            },
            None => {},
        }

    } else {
        index_res = format!("#{}", index);
    }


    outputs::mainfn_append(&format!("   ; ref__str16 {} {} {}",
        ptrname, string, index));
    //
    outputs::mainfn_append(&format!("   lda #<{}", ptrname_res));
    outputs::mainfn_append(         "   sta ZP_PTR_1");
    outputs::mainfn_append(&format!("   lda #>{}", ptrname_res));
    outputs::mainfn_append(         "   sta ZP_PTR_1+1");
    
    outputs::mainfn_append(&format!("   lda #<{}", string_res));
    outputs::mainfn_append(         "   sta ZP_PTR_2");
    outputs::mainfn_append(&format!("   lda #>{}", string_res));
    outputs::mainfn_append(         "   sta ZP_PTR_2+1");
    //
    if index_res.starts_with("#") {
        outputs::mainfn_append(&format!("   lda #<{}", &index_res[1..]));
        outputs::mainfn_append(         "   sta r0");
        outputs::mainfn_append(&format!("   lda #>{}", &index_res[1..]));
        outputs::mainfn_append(         "   sta r0+1");
    } else {
        outputs::mainfn_append(&format!("   lda {index_res}"));
        outputs::mainfn_append(         "   sta r0");
        outputs::mainfn_append(&format!("   lda {index_res}+1"));
        outputs::mainfn_append(         "   sta r0+1");
    }
    //
    outputs::mainfn_append(         "   jsr _ref__arr16");
    outputs::mainfn_append("");

    return false;
}

pub fn now(part: LinePart) -> bool {

    if part.next == "ref__arr8" {
        return as_type_arr8(part);

    } else if part.next == "ref__arr16" {
        return as_type_arr16(part);

    } else if part.next == "ref__str8" {
        return as_type_str8(part);

    } else if part.next == "ref__str16" {
        return as_type_str16(part);

    } else {
        println!(
            "ERROR: ln:{} Unhandled builtin function variant `{}`.",
            part.ln_no, part.next);
        return true;
    }
}
