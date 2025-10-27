use crate::vll::builtins;
use crate::vll::get;
use crate::vll::outputs;

use crate::vll::line_part::LinePart;


fn as_type_file(part: LinePart) -> bool {
	let filevar      = part.get_next().next;
	let filevar_part = part.get_next();
	let filevar_res:  String;

	builtins::mark_as_used(&part.next);

	if !filevar_part.is_varname() {
		println!("ERROR: ln:{} Expected varname, got `{}`",
			part.ln_no, filevar);
		return true;
	}
	filevar_res = get::var_fullname(&filevar);

	//------------------------------------------------------------------------//
	// Extract the variable name                                              //
	//------------------------------------------------------------------------//
	let vartype = outputs::get_vartype(&filevar_res).unwrap();
	if vartype != "file" {
		println!("ERROR: ln:{} Expected a file type; got `{}`, which is type `{}`",
			part.ln_no, filevar, vartype);
		return true;
	}

	outputs::mainfn_append(&format!("   ; close__file {}", filevar));
	outputs::mainfn_append(&format!("   lda #<{}", filevar_res));
	outputs::mainfn_append(         "   sta ZP_PTR_2");
	outputs::mainfn_append(&format!("   lda #>{}", filevar_res));
	outputs::mainfn_append(         "   sta ZP_PTR_2+1");
	outputs::mainfn_append(         "   ldy #0");
	outputs::mainfn_append(         "   lda (ZP_PTR_2),y");
	outputs::mainfn_append(         "   sta ZP_PTR_1");
	outputs::mainfn_append(         "   iny");
	outputs::mainfn_append(         "   lda (ZP_PTR_2),y");
	outputs::mainfn_append(         "   sta ZP_PTR_1+1");

	outputs::mainfn_append(         "   jsr _close__file");
	outputs::mainfn_append("");

	return false;
}

pub fn now(part: LinePart) -> bool {

	if part.next == "close__file" {
		return as_type_file(part);
	} else {
		println!(
			"ERROR: ln:{} Unhandled builtin function variant `{}`.",
			part.ln_no, part.next);
		return true;
	}
}
