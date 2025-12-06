use crate::vll::get;
use crate::vll::outputs;

use crate::vll::line_part::LinePart;


fn as_types_bool_bool(part: LinePart) -> bool {
    let retvar      = part.get_next().next;
    let retvar_part = part.get_next();
    let rhs         = retvar_part.get_next().next;
    let rhs_part    = retvar_part.get_next();
    let rhs_isvar:    bool;
    let rhs_res:      String;
    let retvar_res:   String;
    let evalname:     String;
    let evalname_out: String;

    if !retvar_part.is_varname() {
        println!("ERROR: ln:{} EQUALS_NOT: Expected varname, got `{}`",
            part.ln_no, retvar);
        return true;
    }
    retvar_res = get::var_fullname(&retvar);

    rhs_isvar = rhs_part.is_varname();

    if rhs_isvar {
        rhs_res = get::var_fullname(&rhs);
        let vtype = outputs::get_vartype(&rhs_res).unwrap();
        if vtype != "bool" {
            println!(
                "WARNING: ln:{} EQUALS_NOT: Expected a bool type; got `{}`, which is type `{}`",
                part.ln_no, rhs, vtype)
        }
    } else {
        rhs_res = format!("#{}", &rhs);
    }

    let branch_ins: String = match &outputs::get_platform()[..] {
        "c64" => { "jmp".to_string() }
        "x16" => { "bra".to_string() }
        _     => {
            println!("ERROR: ln:{} EVAL_EQ_NOT: Unhandled platform `{}`",
                part.ln_no, outputs::get_platform());
            return true;
        }
    };

    outputs::mainfn_append(&format!("   ; equals_not__bool_bool {retvar} {rhs}"));

    evalname     = get::unique_eval_label();
    evalname_out = format!("{}_out", &evalname);

    outputs::mainfn_append(&format!("   lda {rhs_res}"));
    outputs::mainfn_append(&format!("   cmp #0"));

    outputs::mainfn_append(&format!("   beq {evalname}"));
    outputs::mainfn_append(         "   lda #0; false");
    outputs::mainfn_append(&format!("   {branch_ins} {evalname_out}"));
    outputs::mainfn_append(&format!("{evalname}:"));
    outputs::mainfn_append(         "   lda #1; true");
    outputs::mainfn_append(&format!("{evalname_out}:"));
    outputs::mainfn_append(&format!("   sta {retvar_res}"));
    outputs::mainfn_append("");

    return false;
}

pub fn now(part: LinePart) -> bool {

    if part.next == "equals_not__bool_bool" {
        return as_types_bool_bool(part);

    } else {
        println!(
            "ERROR: ln:{} Unhandled builtin function variant `{}`.",
            part.ln_no, part.next);
        return true;
    }
}
