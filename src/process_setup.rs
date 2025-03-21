use crate::get;
use crate::outputs;

use crate::line_part::LinePart;


fn as_type_file(part: LinePart) -> bool {
	let     retvar      = part.get_next().next;
	let     retvar_part = part.get_next();
	let     retvar_res:   String;
	let     fmode       = retvar_part.get_next().next;
	let     fmode_part  = retvar_part.get_next();
	let     fmode_res:    String;
	let     fname:        String;
	let     fname_part:   LinePart;
	let     fname_res:    String;
	let     value_str: String;
	let mut str_bytes: Vec<u8> = Vec::new();

	// read in the file variable name
	if !retvar_part.is_varname() {
		println!("ERROR: ln:{} Expected varname, got `{}`",
			part.ln_no, retvar);
		return true;
	}
	retvar_res = get::var_fullname(&retvar);

	// read in the file mode
	if fmode_part.is_varname() {
		fmode_res = get::var_fullname(&fmode);
		fname      = fmode_part.get_next().next;
		fname_part = fmode_part.get_next();
	} else {
		let achar = retvar_part.get_next_char();
		match achar {
			Some(achar) => {
				fmode_res = format!("#${:02X}", achar);
				fname      = fmode_part.get_next_after_char().next;
				fname_part = fmode_part.get_next_after_char();
			},
			None => {
				println!("ERROR: malformed char on LN {}", part.ln_no);
				return true;
			}
		}
	}

	// read in the file name
	if fname_part.is_varname() {
		// we are referencing a variable... resolve name
		fname_res = get::var_fullname(&fname);
	} else {
		// else; we need to make and store this str8 data
		match fmode_part.get_next_str() {
			Some(next_part) => {
				value_str = next_part.next;
			},
			None => {
				println!("ERROR: malformed string on LN {}", part.ln_no);
				return true;
			}
		}
		fname_res  = get::unique_str8_varname();

		outputs::set_var_index(&fname_res);
		outputs::varnames_append(&fname_res);
		outputs::vartypes_append("str8");

		let stop = value_str.len() - 1;
		let str_data = &value_str[1..stop];
		for byte in str_data.bytes() {
			str_bytes.push(byte);
		}

		outputs::varvalues_append(str_bytes);
	}

	outputs::mainfn_append(&format!("   ; setup__file {} {} {}", 
		retvar, fmode, fname));
	outputs::mainfn_append(&format!("   ; ... f.mode = {}", 1));
	outputs::mainfn_append(&format!("   ldx #0"));
	outputs::mainfn_append(&format!("   lda #1"));
	outputs::mainfn_append(&format!("   sta {},X", retvar_res));
	outputs::mainfn_append("");
	outputs::mainfn_append(&format!("   ; ... f.device = {}", 8));
	outputs::mainfn_append(         "   inx");
	outputs::mainfn_append(&format!("   lda #8"));
	outputs::mainfn_append(&format!("   sta {},X", retvar_res));
	outputs::mainfn_append("");
	outputs::mainfn_append(&format!("   ; ... f.channel = {}", 1));
	outputs::mainfn_append(         "   inx");
	outputs::mainfn_append(&format!("   lda #1"));
	outputs::mainfn_append(&format!("   sta {},X", retvar_res));
	outputs::mainfn_append("");
	outputs::mainfn_append(&format!("   ; ... f.status = {}", 0));
	outputs::mainfn_append(         "   inx");
	outputs::mainfn_append(&format!("   lda #0"));
	outputs::mainfn_append(&format!("   sta {},X", retvar_res));
	outputs::mainfn_append("");
	outputs::mainfn_append(&format!("   ; ... f.name = {}", fname));
	outputs::mainfn_append(         "   inx");
	outputs::mainfn_append(&format!("   lda #<{}", fname_res));
	outputs::mainfn_append(&format!("   sta {},X", retvar_res));
	outputs::mainfn_append(         "   inx");
	outputs::mainfn_append(&format!("   lda #>{}", fname_res));
	outputs::mainfn_append(&format!("   sta {},X", retvar_res));
	outputs::mainfn_append("");

	return false;
}


pub fn now(part: LinePart) -> bool {

	if part.next == "setup__file" {
		return as_type_file(part);
	} else {
		println!(
			"ERROR: ln:{} Unhandled builtin function variant `{}`.",
			part.ln_no, part.next);
		return true;
	}
}
