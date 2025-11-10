use crate::vll::outputs;

use crate::vll::line_part::LinePart;


fn as_type_bool(part: LinePart) -> bool {
	let     globname: String;
	let     varname = part.get_next().next;
	let mut u16_bytes: Vec<u8> = Vec::new();

	globname = format!("ptr__{}__{}", 
		outputs::get_active_fn(), 
		varname);

	u16_bytes.push(0);
	u16_bytes.push(0);

	outputs::set_var_index(&globname);
	outputs::varnames_append(&globname);
	outputs::vartypes_append("u8:bool");
	outputs::varvalues_append(u16_bytes);

	return false;
}

fn as_type_u8(part: LinePart) -> bool {
	let     globname: String;
	let     varname = part.get_next().next;
	let mut u16_bytes: Vec<u8> = Vec::new();

	globname = format!("ptr__{}__{}", 
		outputs::get_active_fn(), 
		varname);

	u16_bytes.push(0);
	u16_bytes.push(0);

	outputs::set_var_index(&globname);
	outputs::varnames_append(&globname);
	outputs::vartypes_append("u8:ptr");
	outputs::varvalues_append(u16_bytes);

	return false;
}

fn as_type_u16(part: LinePart) -> bool {
	let     globname: String;
	let     varname = part.get_next().next;
	let mut u16_bytes: Vec<u8> = Vec::new();

	globname = format!("ptr__{}__{}", 
		outputs::get_active_fn(), 
		varname);

	u16_bytes.push(0);
	u16_bytes.push(0);

	outputs::set_var_index(&globname);
	outputs::varnames_append(&globname);
	outputs::vartypes_append("u16:ptr");
	outputs::varvalues_append(u16_bytes);

	return false;
}

fn as_type_u24(part: LinePart) -> bool {
	let     globname: String;
	let     varname = part.get_next().next;
	let mut u24_bytes: Vec<u8> = Vec::new();

	globname = format!("ptr__{}__{}", 
		outputs::get_active_fn(), 
		varname);

	u24_bytes.push(0);
	u24_bytes.push(0);

	outputs::set_var_index(&globname);
	outputs::varnames_append(&globname);
	outputs::vartypes_append("u24:ptr");
	outputs::varvalues_append(u24_bytes);

	return false;
}

fn as_type_file(part: LinePart) -> bool {
	let     globname: String;
	let     varname = part.get_next().next;
	let mut u16_bytes: Vec<u8> = Vec::new();

	globname = format!("ptr__{}__{}", 
		outputs::get_active_fn(), 
		varname);

	u16_bytes.push(0);
	u16_bytes.push(0);

	outputs::set_var_index(&globname);
	outputs::varnames_append(&globname);
	outputs::vartypes_append("file:ptr");
	outputs::varvalues_append(u16_bytes);

	return false;
}

fn as_type_str8(part: LinePart) -> bool {
	let     globname: String;
	let     varname = part.get_next().next;
	let mut u16_bytes: Vec<u8> = Vec::new();

	globname = format!("ptr__{}__{}", 
		outputs::get_active_fn(), 
		varname);

	u16_bytes.push(0);
	u16_bytes.push(0);

	outputs::set_var_index(&globname);
	outputs::varnames_append(&globname);
	outputs::vartypes_append("str8:ptr");
	outputs::varvalues_append(u16_bytes);

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

	if part.next == "ptr__bool" {
		return as_type_bool(part);
	} else if part.next == "ptr__u8" {
		return as_type_u8(part);
	} else if part.next == "ptr__u16" {
		return as_type_u16(part);
	} else if part.next == "ptr__u24" {
		return as_type_u24(part);
	} else if part.next == "ptr__str8" {
		return as_type_str8(part);
	} else if part.next == "ptr__file" {
		return as_type_file(part);

	} else {
		println!(
			"ERROR: ln:{} Unhandled builtin function variant `{}`.",
			part.ln_no, part.next);
		return true;
	}
}
