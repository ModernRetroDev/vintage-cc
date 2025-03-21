use crate::outputs;

use crate::line_part::LinePart;


pub fn now(part: LinePart) -> bool {
	let ifblk_else: String;
	let ifblk_out:  String;

	match outputs::ifblocks_peek() {
		Some(ifblk_name) => {
			if outputs::ifblock_has_else(&ifblk_name) {
				println!("ERROR: ln:{} second `else` found within an `if` block.",
					part.ln_no);
				return true;
			}

			outputs::ifblock_set_else(&ifblk_name);
			ifblk_else = format!("{}_else", &ifblk_name);
			ifblk_out  = format!("{}_out",  &ifblk_name);

			outputs::mainfn_append(         "   ; endif (skip to out)");
			outputs::mainfn_append(&format!("   jmp {}", ifblk_out));
			outputs::mainfn_append("");
			outputs::mainfn_append(&format!("{}:", ifblk_else));
		},
		None => {
			println!("ERROR: ln:{} `else` found outside of an `if` block.",
				part.ln_no);
			return true;
		}
	}

	return false;
}
