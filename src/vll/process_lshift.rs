use crate::vll::builtins;
use crate::vll::get;
use crate::vll::fn_args;
use crate::vll::outputs;

use crate::vll::line_part::LinePart;


fn as_type_u8(part: LinePart) -> bool {
	let varname      = part.get_next().next;
	let varname_part = part.get_next();

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

	outputs::mainfn_append(&format!("   ; lshift__u8 {varname}"));
	outputs::mainfn_append(&format!("   lda {varname_res}"));
	outputs::mainfn_append(         "   asl");
	outputs::mainfn_append(&format!("   sta {varname_res}"));
	outputs::mainfn_append("");

	return false;
}

fn as_type_u8_n(part: LinePart) -> bool {
	let varname      = part.get_next().next;
	let varname_part = part.get_next();
    let shift        = varname_part.get_next().next;
    let shift_part   = varname_part.get_next();
    let resolved: String;

    builtins::mark_as_used(&part.next);

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

    if !fn_args::is_type_u8(&shift_part) {
        return true;
    }
    match fn_args::get_u8_value_str(&shift_part) {
        Some(val_str) => { resolved = val_str; },
        None => { return true; },
    };

	outputs::mainfn_append(&format!("   ; lshift__u8_n {varname}"));
	outputs::mainfn_append(&format!("   lda {varname_res}"));
	outputs::mainfn_append(&format!("   ldx {resolved}"));
	outputs::mainfn_append(&format!("   jsr _lshift__u8_n"));
	outputs::mainfn_append(&format!("   sta {varname_res}"));
	outputs::mainfn_append("");

	return false;
}

fn as_type_u16(part: LinePart) -> bool {
	let varname      = part.get_next().next;
	let varname_part = part.get_next();
	let varname_res: String;

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

	outputs::mainfn_append(&format!("   ; lshift__u16 {varname}"));
	outputs::mainfn_append(&format!("   lda {varname_res}"));
	outputs::mainfn_append(         "   asl");
	outputs::mainfn_append(&format!("   sta {varname_res}"));
	outputs::mainfn_append(&format!("   lda {varname_res}+1"));
	outputs::mainfn_append(         "   rol");
	outputs::mainfn_append(&format!("   sta {varname_res}+1"));
	outputs::mainfn_append("");

	return false;
}

fn as_type_u16_n(part: LinePart) -> bool {
    let varname      = part.get_next().next;
    let varname_part = part.get_next();
    let varname_res: String;
    let shift        = varname_part.get_next().next;
    let shift_part   = varname_part.get_next();
    let shift_res: String;

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
        "   ; lshift__u16_n {varname} {shift}"));

    if shift_part.is_varname() {
        shift_res = get::var_fullname(&shift);
        // we will only ever take the low byte from whatever variable

        outputs::mainfn_append(&format!("   lda #<{varname_res}"));
        outputs::mainfn_append(         "   sta ZP_PTR_1");
        outputs::mainfn_append(&format!("   lda #>{varname_res}"));
        outputs::mainfn_append(         "   sta ZP_PTR_1+1");
        //
        outputs::mainfn_append(&format!("   lda #<{shift_res}"));
        outputs::mainfn_append(         "   sta ZP_PTR_2");
        outputs::mainfn_append(&format!("   lda #>{shift_res}"));
        outputs::mainfn_append(         "   sta ZP_PTR_2+1");
        //
        outputs::mainfn_append(&format!("   ldy #0"));
        outputs::mainfn_append(&format!("   lda (ZP_PTR_2),y"));
        outputs::mainfn_append(&format!("   tax"));
        //
        outputs::mainfn_append(         "   jsr _lshift__u16_n");

    } else {
        let shift_val = shift.parse::<i64>().unwrap();
        if shift_val <= 0xFF {

            outputs::mainfn_append(&format!("   lda #<{varname_res}"));
            outputs::mainfn_append(         "   sta ZP_PTR_1");
            outputs::mainfn_append(&format!("   lda #>{varname_res}"));
            outputs::mainfn_append(         "   sta ZP_PTR_1+1");
            //
            outputs::mainfn_append(&format!("   ldx #{shift}"));
            outputs::mainfn_append(         "   jsr _lshift__u16_n");

        } else {
            println!("ERROR: ln:{} Direct shift of U8 value `{}` exceeds bounds.",
                part.ln_no, shift);
            return true;
        }
    }
    outputs::mainfn_append("");

    return false;
}

pub fn now(part: LinePart) -> bool {

	if part.next == "lshift__u8" {
		return as_type_u8(part);

	} else if part.next == "lshift__u8_n" {
		return as_type_u8_n(part);

	} else if part.next == "lshift__u16" {
		return as_type_u16(part);

	} else if part.next == "lshift__u16_n" {
		return as_type_u16_n(part);

	} else {
		println!(
			"ERROR: ln:{} Unhandled builtin function variant `{}`.",
			part.ln_no, part.next);
		return true;
	}
}
