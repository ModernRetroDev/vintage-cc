use crate::vll::get;
use crate::vll::outputs;

use crate::vll::line_part::LinePart;


fn as_type_u8(part: LinePart) -> bool {
    let mut globname_arr: String;
    let     globname_rv:  String;
    let     varname     = part.get_next().next;
    let     array_name  = part.get_next().get_next().next;

    globname_arr = get::var_fullname(&array_name);
    match outputs::get_vartype(&globname_arr) {
        Some(vtype) => {
            if ! (vtype == "str8" || vtype == "str16") {
                return false;
            }
        },
        None => {
            globname_arr = format!("arr8__{}__{}", 
                outputs::get_active_fn(), 
                &array_name[1..]);
        }
    }

    globname_rv = get::var_fullname(&varname);

    outputs::mainfn_append(&format!("   ; get_alloc__arr8 {}", globname_arr));
    outputs::mainfn_append(&format!("   lda {}", globname_arr));
    outputs::mainfn_append(         "   sta ZP_PTR_1");
    outputs::mainfn_append(&format!("   lda {}+1", globname_arr));
    outputs::mainfn_append(         "   sta ZP_PTR_1+1");
    //
    outputs::mainfn_append(         "   ldy #3");
    outputs::mainfn_append(         "   lda (ZP_PTR_1),y");
    outputs::mainfn_append(&format!("   sta {}", globname_rv));

    return false;
}

fn as_type_u16(part: LinePart) -> bool {
    let mut globname_arr: String;
    let     globname_rv:  String;
    let     varname     = part.get_next().next;
    let     array_name  = part.get_next().get_next().next;

    globname_arr = get::var_fullname(&array_name);
    match outputs::get_vartype(&globname_arr) {
        Some(vtype) => {
            if ! (vtype == "str8" || vtype == "str16") {
                return false;
            }
        },
        None => {
            globname_arr = format!("arr16__{}__{}", 
                outputs::get_active_fn(), 
                &array_name[1..]);
        }
    }

    globname_rv = get::var_fullname(&varname);

    outputs::mainfn_append(&format!("   ; get_alloc__arr16 {}", globname_arr));
    outputs::mainfn_append(&format!("   lda {}", globname_arr));
    outputs::mainfn_append(         "   sta ZP_PTR_1");
    outputs::mainfn_append(&format!("   lda {}+1", globname_arr));
    outputs::mainfn_append(         "   sta ZP_PTR_1+1");
    //
    outputs::mainfn_append(         "   ldy #3");
    outputs::mainfn_append(         "   lda (ZP_PTR_1),y");
    outputs::mainfn_append(&format!("   sta {}", globname_rv));
    outputs::mainfn_append(         "   iny");
    outputs::mainfn_append(         "   lda (ZP_PTR_1),y");
    outputs::mainfn_append(&format!("   sta {}+1", globname_rv));

    return false;
}

pub fn now(part: LinePart) -> bool {
    let active_fn: String;

    active_fn = outputs::get_active_fn();
    if active_fn.len() == 0 {
        println!("ERROR: ln:{} GET_ALLOC: outside of function.", part.ln_no);
        return true;
    }

    if part.next.starts_with("get_alloc__arr8") {
        return as_type_u8(part);
    } else if part.next.starts_with("get_alloc__arr16") {
        return as_type_u16(part);
    } else {
        println!(
            "ERROR: ln:{} GET_ALLOC: Unhandled builtin function variant `{}`.",
            part.ln_no, part.next);
        return true;
    }
}
