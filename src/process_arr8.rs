use crate::outputs;

use crate::line_part::LinePart;


fn as_type_u8(part: LinePart) -> bool {
	let     globname: String;
	let     len_sz: usize;
	let     arr8_decl  = part.next.clone();
	let     varname    = part.get_next().next;
	let     subsequent = part.get_next().get_next();
	let mut u8_bytes: Vec<u8> = Vec::new();

	globname = format!("arr8__{}__{}", 
		outputs::get_active_fn(), 
		varname);

	// `arr8__u8,` <- clip off first 9 chars
	let len_str = &arr8_decl[9..];
	match len_str.parse::<usize>() {
		Ok(sz) => {
			len_sz = sz; 
		},
		Err(_) => {
			println!("ERROR: ln:{} arr8__u8 provided invalid length `{}`.",
				part.ln_no, len_str);
			return true;
		},
	}
	if len_sz > 0xFF {
		println!("ERROR: ln:{} arr8__u8 with excessive length (i.e., > 0xFF); got `{}`.",
			part.ln_no, len_str);
		return true;
	}

	if subsequent.next != "=" {
		for _ in 0..len_sz {
			u8_bytes.push(0);
		}
	} else {
		let values = subsequent.get_next().next;
		let values_split = values.split(',');
		for value_str in values_split {
			match value_str.parse::<u8>() {
				Ok(value) => {
					u8_bytes.push(value);
				},
				Err(_) => {
					println!("ERROR: ln:{} arr8__u8 invalid value provided `{}`.",
						part.ln_no, value_str);
					return true;
				},
			}
		}
		if u8_bytes.len() != len_sz {
			println!(
				"ERROR/TODO: ln:{} arr8__u8 value length mismatch; expected `{}` values, got `{}`.",
				part.ln_no, len_sz, u8_bytes.len());
			return true;
		}
	}

	outputs::set_arr8_index(&globname);
	outputs::arr8names_append(&globname);
	outputs::arr8types_append("u8");
	outputs::arr8values_append(u8_bytes);

	return false;
}

pub fn now(part: LinePart) -> bool {
	let active_fn: String;

	active_fn = outputs::get_active_fn();
	if active_fn.len() == 0 {
		println!("ERROR: ln:{} arr8 set outside of function.", part.ln_no);
		return true;
	}

	if part.next.starts_with("arr8__u8,") {
		return as_type_u8(part);

	} else {
		println!(
			"ERROR: ln:{} Unhandled builtin function variant `{}`.",
			part.ln_no, part.next);
		return true;
	}
}
