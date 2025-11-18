use crate::vll::outputs;

use crate::vll::line_part::LinePart;

pub fn now(part: LinePart) -> bool {
    let globname:  String;

    if part.next != "return" {
        println!(
            "ERROR: ln:{} GOTO: Expected `return`; got `{}`.",
            part.ln_no, part.next);
        return true;
    }

    globname = format!("out_fn_{}", 
        outputs::get_active_fn());

    outputs::mainfn_append(&format!("   ; return"));
    outputs::mainfn_append(&format!("   jmp {}", globname));

    return false;
}
