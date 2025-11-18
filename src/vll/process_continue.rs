use crate::vll::outputs;

use crate::vll::line_part::LinePart;


pub fn now(part: LinePart) -> bool {
	let loopblk_lbl:  String;

	match outputs::loopblocks_peek() {
		Some(loopblk_name) => {
			loopblk_lbl  = loopblk_name.to_string();

			outputs::mainfn_append(         "   ; continue");
			outputs::mainfn_append(&format!("   jmp {}", loopblk_lbl));
		},
		None => {
			println!("ERROR: ln:{} `continue` found outside of a `loop` block.",
				part.ln_no);
			return true;
		}
	}

	return false;
}
