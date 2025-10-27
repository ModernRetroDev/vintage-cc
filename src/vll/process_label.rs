use crate::vll::outputs;

use crate::vll::line_part::LinePart;


pub fn now(part: LinePart) -> bool {
    let active_fn: String;
    let globname:  String;
    let labelname: String;

    active_fn = outputs::get_active_fn();
    if active_fn.len() == 0 {
        println!("ERROR: ln:{} label set outside of function.", 
            part.ln_no);
        return true;
    }

    labelname = part.get_next().next;

    globname = format!("label__{}__{}", 
        outputs::get_active_fn(), 
        labelname);

    outputs::mainfn_append(&format!("   ; label {}", labelname));
    outputs::mainfn_append(&format!("{}:", globname));
    outputs::mainfn_append("");
    return false;
}
