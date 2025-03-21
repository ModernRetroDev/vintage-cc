use crate::get;
use crate::outputs;

use crate::line_part::LinePart;


pub fn now(_part: LinePart) -> bool {
	let loopblk_name:    String;

	loopblk_name = get::unique_loopblk_name();

	outputs::loopblocks_push(&loopblk_name);

	outputs::mainfn_append(         "   ; loop");
	outputs::mainfn_append(&format!("{}:", loopblk_name));

	return false;
}
