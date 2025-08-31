use crate::vll::builtins;
use crate::vll::outputs;

use crate::vll::line_part::LinePart;


pub fn now(part: LinePart) -> bool {

	builtins::mark_as_used(&part.next);

	outputs::mainfn_append("   ; shutdown");
	outputs::mainfn_append("   jsr _shutdown");
	outputs::mainfn_append("");

	return false
}
