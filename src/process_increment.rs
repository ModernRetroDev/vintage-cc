use crate::get;
use crate::outputs;

use crate::line_part::LinePart;


fn as_type_u8(part: LinePart) -> bool {
	let thisvar      = part.get_next().next;
	let thisvar_part = part.get_next();
	let thisvar_res: String;

	// read in the variable name
	if !thisvar_part.is_varname() {
		println!("ERROR: ln:{} Expected varname, got `{}`",
			part.ln_no, thisvar);
		return true;
	}
	thisvar_res = get::var_fullname(&thisvar);

	let vtype = outputs::get_vartype(&thisvar_res).unwrap();
	if vtype != "u8" {
		println!(
			"WARNING: ln:{} Expected a u8 type; got `{}`, which is type `{}`",
			part.ln_no, thisvar, vtype)
	}

	outputs::mainfn_append(&format!("   ; increment__u8 {thisvar}"));
	outputs::mainfn_append(&format!("   lda {thisvar_res}"));
	outputs::mainfn_append(         "   clc ; clear carry");
	outputs::mainfn_append(         "   adc #1");
	outputs::mainfn_append(&format!("   sta {thisvar_res}"));
	outputs::mainfn_append("");

	return false
}

fn as_type_u16(part: LinePart) -> bool {
	let thisvar      = part.get_next().next;
	let thisvar_part = part.get_next();
	let thisvar_res: String;

	// read in the variable name
	if !thisvar_part.is_varname() {
		println!("ERROR: ln:{} Expected varname, got `{}`",
			part.ln_no, thisvar);
		return true;
	}
	thisvar_res = get::var_fullname(&thisvar);

	let vtype = outputs::get_vartype(&thisvar_res).unwrap();
	if vtype != "u16" {
		println!(
			"WARNING: ln:{} Expected a u16 type; got `{}`, which is type `{}`",
			part.ln_no, thisvar, vtype)
	}

	outputs::mainfn_append(&format!("   ; increment__u16 {thisvar}"));
	outputs::mainfn_append(&format!("   lda {thisvar_res}"));
	outputs::mainfn_append(         "   clc ; clear carry");
	outputs::mainfn_append(         "   adc #1");
	outputs::mainfn_append(&format!("   sta {thisvar_res}"));
	//
	outputs::mainfn_append(&format!("   lda {thisvar_res}+1"));
	outputs::mainfn_append(         "   adc #0");
	outputs::mainfn_append(&format!("   sta {thisvar_res}+1"));
	outputs::mainfn_append("");

	return false
}


pub fn now(part: LinePart) -> bool {

	if part.next == "increment__u8" {
		return as_type_u8(part);

	} else if part.next == "increment__u16" {
		return as_type_u16(part);

	} else {
		println!(
			"ERROR: ln:{} Unhandled builtin function variant `{}`.",
			part.ln_no, part.next);
		return true;
	}
}
