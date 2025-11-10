use crate::vll::builtins;
use crate::vll::fn_args;
use crate::vll::get;
use crate::vll::outputs;

use crate::vll::line_part::LinePart;


fn as_types_u8(part: LinePart) -> bool {
    let retvar      = part.get_next().next;
    let retvar_part = part.get_next();
    let lhs         = retvar_part.get_next().next;
    let lhs_part    = retvar_part.get_next();
    let rhs         = lhs_part.get_next().next;
    let rhs_part    = lhs_part.get_next();
    let rhs_isvar:    bool;
    let rhs_res:      String;
    let lhs_isvar:    bool;
    let lhs_res:      String;
    let retvar_res:   String;

    builtins::mark_as_used(&part.next);

    if !retvar_part.is_varname() {
        println!("ERROR: ln:{} Expected varname, got `{}`",
            part.ln_no, retvar);
        return true;
    }
    retvar_res = get::var_fullname(&retvar);

    lhs_isvar = lhs_part.is_varname();
    rhs_isvar = rhs_part.is_varname();

    if !fn_args::is_type_u8(&lhs_part) {
        return true;
    }
    match fn_args::get_u8_value_str(&lhs_part) {
        Some(val_str) => { lhs_res = val_str; },
        None => { return true; },
    };

    if !fn_args::is_type_u8(&rhs_part) {
        return true;
    }
    match fn_args::get_u8_value_str(&rhs_part) {
        Some(val_str) => { rhs_res = val_str; },
        None => { return true; },
    };

    outputs::mainfn_append(&format!("   ; eval_logi_and__u8 {} {} {}",
        retvar, lhs, rhs));

    if !lhs_isvar && !rhs_isvar {
        if lhs_res != "0" && rhs_res != "0" {
            outputs::mainfn_append("   lda #0; always false");
        } else {
            outputs::mainfn_append("   lda #1; always true");
        }
        outputs::mainfn_append(&format!("   sta {}", retvar_res));
        outputs::mainfn_append("");
        return false;
    }

    if lhs_isvar {
        outputs::mainfn_append(&format!("   ldx {}", lhs_res));
    } else {
        outputs::mainfn_append(&format!("   ldx #{}", lhs_res));
    }
    if rhs_isvar {
        outputs::mainfn_append(&format!("   ldy {}", rhs_res));
    } else {
        outputs::mainfn_append(&format!("   ldy #{}", rhs_res));
    }
        outputs::mainfn_append(         "   jsr _eval_logi_and__u8");
        outputs::mainfn_append(&format!("   sta {retvar_res}"));
        outputs::mainfn_append("");

    return false;
}

// fn as_types_u16(part: LinePart) -> bool {
//     // let retvar      = part.get_next().next;
//     // let retvar_part = part.get_next();
//     // let lhs         = retvar_part.get_next().next;
//     // let lhs_part    = retvar_part.get_next();
//     // let rhs         = lhs_part.get_next().next;
//     // let rhs_part    = lhs_part.get_next();
//     // let rhs_isvar:    bool;
//     // let rhs_res:      String;
//     // let lhs_isvar:    bool;
//     // let lhs_res:      String;
//     // let retvar_res:   String;

//     // builtins::mark_as_used(&part.next);

//     // if !retvar_part.is_varname() {
//     //  println!("ERROR: ln:{} Expected varname, got `{}`",
//     //      part.ln_no, retvar);
//     //  return true;
//     // }
//     // retvar_res = get::var_fullname(&retvar);

//     // lhs_isvar = lhs_part.is_varname();
//     // rhs_isvar = rhs_part.is_varname();

//     // if lhs_isvar {
//     //  lhs_res = get::var_fullname(&lhs);
//     //  let vtype = outputs::get_vartype(&lhs_res).unwrap();
//     //  if vtype != "u16" {
//     //      println!(
//     //          "WARNING: ln:{} Expected a u16 type; got `{}`, which is type `{}`",
//     //          part.ln_no, lhs, vtype)
//     //  }
//     // } else {
//     //  lhs_res = lhs.clone();
//     // }

//     // if rhs_isvar {
//     //  rhs_res = get::var_fullname(&rhs);
//     //  let vtype = outputs::get_vartype(&rhs_res).unwrap();
//     //  if vtype != "u16" {
//     //      println!(
//     //          "WARNING: ln:{} Expected a u16 type; got `{}`, which is type `{}`",
//     //          part.ln_no, rhs, vtype)
//     //  }
//     // } else {
//     //  rhs_res = rhs.clone();
//     // }

//     // outputs::mainfn_append(&format!("   ; eval_neq__u16 {retvar} {lhs} {rhs}"));

//     // if !lhs_isvar && !rhs_isvar {
//     //  if lhs_res == rhs_res {
//     //      outputs::mainfn_append("   lda #1; always true");
//     //  } else {
//     //      outputs::mainfn_append("   lda #0; always false");
//     //  }
//     //  outputs::mainfn_append(&format!("   sta {}", retvar_res));
//     //  outputs::mainfn_append("");
//     //  return false;
//     // } else if lhs_isvar && rhs_isvar {
//     //  outputs::mainfn_append(&format!("   lda #<{lhs_res}"));
//     //  outputs::mainfn_append(         "   sta ZP_PTR_1");
//     //  outputs::mainfn_append(&format!("   lda #>{lhs_res}"));
//     //  outputs::mainfn_append(         "   sta ZP_PTR_1+1");
//     //  //
//     //  outputs::mainfn_append(&format!("   lda #<{rhs_res}"));
//     //  outputs::mainfn_append(         "   sta ZP_PTR_2");
//     //  outputs::mainfn_append(&format!("   lda #>{rhs_res}"));
//     //  outputs::mainfn_append(         "   sta ZP_PTR_2+1");
//     //  //
//     //  outputs::mainfn_append(         "   jsr _eval_neq__u16");
//     //  outputs::mainfn_append(&format!("   sta {retvar_res}"));
//     //  outputs::mainfn_append("");
//     // } else if lhs_isvar {
//     //  outputs::mainfn_append(&format!("   lda #<{lhs_res}"));
//     //  outputs::mainfn_append(         "   sta ZP_PTR_1");
//     //  outputs::mainfn_append(&format!("   lda #>{lhs_res}"));
//     //  outputs::mainfn_append(         "   sta ZP_PTR_1+1");
//     //  //
//     //  outputs::mainfn_append(&format!("   lda #<{rhs_res}"));
//     //  outputs::mainfn_append(         "   sta r0");
//     //  outputs::mainfn_append(&format!("   lda #>{rhs_res}"));
//     //  outputs::mainfn_append(         "   sta r0+1");
//     //  //
//     //  outputs::mainfn_append(&format!("   lda #<r0"));
//     //  outputs::mainfn_append(         "   sta ZP_PTR_2");
//     //  outputs::mainfn_append(&format!("   lda #>r0"));
//     //  outputs::mainfn_append(         "   sta ZP_PTR_2+1");
//     //  //
//     //  outputs::mainfn_append(         "   jsr _eval_neq__u16");
//     //  outputs::mainfn_append(&format!("   sta {retvar_res}"));
//     //  outputs::mainfn_append("");
//     // } else if rhs_isvar {
//     //  outputs::mainfn_append(&format!("   lda #<{lhs_res}"));
//     //  outputs::mainfn_append(         "   sta r0");
//     //  outputs::mainfn_append(&format!("   lda #>{lhs_res}"));
//     //  outputs::mainfn_append(         "   sta r0+1");
//     //  //
//     //  outputs::mainfn_append(&format!("   lda #<r0"));
//     //  outputs::mainfn_append(         "   sta ZP_PTR_1");
//     //  outputs::mainfn_append(&format!("   lda #>r0"));
//     //  outputs::mainfn_append(         "   sta ZP_PTR_1+1");
//     //  //
//     //  outputs::mainfn_append(&format!("   lda #<{rhs_res}"));
//     //  outputs::mainfn_append(         "   sta ZP_PTR_2");
//     //  outputs::mainfn_append(&format!("   lda #>{rhs_res}"));
//     //  outputs::mainfn_append(         "   sta ZP_PTR_2+1");
//     //  //
//     //  outputs::mainfn_append(         "   jsr _eval_neq__u16");
//     //  outputs::mainfn_append(&format!("   sta {retvar_res}"));
//     //  outputs::mainfn_append("");
//     // }

//     return false;
// }

pub fn now(part: LinePart) -> bool {
    if part.next == "eval_logi_and__u8" {
        return as_types_u8(part);

    // } else if part.next == "eval_logi_and__u16" {
    //  return as_types_u16(part);

    } else {
        println!(
            "ERROR: ln:{} Unhandled builtin function variant `{}`.",
            part.ln_no, part.next);
        return true;
    }
}
