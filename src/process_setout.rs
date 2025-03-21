use crate::builtins;
use crate::get;
use crate::outputs;

use crate::line_part::LinePart;


fn as_type_default(_part: LinePart) -> bool {

	outputs::mainfn_append("   ; setout__default");
	outputs::mainfn_append("   jsr CLRCHN");
	outputs::mainfn_append("");

	return false
}

fn as_type_file(part: LinePart) -> bool {
	let filevar      = part.get_next().next;
	let filevar_part = part.get_next();
	let filevar_res: String;

	builtins::mark_as_used(&part.next);

	// read in the file variable name
	if !filevar_part.is_varname() {
		println!("ERROR: ln:{} Expected varname, got `{}`",
			part.ln_no, filevar);
		return true;
	}
	filevar_res = get::var_fullname(&filevar);

	outputs::mainfn_append(&format!("   ; setout__file {}", filevar));
	outputs::mainfn_append(&format!("   lda #<{}", filevar_res));
	outputs::mainfn_append(         "   sta ZP_PTR_1");
	outputs::mainfn_append(&format!("   lda #>{}", filevar_res));
	outputs::mainfn_append(         "   sta ZP_PTR_1+1");
	outputs::mainfn_append(         "   jsr _setout__file");
	outputs::mainfn_append("");

	return false;
}

pub fn now(part: LinePart) -> bool {

	if part.next == "setout__default" {
		return as_type_default(part);

	} else if part.next == "setout__file" {
		return as_type_file(part);

	} else {
		println!(
			"ERROR: ln:{} Unhandled builtin function variant `{}`.",
			part.ln_no, part.next);
		return true;
	}
}
