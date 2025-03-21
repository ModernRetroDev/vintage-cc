use crate::outputs;

use crate::line_part::LinePart;


pub fn now(part: LinePart) -> bool {
	let ifblk_else: String;
	let ifblk_out:  String;

	match outputs::ifblocks_pop() {
		Some(ifblk_name) => {

			ifblk_else = format!("{}_else", &ifblk_name);
			ifblk_out  = format!("{}_out",  &ifblk_name);

			outputs::mainfn_append("   ; endif");
			if !outputs::ifblock_has_else(&ifblk_name) {
				outputs::mainfn_append(&format!("{}:", ifblk_else));
			}
			outputs::mainfn_append(&format!("{}:", ifblk_out));
			outputs::mainfn_append("");
		},
		None => {
			println!("ERROR: ln:{} `endif` found without corresponding `if`.",
				part.ln_no);
			return true;
		}
	}

	return false;
}
