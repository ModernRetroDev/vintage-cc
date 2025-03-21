use crate::builtins;
use crate::get;
use crate::outputs;

use crate::line_part::LinePart;


fn as_type_u8(part: LinePart) -> bool {
	let retvar      = part.get_next().next;
	let retvar_part = part.get_next();
	let lhs         = retvar_part.get_next().next;
	let lhs_part    = retvar_part.get_next();
	let rhs         = lhs_part.get_next().next;
	let rhs_part    = lhs_part.get_next();
	let rhs_isvar:     bool;
	let rhs_res:       String;
	let lhs_isvar:     bool;
	let lhs_res:       String;
	let retvar_res:    String;
	let evalname:      String;
	let evalname_out:  String;
	let evalname_fail: String;

	if !retvar_part.is_varname() {
		println!("ERROR: ln:{} Expected varname, got `{}`",
			part.ln_no, retvar);
		return true;
	}
	retvar_res = get::var_fullname(&retvar);

	lhs_isvar = lhs_part.is_varname();
	rhs_isvar = rhs_part.is_varname();

	if lhs_isvar {
		lhs_res = get::var_fullname(&lhs);
		let vtype = outputs::get_vartype(&lhs_res).unwrap();
		if vtype != "u8" {
			println!(
				"WARNING: ln:{} Expected a u8 type; got `{}`, which is type `{}`",
				part.ln_no, lhs, vtype)
		}
	} else {
		lhs_res = format!("#{}", &lhs);
	}

	if rhs_isvar {
		rhs_res = get::var_fullname(&rhs);
		let vtype = outputs::get_vartype(&rhs_res).unwrap();
		if vtype != "u8" {
			println!(
				"WARNING: ln:{} Expected a u8 type; got `{}`, which is type `{}`",
				part.ln_no, rhs, vtype)
		}
	} else {
		rhs_res = format!("#{}", &rhs);
	}

	outputs::mainfn_append(&format!("   ; eval_gt__u8 {} {} {}",
		retvar, lhs, rhs));

	if !lhs_isvar && !rhs_isvar {
		let lhs_val = lhs.parse::<i64>().unwrap();
		let rhs_val = rhs.parse::<i64>().unwrap();
		if lhs_val > rhs_val {
			outputs::mainfn_append("   lda #1; always true");
		} else {
			outputs::mainfn_append("   lda #0; always false");
		}
		outputs::mainfn_append(&format!("   sta {}", retvar_res));
		outputs::mainfn_append("");
		return false;
	}

	evalname      = get::unique_eval_label();
	evalname_fail = format!("{}_fail", &evalname);
	evalname_out  = format!("{}_out", &evalname);
	if lhs_isvar && rhs_isvar {
		outputs::mainfn_append(&format!("   lda {}", rhs_res));
		outputs::mainfn_append(         "   sta ZP_PTR_1");
		outputs::mainfn_append(&format!("   lda {}", lhs_res));
		outputs::mainfn_append(         "   cmp ZP_PTR_1");
	} else if lhs_isvar {
		outputs::mainfn_append(&format!("   lda {}", lhs_res));
		outputs::mainfn_append(&format!("   cmp {}", rhs_res));
	} else if rhs_isvar {
		outputs::mainfn_append(&format!("   lda {}", lhs_res));
		outputs::mainfn_append(&format!("   cmp {}", rhs_res));
	}

	outputs::mainfn_append(&format!("   beq {}", evalname_fail));
	outputs::mainfn_append(&format!("   bcs {}", evalname));
	outputs::mainfn_append(&format!("{}:", evalname_fail));
	outputs::mainfn_append(         "   lda #0; false");
	outputs::mainfn_append(&format!("   jmp {}", evalname_out));
	outputs::mainfn_append(&format!("{}:", evalname));
	outputs::mainfn_append(         "   lda #1; true");
	outputs::mainfn_append(&format!("{}:", evalname_out));
	outputs::mainfn_append(&format!("   sta {}", retvar_res));
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

	if lhs_isvar {
		lhs_res = get::var_fullname(&lhs);
		let vtype = outputs::get_vartype(&lhs_res).unwrap();
		if vtype != "u16" {
			println!(
				"WARNING: ln:{} Expected a u16 type; got `{}`, which is type `{}`",
				part.ln_no, lhs, vtype)
		}
	} else {
		println!("ERROR/TODO: Non variable U16 in eval_gt on LN {}", part.ln_no);
		return true;
	}

	if rhs_isvar {
		rhs_res = get::var_fullname(&rhs);
		let vtype = outputs::get_vartype(&rhs_res).unwrap();
		if vtype != "u16" {
			println!(
				"WARNING: ln:{} Expected a u16 type; got `{}`, which is type `{}`",
				part.ln_no, rhs, vtype)
		}
	} else {
		println!("ERROR/TODO: Non variable U16 in eval_gt on LN {}", part.ln_no);
		return true;
	}

	outputs::mainfn_append(&format!("   ; eval_gt__u16 {retvar} {lhs} {rhs}"));

	if !lhs_isvar && !rhs_isvar {
		if lhs_res > rhs_res {
			outputs::mainfn_append("   lda #1; always true");
		} else {
			outputs::mainfn_append("   lda #0; always false");
		}
		outputs::mainfn_append(&format!("   sta {retvar_res}"));
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
		outputs::mainfn_append(         "   jsr _eval_gt__u16");
		outputs::mainfn_append(&format!("   sta {retvar_res}"));
		outputs::mainfn_append("");
	}

	return false;
}

pub fn now(part: LinePart) -> bool {
	if part.next == "eval_gt__u8" {
		return as_type_u8(part);

	} else if part.next == "eval_gt__u16" {
		return as_type_u16(part);

	} else {
		println!(
			"ERROR: ln:{} Unhandled builtin function variant `{}`.",
			part.ln_no, part.next);
		return true;
	}
}
