use crate::vhl::outputs;

use crate::vhl::line_part::LinePart;


pub fn now(_part: LinePart) -> bool {

    outputs::lines_main_push("    # return");
    outputs::lines_main_push("    return");
    outputs::lines_main_push("");

    return false;
}
