use crate::vhl::outputs;

use crate::vhl::line_part::LinePart;

pub fn now(part: LinePart) -> bool {
    let next:        LinePart;

    next = part.clone();
    if next.next != "continue;" {
        println!(
            "ERROR: ln:{} Expected `continue` got `{}`.", part.ln_no, next.next);
        return true;
    }

    //------------------------------------------------------------------------//
    // Make sure that we are within at least one loop construct.              //
    //------------------------------------------------------------------------//
    if !outputs::blktypes_has_loop() {
        println!(
            "ERROR: ln:{} Keyword `continue` can not be used outside of a loop.", 
                part.ln_no);
        return true;
    }

    outputs::lines_main_push(&format!("    # continue {}", part.rem));
    outputs::lines_main_push(         "    continue");
    outputs::lines_main_push("");

    return false;
}
