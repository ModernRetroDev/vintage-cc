use crate::vll::outputs;

use crate::vll::line_part::LinePart;

pub fn now(part: LinePart) -> bool {
    let globname:  String;
    let labelname: String;

    if part.next != "goto" {
        println!(
            "ERROR: ln:{} GOTO: Expected `goto`; got `{}`.",
            part.ln_no, part.next);
        return true;
    }

    labelname = part.get_next().next;

    globname = format!("label__{}__{}", 
        outputs::get_active_fn(), 
        labelname);

    println!("TODO[VLL]: Double check that label is actually defined!");

    outputs::mainfn_append(&format!("   ; goto {}", labelname));
    outputs::mainfn_append(&format!("   jmp {}", globname));

    return false;
}
