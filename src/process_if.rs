use crate::get;
use crate::outputs;

use crate::line_part::LinePart;


pub fn now(part: LinePart) -> bool {
	let condition      = part.get_next().next;
	let condition_part = part.get_next();
	let condition_res:   String;
	let ifblk_name:      String;
	let ifblk_true:      String;
	let ifblk_else:      String;

	if condition_part.is_varname() {
		condition_res = get::var_fullname(&condition);
		let vtype = outputs::get_vartype(&condition_res).unwrap();
		if vtype != "u8" {
			println!(
				"WARNING: ln:{} Expected a u8 type; got `{}`, which is type `{}`",
				part.ln_no, condition, vtype)
		}
	} else {
		condition_res = format!("#{}", &condition);
	}

	ifblk_name = get::unique_ifblk_name();
	ifblk_true = format!("{}_true", &ifblk_name);
	ifblk_else = format!("{}_else", &ifblk_name);

	outputs::ifblocks_push(&ifblk_name);

	outputs::mainfn_append(&format!("   ; if {}", condition));
	outputs::mainfn_append(&format!("   lda {}", condition_res));
	//------------------------------------------------------------------------//
	// Since branching can only reach so far, I'm going to have the branching //
	// hop over to the IF true code, and have the next op, be a jump to the   //
	// else location.                                                         //
	//------------------------------------------------------------------------//
	outputs::mainfn_append(         "   cmp #1", );
	outputs::mainfn_append(&format!("   beq {}", ifblk_true));
	outputs::mainfn_append(&format!("   jmp {}", ifblk_else));
	outputs::mainfn_append("");
	outputs::mainfn_append(&format!("{}:", ifblk_true));

	return false;
}
