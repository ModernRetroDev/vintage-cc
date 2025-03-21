use crate::builtins;
use crate::get;
use crate::outputs;

use crate::line_part::LinePart;


fn as_type_arr8(part: LinePart) -> bool {
	let ptrname      = part.get_next().next;
	let ptrname_part = part.get_next();
	let array        = ptrname_part.get_next().next;
	let array_part   = ptrname_part.get_next();
	let index        = array_part.get_next().next;
	let index_part   = array_part.get_next();
	let array_res:   String;
	let index_res:   String;
	let ptrname_res: String;

	builtins::mark_as_used("plus_equals__u16_u8");

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
	array_res = get::arr8_fullname(&array);
	if outputs::get_arr8type(&array_res).is_none() {
		println!("ERROR: ln:{} Expected an arr8 type; got `{}` instead",
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



	outputs::mainfn_append(         "   ; hop over 3 bytes to point at data");
	outputs::mainfn_append(         "   clc");
	outputs::mainfn_append(&format!("   lda #<{array_res}"));
	outputs::mainfn_append(         "   adc #3");
	outputs::mainfn_append(&format!("   sta {ptrname_res}"));
	outputs::mainfn_append(&format!("   lda #>{array_res}"));
	outputs::mainfn_append(         "   adc #0");
	outputs::mainfn_append(&format!("   sta {ptrname_res}+1"));
	//
	outputs::mainfn_append(&format!("   lda #<{ptrname_res}"));
	outputs::mainfn_append(         "   sta ZP_PTR_1");
	outputs::mainfn_append(&format!("   lda #>{ptrname_res}"));
	outputs::mainfn_append(         "   sta ZP_PTR_1+1");
	//
	outputs::mainfn_append(&format!("   lda #<{index_res}"));
	outputs::mainfn_append(         "   sta ZP_PTR_2");
	outputs::mainfn_append(&format!("   lda #>{index_res}"));
	outputs::mainfn_append(         "   sta ZP_PTR_2+1");
	//
	outputs::mainfn_append(         "   jsr _plus_equals__u16_u8");
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
	let index_res:   String;
	let ptrname_res: String;

	builtins::mark_as_used("plus_equals__u16_u16");

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



	outputs::mainfn_append(         "   ; hop over 5 bytes to point at data");
	outputs::mainfn_append(         "   clc");
	outputs::mainfn_append(&format!("   lda #<{array_res}"));
	outputs::mainfn_append(         "   adc #5");
	outputs::mainfn_append(&format!("   sta {ptrname_res}"));
	outputs::mainfn_append(&format!("   lda #>{array_res}"));
	outputs::mainfn_append(         "   adc #0");
	outputs::mainfn_append(&format!("   sta {ptrname_res}+1"));
	//
	outputs::mainfn_append(&format!("   lda #<{ptrname_res}"));
	outputs::mainfn_append(         "   sta ZP_PTR_1");
	outputs::mainfn_append(&format!("   lda #>{ptrname_res}"));
	outputs::mainfn_append(         "   sta ZP_PTR_1+1");
	//
	outputs::mainfn_append(&format!("   lda #<{index_res}"));
	outputs::mainfn_append(         "   sta ZP_PTR_2");
	outputs::mainfn_append(&format!("   lda #>{index_res}"));
	outputs::mainfn_append(         "   sta ZP_PTR_2+1");
	//
	outputs::mainfn_append(         "   jsr _plus_equals__u16_u16");
	outputs::mainfn_append("");

	return false;
}

pub fn now(part: LinePart) -> bool {

	if part.next == "ref__arr8" {
		return as_type_arr8(part);

	} else if part.next == "ref__arr16" {
		return as_type_arr16(part);

	} else {
		println!(
			"ERROR: ln:{} Unhandled builtin function variant `{}`.",
			part.ln_no, part.next);
		return true;
	}
}
