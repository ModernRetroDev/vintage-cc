use crate::builtins;
use crate::get;
use crate::outputs;

use crate::line_part::LinePart;


fn as_type_bool(part: LinePart) -> bool {
	let value      = part.get_next().next;
	let value_part = part.get_next();
	let resolved: String;

	builtins::mark_as_used(&part.next);

	if value_part.is_varname() {
		resolved = get::var_fullname(&value);
	} else {
		resolved = format!("#{}", value);
	}

	outputs::mainfn_append(&format!("   ; print__bool {}", value));
	outputs::mainfn_append(&format!("   lda {}", resolved));
	outputs::mainfn_append(         "   jsr _print__bool");
	outputs::mainfn_append("");

	return false;
}

fn as_type_char(part: LinePart) -> bool {
	let value      = part.get_next().next;
	let value_part = part.get_next();
	let resolved: String;

	builtins::mark_as_used(&part.next);

	if value_part.is_varname() {
		resolved = get::var_fullname(&value);
	} else {
		let achar = part.get_next_char();
		match achar {
			Some(achar) => {
				resolved = format!("#${:02X}", achar);
			},
			None => {
				println!("ERROR: malformed char on LN {}", part.ln_no);
				return true;
			}
		}
	}

	outputs::mainfn_append(&format!("   ; print__char {}", value));
	outputs::mainfn_append(&format!("   lda {}", resolved));
	outputs::mainfn_append(         "   jsr _print__char");
	outputs::mainfn_append("");

	return false;
}

fn as_type_endl(part: LinePart) -> bool {

	builtins::mark_as_used(&part.next);

	outputs::mainfn_append("   ; print__endl");
	outputs::mainfn_append("   jsr _print__endl");
	outputs::mainfn_append("");

	return false
}

fn as_type_str8(part: LinePart) -> bool {
	let     value      = part.get_next().next;
	let     value_part = part.get_next();
	let     value_str: String;
	let     resolved:  String;
	let mut str_bytes: Vec<u8> = Vec::new();

	builtins::mark_as_used(&part.next);

	if value_part.is_varname() {
		// we are referencing a variable... resolve name
		value_str = part.get_next().next;
		resolved = get::var_fullname(&value);
	} else {
		// else; we need to make and store this str8 data
		match part.get_next_str() {
			Some(next_part) => {
				value_str = next_part.next;
			},
			None => {
				println!("ERROR: malformed string on LN {}", part.ln_no);
				return true;
			}
		}
		resolved  = get::unique_str8_varname();

		outputs::set_var_index(&resolved);
		outputs::varnames_append(&resolved);
		outputs::vartypes_append("str8");

		let stop = value_str.len() - 1;
		let str_data = &value_str[1..stop];
		for byte in str_data.bytes() {
			str_bytes.push(byte);
		}

		outputs::varvalues_append(str_bytes);
	}

	outputs::mainfn_append(&format!("   ; print__str8 {}", value_str));
	outputs::mainfn_append(&format!("   lda #<{}", resolved));
	outputs::mainfn_append(         "   sta ZP_PTR_1");
	outputs::mainfn_append(&format!("   lda #>{}", resolved));
	outputs::mainfn_append(         "   sta ZP_PTR_1+1");
	outputs::mainfn_append(         "   jsr _print__str8");
	outputs::mainfn_append("");

	return false;
}

fn as_type_u8(part: LinePart) -> bool {
	let value      = part.get_next().next;
	let value_part = part.get_next();
	let resolved: String;

	builtins::mark_as_used(&part.next);

	if value_part.is_varname() {
		resolved = get::var_fullname(&value);
	} else {
		resolved = format!("#{}", value);
	}

	outputs::mainfn_append(&format!("   ; print__u8 {}", value));
	outputs::mainfn_append(&format!("   lda {}", resolved));
	outputs::mainfn_append(         "   jsr _print__u8");
	outputs::mainfn_append("");

	return false;
}

fn as_type_u8_x(part: LinePart) -> bool {
	let value      = part.get_next().next;
	let value_part = part.get_next();
	let resolved: String;

	builtins::mark_as_used(&part.next);

	if value_part.is_varname() {
		resolved = get::var_fullname(&value);
	} else {
		resolved = format!("#{}", value);
	}

	outputs::mainfn_append(&format!("   ; print__u8_x {}", value));
	outputs::mainfn_append(&format!("   lda {}", resolved));
	outputs::mainfn_append(         "   jsr _print__u8_x");
	outputs::mainfn_append("");

	return false;
}

fn as_type_u8_xx(part: LinePart) -> bool {
	let value      = part.get_next().next;
	let value_part = part.get_next();
	let resolved: String;

	builtins::mark_as_used(&part.next);

	if value_part.is_varname() {
		resolved = get::var_fullname(&value);
	} else {
		resolved = format!("#{}", value);
	}

	outputs::mainfn_append(&format!("   ; print__u8_X {}", value));
	outputs::mainfn_append(&format!("   lda {}", resolved));
	outputs::mainfn_append(         "   jsr _print__u8_xx");
	outputs::mainfn_append("");

	return false;
}

fn as_type_u16_x(part: LinePart) -> bool {
	let value      = part.get_next().next;
	let value_part = part.get_next();
	let resolved: String;

	builtins::mark_as_used(&part.next);

	if value_part.is_varname() {
		resolved = get::var_fullname(&value);
	} else {
		println!("ERROR/TODO: Non variable U16 print on LN {}", part.ln_no);
		return true;
	}

	outputs::mainfn_append(&format!("   ; print__u16_x {}", value));
	outputs::mainfn_append(&format!("   ldx {resolved}"));
	outputs::mainfn_append(&format!("   ldy {resolved}+1"));
	outputs::mainfn_append(         "   jsr _print__u16_x");
	outputs::mainfn_append("");

	return false;
}

pub fn now(part: LinePart) -> bool {

	if part.next == "print__bool" {
		return as_type_bool(part);

	} else if part.next == "print__char" {
		return as_type_char(part);

	} else if part.next == "print__endl" {
		return as_type_endl(part);

	} else if part.next == "print__str8" {
		return as_type_str8(part);

	} else if part.next == "print__u8" {
		return as_type_u8(part);

	} else if part.next == "print__u8_x" {
		return as_type_u8_x(part);

	} else if part.next == "print__u8_xx" {
		return as_type_u8_xx(part);

	} else if part.next == "print__u16_x" {
		return as_type_u16_x(part);

	} else {
		println!(
			"ERROR: ln:{} Unhandled builtin function variant `{}`.",
			part.ln_no, part.next);
		return true;
	}
}
