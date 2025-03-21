use crate::builtins;
use crate::get;
use crate::outputs;

use crate::line_part::LinePart;


fn as_types_u8_u8(part: LinePart) -> bool {
	let varname      = part.get_next().next;
	let varname_part = part.get_next();
	let adder        = varname_part.get_next().next;
	let adder_part   = varname_part.get_next();
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

	if adder_part.is_varname() {
		resolved = get::var_fullname(&adder);

		match outputs::get_vartype(&resolved) {
			Some(vtype) => {
				if vtype != "u8" {
					println!(
						"WARNING: ln:{} Expected a u8 type; got `{}`, which is type `{}`",
						part.ln_no, adder, vtype)
				}
			},
			None => {},
		}

	} else {
		resolved = format!("#{}", adder);
	}

	outputs::mainfn_append(&format!("   ; plus_equals__u8_u8 {} {}",
		varname, adder));
	outputs::mainfn_append(&format!("   lda {}", varname_full));
	outputs::mainfn_append(         "   clc ; clear carry");
	outputs::mainfn_append(&format!("   adc {}", resolved));
	outputs::mainfn_append(&format!("   sta {}", varname_full));
	outputs::mainfn_append("");

	return false;
}

fn as_types_u16_u8(part: LinePart) -> bool {
	let varname      = part.get_next().next;
	let varname_part = part.get_next();
	let varname_res: String;
	let adder        = varname_part.get_next().next;
	let adder_part   = varname_part.get_next();
	let adder_res: String;

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
		"   ; plus_equals__u16_u8 {varname} {adder}"));

	if adder_part.is_varname() {
		adder_res = get::var_fullname(&adder);

		match outputs::get_vartype(&adder_res) {
			Some(vtype) => {
				if vtype != "u8" {
					println!(
						"WARNING: ln:{} Expected a u8 type; got `{}`, which is type `{}`",
						part.ln_no, adder, vtype)
				}
			},
			None => {},
		}

		outputs::mainfn_append(&format!("   lda #<{varname_res}"));
		outputs::mainfn_append(         "   sta ZP_PTR_1");
		outputs::mainfn_append(&format!("   lda #>{varname_res}"));
		outputs::mainfn_append(         "   sta ZP_PTR_1+1");
		//
		outputs::mainfn_append(&format!("   lda #<{adder_res}"));
		outputs::mainfn_append(         "   sta ZP_PTR_2");
		outputs::mainfn_append(&format!("   lda #>{adder_res}"));
		outputs::mainfn_append(         "   sta ZP_PTR_2+1");
		//
		outputs::mainfn_append(         "   jsr _plus_equals__u16_u8");

	} else {
		let adder_val = adder.parse::<i64>().unwrap();
		if adder_val <= 0xFF {

			outputs::mainfn_append(&format!("   lda #<{varname_res}"));
			outputs::mainfn_append(         "   sta ZP_PTR_1");
			outputs::mainfn_append(&format!("   lda #>{varname_res}"));
			outputs::mainfn_append(         "   sta ZP_PTR_1+1");
			//
			outputs::mainfn_append(&format!("   lda #{adder}"));
			outputs::mainfn_append(         "   jsr _plus_equals__u16_u8d");

		} else {
			println!("ERROR: ln:{} Direct add of U8 value `{}` exceeds bounds.",
				part.ln_no, adder);
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
	let adder        = varname_part.get_next().next;
	let adder_part   = varname_part.get_next();
	let adder_res: String;

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
		"   ; plus_equals__u16_u16 {varname} {adder}"));

	if adder_part.is_varname() {
		adder_res = get::var_fullname(&adder);

		match outputs::get_vartype(&adder_res) {
			Some(vtype) => {
				if vtype != "u16" {
					println!(
						"WARNING: ln:{} Expected a u16 type; got `{}`, which is type `{}`",
						part.ln_no, adder, vtype)
				}
			},
			None => {},
		}

		outputs::mainfn_append(&format!("   lda #<{varname_res}"));
		outputs::mainfn_append(         "   sta ZP_PTR_1");
		outputs::mainfn_append(&format!("   lda #>{varname_res}"));
		outputs::mainfn_append(         "   sta ZP_PTR_1+1");
		//
		outputs::mainfn_append(&format!("   lda #<{adder_res}"));
		outputs::mainfn_append(         "   sta ZP_PTR_2");
		outputs::mainfn_append(&format!("   lda #>{adder_res}"));
		outputs::mainfn_append(         "   sta ZP_PTR_2+1");
		//
		outputs::mainfn_append(         "   jsr _plus_equals__u16_u16");

	} else {
		let adder_val = adder.parse::<i64>().unwrap();
		if adder_val <= 0xFF {

			outputs::mainfn_append(&format!("   lda #<{varname_res}"));
			outputs::mainfn_append(         "   sta ZP_PTR_1");
			outputs::mainfn_append(&format!("   lda #>{varname_res}"));
			outputs::mainfn_append(         "   sta ZP_PTR_1+1");
			//
			outputs::mainfn_append(&format!("   lda #{adder}"));
			outputs::mainfn_append(         "   jsr _plus_equals__u16_u8d");

		} else if adder_val <= 0xFFFF {

			outputs::mainfn_append(&format!("   lda #<{varname_res}"));
			outputs::mainfn_append(         "   sta ZP_PTR_1");
			outputs::mainfn_append(&format!("   lda #>{varname_res}"));
			outputs::mainfn_append(         "   sta ZP_PTR_1+1");
			//
			outputs::mainfn_append(&format!("   lda #<{adder}"));
			outputs::mainfn_append(&format!("   ldx #>{adder}"));
			outputs::mainfn_append(         "   jsr _plus_equals__u16_u16d");

		} else {
			println!("ERROR: ln:{} Direct add of U8 value `{}` exceeds bounds.",
				part.ln_no, adder);
			return true;
		}
	}
	outputs::mainfn_append("");

	return false;
}

pub fn now(part: LinePart) -> bool {

	if part.next == "plus_equals__u8_u8" {
		return as_types_u8_u8(part);

	} else if part.next == "plus_equals__u16_u8" {
		return as_types_u16_u8(part);

	} else if part.next == "plus_equals__u16_u16" {
		return as_types_u16_u16(part);

	} else {
		println!(
			"ERROR: ln:{} Unhandled builtin function variant `{}`.",
			part.ln_no, part.next);
		return true;
	}
}
