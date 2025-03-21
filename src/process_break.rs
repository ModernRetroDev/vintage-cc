use crate::outputs;

use crate::line_part::LinePart;


pub fn now(part: LinePart) -> bool {
	let loopblk_out:  String;

	match outputs::loopblocks_peek() {
		Some(loopblk_name) => {
			loopblk_out  = format!("{}_out",  &loopblk_name);

			outputs::mainfn_append(         "   ; endloop");
			outputs::mainfn_append(&format!("   jmp {}", loopblk_out));
		},
		None => {
			println!("ERROR: ln:{} `break` found outside of a `loop` block.",
				part.ln_no);
			return true;
		}
	}

	return false;
}
