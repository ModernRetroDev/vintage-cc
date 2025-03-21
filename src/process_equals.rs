use crate::get;
use crate::outputs;

use crate::line_part::LinePart;


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
	let vartype = outputs::get_vartype(&lhs_res).unwrap();
	if vartype != "u8" {
		println!(
			"WARNING: ln:{} Expected a u8 type; got `{}`, which is type `{}`",
			part.ln_no, lhs, vartype)
	}

	if rhs_part.is_varname() {
		rhs_res = get::var_fullname(&rhs);
	} else {
		rhs_res = format!("#{}", rhs);
	}

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
	let vartype = outputs::get_vartype(&lhs_res).unwrap();
	if vartype != "u16" {
		println!(
			"WARNING: ln:{} Expected a u16 type; got `{}`, which is type `{}`",
			part.ln_no, lhs, vartype)
	}

	outputs::mainfn_append(&format!("   ; equals__u16_u16 {} {}",
		lhs, rhs));

	if rhs_part.is_varname() {
		rhs_res = get::var_fullname(&rhs);

		outputs::mainfn_append(&format!("   lda {rhs_res}"));
		outputs::mainfn_append(&format!("   sta {lhs_res}"));
		outputs::mainfn_append(&format!("   lda {rhs_res}+1"));
		outputs::mainfn_append(&format!("   sta {lhs_res}+1"));

	} else {
		outputs::mainfn_append(&format!("   lda #<{rhs}"));
		outputs::mainfn_append(&format!("   sta {lhs_res}"));
		outputs::mainfn_append(&format!("   lda #>{rhs}"));
		outputs::mainfn_append(&format!("   sta {lhs_res}+1"));
	}

	outputs::mainfn_append("");

	return false;
}

pub fn now(part: LinePart) -> bool {

	if part.next == "equals__u8_u8" {
		return as_types_u8_u8(part);

	} else if part.next == "equals__u16_u16" {
		return as_types_u16_u16(part);

	} else {
		println!(
			"ERROR: ln:{} Unhandled builtin function variant `{}`.",
			part.ln_no, part.next);
		return true;
	}
}
