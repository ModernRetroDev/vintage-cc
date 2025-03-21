use crate::get;
use crate::outputs;

use crate::line_part::LinePart;


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

	outputs::mainfn_append(&format!("   ; rshift__u8 {varname}"));
	outputs::mainfn_append(&format!("   lda {varname_res}"));
	outputs::mainfn_append(         "   asr");
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

	outputs::mainfn_append(&format!("   ; rshift__u16 {varname}"));
	outputs::mainfn_append(&format!("   lda {varname_res}+1"));
	outputs::mainfn_append(         "   lsr");
	outputs::mainfn_append(&format!("   sta {varname_res}+1"));
	outputs::mainfn_append(&format!("   lda {varname_res}"));
	outputs::mainfn_append(         "   ror");
	outputs::mainfn_append(&format!("   sta {varname_res}"));
	outputs::mainfn_append("");

	return false;
}

pub fn now(part: LinePart) -> bool {

	if part.next == "rshift__u8" {
		return as_type_u8(part);

	} else if part.next == "rshift__u16" {
		return as_type_u16(part);

	} else {
		println!(
			"ERROR: ln:{} Unhandled builtin function variant `{}`.",
			part.ln_no, part.next);
		return true;
	}
}
