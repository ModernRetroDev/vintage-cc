use crate::vll::outputs;

use crate::vll::line_part::LinePart;


pub fn now(part: LinePart) -> bool {
    let fn_name = part.get_next().next;

    // make sure that the named function exists
    if !outputs::fn_is_defined(&fn_name) {
        println!("ERROR: ln:{} CALL: Named function `{}` is not defined.",
            part.ln_no, fn_name);
        return true;
    }

    outputs::mainfn_append(&format!("   ; call {}", fn_name));
    outputs::mainfn_append(&format!("   jsr fn_{}", fn_name));
    outputs::mainfn_append("");

    return false;
}
