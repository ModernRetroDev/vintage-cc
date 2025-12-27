use crate::vll::builtins;
use crate::vll::fn_args;
use crate::vll::get;
use crate::vll::outputs;

use crate::vll::line_part::LinePart;


fn as_type_u8(part: LinePart) -> bool {
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
    let evalname:     String;
    let evalname_out: String;

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

    let branch_ins: String = match &outputs::get_platform()[..] {
        "c64"   => { "jmp".to_string() }
        "f256k" => { "bra".to_string() }
        "x16"   => { "bra".to_string() }
        _       => {
            println!("ERROR: ln:{} EVAL_EQ: Unhandled platform `{}`",
                part.ln_no, outputs::get_platform());
            return true;
        }
    };

    outputs::mainfn_append(&format!("   ; eval_eq__u8 {retvar} {lhs} {rhs}"));

    if !lhs_isvar && !rhs_isvar {
        if lhs_res == rhs_res {
            outputs::mainfn_append("   lda #1; always true");
        } else {
            outputs::mainfn_append("   lda #0; always false");
        }
        outputs::mainfn_append(&format!("   sta {retvar_res}"));
        outputs::mainfn_append("");
        return false;
    }

    evalname     = get::unique_eval_label();
    evalname_out = format!("{}_out", &evalname);
    if lhs_isvar && rhs_isvar {
        outputs::mainfn_append(&format!("   lda {rhs_res}"));
        outputs::mainfn_append(         "   sta ZP_PTR_1");
        outputs::mainfn_append(&format!("   lda {lhs_res}"));
        outputs::mainfn_append(         "   cmp ZP_PTR_1");
    } else if lhs_isvar {
        outputs::mainfn_append(&format!("   lda {lhs_res}"));
        outputs::mainfn_append(&format!("   cmp {rhs_res}"));
    } else if rhs_isvar {
        outputs::mainfn_append(&format!("   lda {rhs_res}"));
        outputs::mainfn_append(&format!("   cmp {lhs_res}"));
    }

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

fn as_type_u16(part: LinePart) -> bool {
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


    if !fn_args::is_type_u16(&lhs_part) {
        println!("ERROR: ln:{} Expected a u16 type; got `{}`",
            part.ln_no, lhs);
        return true;
    }
    match fn_args::get_u16_value_str(&lhs_part) {
        Some(val_str) => { lhs_res = val_str; },
        None => {
            println!("ERROR: ln:{} Failed to get u16 value of `{}`",
                part.ln_no, lhs_part.next);
            return true;
        },
    };

    if !fn_args::is_type_u16(&rhs_part) {
        println!("ERROR: ln:{} Expected a u16 type; got `{}`",
            part.ln_no, rhs);
        return true;
    }
    match fn_args::get_u16_value_str(&rhs_part) {
        Some(val_str) => { rhs_res = val_str; },
        None => {
            println!("ERROR: ln:{} Failed to get u16 value of `{}`",
                part.ln_no, rhs_part.next);
            return true;
        },
    };

    outputs::mainfn_append(&format!("   ; eval_eq__u16 {retvar} {lhs} {rhs}"));

    if !lhs_isvar && !rhs_isvar {
        if lhs_res == rhs_res {
            outputs::mainfn_append("   lda #1; always true");
        } else {
            outputs::mainfn_append("   lda #0; always false");
        }
        outputs::mainfn_append(&format!("   sta {}", retvar_res));
        outputs::mainfn_append("");
        return false;
    } else if lhs_isvar && rhs_isvar {
        outputs::mainfn_append(&format!("   lda #<{lhs_res}"));
        outputs::mainfn_append(         "   sta ZP_PTR_1");
        outputs::mainfn_append(&format!("   lda #>{lhs_res}"));
        outputs::mainfn_append(         "   sta ZP_PTR_1+1");
        //
        outputs::mainfn_append(&format!("   lda #<{rhs_res}"));
        outputs::mainfn_append(         "   sta ZP_PTR_2");
        outputs::mainfn_append(&format!("   lda #>{rhs_res}"));
        outputs::mainfn_append(         "   sta ZP_PTR_2+1");
        //
        outputs::mainfn_append(         "   jsr _eval_eq__u16");
        outputs::mainfn_append(&format!("   sta {retvar_res}"));
        outputs::mainfn_append("");
    } else if lhs_isvar {
        outputs::mainfn_append(&format!("   lda #<{lhs_res}"));
        outputs::mainfn_append(         "   sta ZP_PTR_1");
        outputs::mainfn_append(&format!("   lda #>{lhs_res}"));
        outputs::mainfn_append(         "   sta ZP_PTR_1+1");
        //
        outputs::mainfn_append(&format!("   lda #<{}", &rhs_res[1..]));
        outputs::mainfn_append(         "   sta r0");
        outputs::mainfn_append(&format!("   lda #>{}", &rhs_res[1..]));
        outputs::mainfn_append(         "   sta r0+1");
        //
        outputs::mainfn_append(&format!("   lda #<r0"));
        outputs::mainfn_append(         "   sta ZP_PTR_2");
        outputs::mainfn_append(&format!("   lda #>r0"));
        outputs::mainfn_append(         "   sta ZP_PTR_2+1");
        //
        outputs::mainfn_append(         "   jsr _eval_eq__u16");
        outputs::mainfn_append(&format!("   sta {retvar_res}"));
        outputs::mainfn_append("");
    } else if rhs_isvar {
        outputs::mainfn_append(&format!("   lda #<{}", &lhs_res[1..]));
        outputs::mainfn_append(         "   sta r0");
        outputs::mainfn_append(&format!("   lda #>{}", &lhs_res[1..]));
        outputs::mainfn_append(         "   sta r0+1");
        //
        outputs::mainfn_append(&format!("   lda #<r0"));
        outputs::mainfn_append(         "   sta ZP_PTR_1");
        outputs::mainfn_append(&format!("   lda #>r0"));
        outputs::mainfn_append(         "   sta ZP_PTR_1+1");
        //
        outputs::mainfn_append(&format!("   lda #<{rhs_res}"));
        outputs::mainfn_append(         "   sta ZP_PTR_2");
        outputs::mainfn_append(&format!("   lda #>{rhs_res}"));
        outputs::mainfn_append(         "   sta ZP_PTR_2+1");
        //
        outputs::mainfn_append(         "   jsr _eval_eq__u16");
        outputs::mainfn_append(&format!("   sta {retvar_res}"));
        outputs::mainfn_append("");
    }

    return false;
}

fn as_type_u24(part: LinePart) -> bool {
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


    if !fn_args::is_type_u24(&lhs_part) {
        println!("ERROR: ln:{} Expected a u24 type; got `{}`",
            part.ln_no, lhs);
        return true;
    }
    match fn_args::get_u24_value_str(&lhs_part) {
        Some(val_str) => { lhs_res = val_str; },
        None => {
            println!("ERROR: ln:{} Failed to get u24 value of `{}`",
                part.ln_no, lhs_part.next);
            return true;
        },
    };

    if !fn_args::is_type_u24(&rhs_part) {
        println!("ERROR: ln:{} Expected a u24 type; got `{}`",
            part.ln_no, rhs);
        return true;
    }
    match fn_args::get_u24_value_str(&rhs_part) {
        Some(val_str) => { rhs_res = val_str; },
        None => {
            println!("ERROR: ln:{} Failed to get u24 value of `{}`",
                part.ln_no, rhs_part.next);
            return true;
        },
    };

    outputs::mainfn_append(&format!("   ; eval_eq__u24 {retvar} {lhs} {rhs}"));

    if !lhs_isvar && !rhs_isvar {
        if lhs_res == rhs_res {
            outputs::mainfn_append("   lda #1; always true");
        } else {
            outputs::mainfn_append("   lda #0; always false");
        }
        outputs::mainfn_append(&format!("   sta {}", retvar_res));
        outputs::mainfn_append("");
        return false;
    } else if lhs_isvar && rhs_isvar {
        outputs::mainfn_append(&format!("   lda #<{lhs_res}"));
        outputs::mainfn_append(         "   sta ZP_PTR_1");
        outputs::mainfn_append(&format!("   lda #>{lhs_res}"));
        outputs::mainfn_append(         "   sta ZP_PTR_1+1");
        //
        outputs::mainfn_append(&format!("   lda #<{rhs_res}"));
        outputs::mainfn_append(         "   sta ZP_PTR_2");
        outputs::mainfn_append(&format!("   lda #>{rhs_res}"));
        outputs::mainfn_append(         "   sta ZP_PTR_2+1");
        //
        outputs::mainfn_append(         "   jsr _eval_eq__u24");
        outputs::mainfn_append(&format!("   sta {retvar_res}"));
        outputs::mainfn_append("");
    } else if lhs_isvar {
        let rhs_val = &rhs_res[1..].parse::<i64>().unwrap();
        let rhs_hexstr: String = format!("{:06X}", rhs_val);
        // b0 is the low byte
        let rhs_hex_b0 = &rhs_hexstr[4..6];
        // b1 is the med byte
        let rhs_hex_b1 = &rhs_hexstr[2..4];
        // b2 is the high byte
        let rhs_hex_b2 = &rhs_hexstr[0..2];

        outputs::mainfn_append(&format!("   lda #<{lhs_res}"));
        outputs::mainfn_append(         "   sta ZP_PTR_1");
        outputs::mainfn_append(&format!("   lda #>{lhs_res}"));
        outputs::mainfn_append(         "   sta ZP_PTR_1+1");
        //
        outputs::mainfn_append(&format!("   lda #${rhs_hex_b0}"));
        outputs::mainfn_append(         "   sta r0");
        outputs::mainfn_append(&format!("   lda #${rhs_hex_b1}"));
        outputs::mainfn_append(         "   sta r0+1");
        outputs::mainfn_append(&format!("   lda #${rhs_hex_b2}"));
        outputs::mainfn_append(         "   sta r0+2");
        //
        outputs::mainfn_append(&format!("   lda #<r0"));
        outputs::mainfn_append(         "   sta ZP_PTR_2");
        outputs::mainfn_append(&format!("   lda #>r0"));
        outputs::mainfn_append(         "   sta ZP_PTR_2+1");
        //
        outputs::mainfn_append(         "   jsr _eval_eq__u24");
        outputs::mainfn_append(&format!("   sta {retvar_res}"));
        outputs::mainfn_append("");
    } else if rhs_isvar {
        let lhs_val = &lhs_res[1..].parse::<i64>().unwrap();
        let lhs_hexstr: String = format!("{:06X}", lhs_val);
        // b0 is the low byte
        let lhs_hex_b0 = &lhs_hexstr[4..6];
        // b1 is the med byte
        let lhs_hex_b1 = &lhs_hexstr[2..4];
        // b2 is the high byte
        let lhs_hex_b2 = &lhs_hexstr[0..2];

        outputs::mainfn_append(&format!("   lda #${lhs_hex_b0}"));
        outputs::mainfn_append(         "   sta r0");
        outputs::mainfn_append(&format!("   lda #${lhs_hex_b1}"));
        outputs::mainfn_append(         "   sta r0+1");
        outputs::mainfn_append(&format!("   lda #${lhs_hex_b2}"));
        outputs::mainfn_append(         "   sta r0+2");
        //
        outputs::mainfn_append(&format!("   lda #<r0"));
        outputs::mainfn_append(         "   sta ZP_PTR_1");
        outputs::mainfn_append(&format!("   lda #>r0"));
        outputs::mainfn_append(         "   sta ZP_PTR_1+1");
        //
        outputs::mainfn_append(&format!("   lda #<{rhs_res}"));
        outputs::mainfn_append(         "   sta ZP_PTR_2");
        outputs::mainfn_append(&format!("   lda #>{rhs_res}"));
        outputs::mainfn_append(         "   sta ZP_PTR_2+1");
        //
        outputs::mainfn_append(         "   jsr _eval_eq__u24");
        outputs::mainfn_append(&format!("   sta {retvar_res}"));
        outputs::mainfn_append("");
    }

    return false;
}

pub fn now(part: LinePart) -> bool {
    if part.next == "eval_eq__u8" {
        return as_type_u8(part);

    } else if part.next == "eval_eq__u16" {
        return as_type_u16(part);

    } else if part.next == "eval_eq__u24" {
        return as_type_u24(part);

    } else {
        println!(
            "ERROR: ln:{} Unhandled builtin function variant `{}`.",
            part.ln_no, part.next);
        return true;
    }
}
