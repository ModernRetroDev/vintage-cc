use crate::outputs;

use crate::line_part::LinePart;


pub fn now(part: LinePart) -> bool {
	let fn_name = part.get_next().next;

	outputs::set_active_fn(&fn_name);

	return false;
}
