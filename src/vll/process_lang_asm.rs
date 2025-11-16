use crate::vll::outputs;

use crate::vll::line_part::LinePart;


fn as_simple(part: &LinePart) -> bool {
	let value_str: String;	

	value_str = part.get_next_str().unwrap().next;

	let stop = value_str.len() - 1;
	let str_data = &value_str[1..stop];

	outputs::mainfn_append(str_data);

	return false;
}

fn is_simple_line(part: &LinePart) -> bool {
	let value_str: String;	

	match part.get_next_str() {
		Some(next_part) => {
			value_str = next_part.next;
		},
		None => { return false; }
	}

    match value_str.find("{}") {
        Some(_) => { return false; },
        None => { return true; }
    }
}

pub fn now(part: LinePart) -> bool {

	if is_simple_line(&part) {
		return as_simple(&part);
	} else {
		println!(
			"ERROR: ln:{} LANG_ASM: Unhandled function variant.",
			part.ln_no);
		return true;
	}
}
