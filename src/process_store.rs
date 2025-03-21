use crate::get;
use crate::outputs;

use crate::line_part::LinePart;


fn as_type_u8(part: LinePart) -> bool {
	let ptrname      = part.get_next().next;
	let ptrname_part = part.get_next();
	let value        = ptrname_part.get_next().next;
	let value_part   = ptrname_part.get_next();
	let ptrname_res: String;
	let value_res:   String;

	//------------------------------------------------------------------------//
	// Check for input errors.                                                //
	//------------------------------------------------------------------------//
	if !ptrname_part.is_varname() {
		println!("ERROR: ln:{} Expected varname, got `{}`",
			part.ln_no, ptrname);
		return true;
	}

	//------------------------------------------------------------------------//
	// Extract the pointer variable name                                      //
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
	// Extract the value                                                      //
	//------------------------------------------------------------------------//
	if value_part.is_varname() {
		value_res = get::var_fullname(&value);

		match outputs::get_vartype(&value_res) {
			Some(vtype) => {
				if vtype != "u8" {
					println!(
						"WARNING: ln:{} Expected a u8 type; got `{}`, which is type `{}`",
						part.ln_no, value, vtype)
				}
			},
			None => {},
		}

	} else {
		value_res = format!("#{}", value);
	}


	outputs::mainfn_append(&format!("   ; store__u8 {} {}",
		ptrname, value, ));

	outputs::mainfn_append(&format!("   lda #<{ptrname_res}"));
	outputs::mainfn_append(         "   sta ZP_PTR_1");
	outputs::mainfn_append(&format!("   lda #>{ptrname_res}"));
	outputs::mainfn_append(         "   sta ZP_PTR_1+1");
	//
	outputs::mainfn_append(         "   ldy #0");
	outputs::mainfn_append(         "   lda (ZP_PTR_1),y");
	outputs::mainfn_append(         "   sta ZP_PTR_2");
	outputs::mainfn_append(         "   ldy #1");
	outputs::mainfn_append(         "   lda (ZP_PTR_1),y");
	outputs::mainfn_append(         "   sta ZP_PTR_2+1");
	outputs::mainfn_append(         "   ldy #0");
	//
	outputs::mainfn_append(&format!("   lda {value_res}"));
	outputs::mainfn_append(         "   sta (ZP_PTR_2),y");
	outputs::mainfn_append("");

	return false;
}

pub fn now(part: LinePart) -> bool {

	if part.next == "store__u8" {
		return as_type_u8(part);

	} else {
		println!(
			"ERROR: ln:{} Unhandled builtin function variant `{}`.",
			part.ln_no, part.next);
		return true;
	}
}
