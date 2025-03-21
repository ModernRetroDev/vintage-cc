use crate::outputs;

use crate::line_part::LinePart;


fn as_type_bool(part: LinePart) -> bool {
	let     globname: String;
	let     varname = part.get_next().next;
	let mut bool_byte: Vec<u8> = Vec::new();

	globname = format!("var__{}__{}", 
		outputs::get_active_fn(), 
		varname);

	bool_byte.push(0);

	outputs::set_var_index(&globname);
	outputs::varnames_append(&globname);
	outputs::vartypes_append("bool");
	outputs::varvalues_append(bool_byte);

	return false;
}

fn as_type_file(part: LinePart) -> bool {
	let     globname: String;
	let     varname = part.get_next().next;
	let mut file_bytes: Vec<u8> = Vec::new();

	globname = format!("var__{}__{}", 
		outputs::get_active_fn(), 
		varname);

	file_bytes.push(0); // .mode
	file_bytes.push(0); // .device
	file_bytes.push(0); // .channel
	file_bytes.push(0); // .status
	//
	file_bytes.push(0); // .fname[0]
	file_bytes.push(0); // .fname[1]

	outputs::set_var_index(&globname);
	outputs::varnames_append(&globname);
	outputs::vartypes_append("file");
	outputs::varvalues_append(file_bytes);

	return false;
}

fn as_type_ptr(part: LinePart) -> bool {
	let     globname: String;
	let     varname = part.get_next().next;
	let mut u16_bytes: Vec<u8> = Vec::new();

	globname = format!("var__{}__{}", 
		outputs::get_active_fn(), 
		varname);

	u16_bytes.push(0);
	u16_bytes.push(0);

	outputs::set_var_index(&globname);
	outputs::varnames_append(&globname);
	outputs::vartypes_append("ptr");
	outputs::varvalues_append(u16_bytes);

	return false;
}

fn as_type_u8(part: LinePart) -> bool {
	let     globname: String;
	let     varname = part.get_next().next;
	let mut u8_byte: Vec<u8> = Vec::new();

	globname = format!("var__{}__{}", 
		outputs::get_active_fn(), 
		varname);

	u8_byte.push(0);

	outputs::set_var_index(&globname);
	outputs::varnames_append(&globname);
	outputs::vartypes_append("u8");
	outputs::varvalues_append(u8_byte);

	return false;
}

fn as_type_u16(part: LinePart) -> bool {
	let     globname: String;
	let     varname = part.get_next().next;
	let mut u16_bytes: Vec<u8> = Vec::new();

	globname = format!("var__{}__{}", 
		outputs::get_active_fn(), 
		varname);

	u16_bytes.push(0);
	u16_bytes.push(0);

	outputs::set_var_index(&globname);
	outputs::varnames_append(&globname);
	outputs::vartypes_append("u16");
	outputs::varvalues_append(u16_bytes);

	return false;
}

fn as_type_str8(part: LinePart) -> bool {
	let     globname:    String;
	let     strval_part: Option<LinePart>;
	let     varname = part.get_next().next;
	let     subsequent = part.get_next().get_next();
	let mut str_bytes: Vec<u8> = Vec::new();

	globname = format!("var__{}__{}", 
		outputs::get_active_fn(), 
		varname);

	if subsequent.next != "=" {
		println!("ERROR: ln:{} var__str8 must be initialized with a value.",
			part.ln_no );
		return true;
	}

	strval_part = subsequent.get_next_str();
	match strval_part {
		Some(strval_part) => {

			let stop = strval_part.next.len() - 1;
			let str_data = &strval_part.next[1..stop];
			for byte in str_data.bytes() {
				str_bytes.push(byte);
			}

			outputs::set_var_index(&globname);
			outputs::varnames_append(&globname);
			outputs::vartypes_append("str8");
			outputs::varvalues_append(str_bytes);
		},
		None => {
			println!("ERROR: ln:{} Invalid initial string value supplied.",
				part.ln_no );
			return true;
		}
	}

	return false;
}


pub fn now(part: LinePart) -> bool {
	let active_fn: String;

	active_fn = outputs::get_active_fn();
	if active_fn.len() == 0 {
		println!("ERROR: ln:{} var set outside of function.", 
			part.ln_no);
		return true;
	}

	if part.next == "var__bool" {
		return as_type_bool(part);

	} else if part.next == "var__ptr" {
		return as_type_ptr(part);

	} else if part.next == "var__u8" {
		return as_type_u8(part);

	} else if part.next == "var__u16" {
		return as_type_u16(part);

	} else if part.next == "var__str8" {
		return as_type_str8(part);

	} else if part.next == "var__file" {
		return as_type_file(part);

	} else {
		println!(
			"ERROR: ln:{} Unhandled builtin function variant `{}`.",
			part.ln_no, part.next);
		return true;
	}
}
