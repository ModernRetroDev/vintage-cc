#![allow(static_mut_refs)]

use lazy_static::lazy_static;
use std::collections::HashMap;
use std::fs::File;
use std::io::Write;
use std::sync::Mutex;

lazy_static!{
	static ref ARR8_INDICES:   Mutex<HashMap<String, usize>> = Mutex::new(HashMap::new());
	static ref ARR16_INDICES:  Mutex<HashMap<String, usize>> = Mutex::new(HashMap::new());
	static ref VAR_INDICES:    Mutex<HashMap<String, usize>> = Mutex::new(HashMap::new());
	static ref IFBLK_HAS_ELSE: Mutex<HashMap<String, bool>>  = Mutex::new(HashMap::new());
}

static mut ACTIVE_FN:       String = String::new();
static mut PLATFORM:        String = String::new();
static mut OUTPUT_FILENAME: String = String::new();
static mut IFBLK_LEVELS:    Vec<String> = Vec::new();
static mut LOOPBLK_LEVELS:  Vec<String> = Vec::new();

static mut ARR8_NAMES:  Vec<String>  = Vec::new();
static mut ARR8_TYPES:  Vec<String>  = Vec::new();
static mut ARR8_VALUES: Vec<Vec<u8>> = Vec::new();

static mut ARR16_NAMES:  Vec<String>  = Vec::new();
static mut ARR16_TYPES:  Vec<String>  = Vec::new();
static mut ARR16_VALUES: Vec<Vec<u8>> = Vec::new();

static mut VAR_NAMES:  Vec<String>  = Vec::new();
static mut VAR_TYPES:  Vec<String>  = Vec::new();
static mut VAR_VALUES: Vec<Vec<u8>> = Vec::new();

static mut LINES_PLATFORM_BP:   Vec<String> = Vec::new();
static mut LINES_MAIN_FN:       Vec<String> = Vec::new();
static mut LINES_VARIABLE_DEFS: Vec<String> = Vec::new();
static mut LINES_BUILTIN_FNS:   Vec<String> = Vec::new();


pub fn set_output_filename(outname: &str) {
	unsafe {
		OUTPUT_FILENAME = outname.to_string();
	}
}

pub fn get_platform() -> String {
	unsafe {
		return PLATFORM.clone();
	}
}

pub fn set_platform(platform: &str) {
	unsafe {
		LINES_PLATFORM_BP = Vec::new();
		LINES_PLATFORM_BP.push(";--------------------------------------------------------;".to_string());
		LINES_PLATFORM_BP.push("; PLATFORM BOILERPLATE                                   ;".to_string());
		LINES_PLATFORM_BP.push(";--------------------------------------------------------;".to_string());
	}
	if platform == "x16" {
		unsafe {
			PLATFORM = platform.to_string();

			LINES_PLATFORM_BP.push(".include \"x16.inc\"".to_string());
			LINES_PLATFORM_BP.push("".to_string());
			LINES_PLATFORM_BP.push(".org $080D".to_string());
			LINES_PLATFORM_BP.push(".segment \"STARTUP\"".to_string());
			LINES_PLATFORM_BP.push(".segment \"INIT\"".to_string());
			LINES_PLATFORM_BP.push(".segment \"ONCE\"".to_string());
			LINES_PLATFORM_BP.push(".segment \"CODE\"".to_string());
			LINES_PLATFORM_BP.push("".to_string());
			LINES_PLATFORM_BP.push("   jmp main".to_string());
			LINES_PLATFORM_BP.push("".to_string());
		}
	}
}

pub fn set_active_fn(fn_name: &str) {
	unsafe {
		ACTIVE_FN = fn_name.to_string();
	}
}

pub fn get_active_fn() -> String {
	let active_fn: String;
	unsafe {
		active_fn = ACTIVE_FN.clone();
	}
	return active_fn
}

pub fn set_arr8_index(arr8name: &str) {
	unsafe {
		let len = ARR8_NAMES.len();
		ARR8_INDICES.lock().unwrap().insert(arr8name.to_string(), len);
	}
}

pub fn get_arr8type(arr8name: &str) -> Option<String> {
	let mut ind: usize = 0;
	unsafe {
		for globvar in ARR8_NAMES.clone() {
			if arr8name == &globvar {
				return Some(ARR8_TYPES[ind].to_string());
			}
			ind += 1
		}
	}
	return None;
}

pub fn set_arr16_index(arr16name: &str) {
	unsafe {
		let len = ARR16_NAMES.len();
		ARR16_INDICES.lock().unwrap().insert(arr16name.to_string(), len);
	}
}

pub fn get_arr16type(arr16name: &str) -> Option<String> {
	let mut ind: usize = 0;
	unsafe {
		for globvar in ARR16_NAMES.clone() {
			if arr16name == &globvar {
				return Some(ARR16_TYPES[ind].to_string());
			}
			ind += 1
		}
	}
	return None;
}

pub fn set_var_index(varname: &str) {
	unsafe {
		let len = VAR_NAMES.len();
		VAR_INDICES.lock().unwrap().insert(varname.to_string(), len);
	}
}

pub fn get_vartype(varname: &str) -> Option<String> {
	let mut ind: usize = 0;
	unsafe {
		for globvar in VAR_NAMES.clone() {
			if varname == &globvar {
				return Some(VAR_TYPES[ind].to_string());
			}
			ind += 1
		}
	}
	return None;
}

pub fn ifblocks_push(ifblk: &str) {
	unsafe {
		IFBLK_LEVELS.push(ifblk.to_string());
	}
}

pub fn ifblocks_peek() -> Option<String> {
	unsafe {
		if IFBLK_LEVELS.len() == 0 {
			return None
		}
		let lastblk = IFBLK_LEVELS.pop().unwrap();
		IFBLK_LEVELS.push(lastblk.to_string());

		return Some(lastblk);
	}
}

pub fn ifblocks_pop() -> Option<String> {
	unsafe {
		if IFBLK_LEVELS.len() == 0 {
			return None
		}
		let lastblk = IFBLK_LEVELS.pop().unwrap();

		return Some(lastblk);
	}
}

pub fn ifblock_has_else(ifblk: &str) -> bool {
	return IFBLK_HAS_ELSE.lock().unwrap().contains_key(ifblk);
}

pub fn ifblock_set_else(ifblk: &str) {
	IFBLK_HAS_ELSE.lock().unwrap().insert(ifblk.to_string(), true);
}


pub fn loopblocks_push(loopblk: &str) {
	unsafe {
		LOOPBLK_LEVELS.push(loopblk.to_string());
	}
}

pub fn loopblocks_peek() -> Option<String> {
	unsafe {
		if LOOPBLK_LEVELS.len() == 0 {
			return None
		}
		let lastblk = LOOPBLK_LEVELS.pop().unwrap();
		LOOPBLK_LEVELS.push(lastblk.to_string());

		return Some(lastblk);
	}
}

pub fn loopblocks_pop() -> Option<String> {
	unsafe {
		if LOOPBLK_LEVELS.len() == 0 {
			return None
		}
		let lastblk = LOOPBLK_LEVELS.pop().unwrap();

		return Some(lastblk);
	}
}

pub fn arr8types_append(arr8type: &str) {
	unsafe {
		ARR8_TYPES.push(arr8type.to_string());
	}
}

pub fn arr8names_append(arr8type: &str) {
	unsafe {
		ARR8_NAMES.push(arr8type.to_string());
	}
}

pub fn arr8values_append(value: Vec<u8>) {
	unsafe {
		ARR8_VALUES.push(value);
	}
}

pub fn arr16types_append(arr16type: &str) {
	unsafe {
		ARR16_TYPES.push(arr16type.to_string());
	}
}

pub fn arr16names_append(arr16type: &str) {
	unsafe {
		ARR16_NAMES.push(arr16type.to_string());
	}
}

pub fn arr16values_append(value: Vec<u8>) {
	unsafe {
		ARR16_VALUES.push(value);
	}
}

pub fn vartypes_append(vartype: &str) {
	unsafe {
		VAR_TYPES.push(vartype.to_string());
	}
}

pub fn varnames_append(varname: &str) {
	unsafe {
		VAR_NAMES.push(varname.to_string());
	}
}

pub fn varvalues_append(value: Vec<u8>) {
	unsafe {
		VAR_VALUES.push(value);
	}
}

pub fn mainfn_append(ln: &str) {
	// println!("<main>{}", ln);
	unsafe {
		LINES_MAIN_FN.push(ln.to_string());
	}
}

pub fn builtin_append(ln: &str) {
	unsafe {
		LINES_BUILTIN_FNS.push(ln.to_string());
	}
}

fn write_platform_boilerplate(outfile: &mut File) {
	//------------------------------------------------------------------------//
	// Write out platform specific boilerplate lines.                         //
	//------------------------------------------------------------------------//
	unsafe {
		for ln in LINES_PLATFORM_BP.iter() {
			writeln!(outfile, "{}", ln).unwrap();
		}
	}
}

fn write_main_fn(outfile: &mut File) {
	//------------------------------------------------------------------------//
	// Write out the contents of the main function.                           //
	//------------------------------------------------------------------------//
	unsafe {
		LINES_MAIN_FN.insert(0, ";--------------------------------------------------------;".to_string());
		LINES_MAIN_FN.insert(1, "; MAIN FUNCTION                                          ;".to_string());
		LINES_MAIN_FN.insert(2, ";--------------------------------------------------------;".to_string());
		LINES_MAIN_FN.insert(3, "main: ".to_string());
		LINES_MAIN_FN.insert(4, "   ; set output mode to ISO".to_string());
		LINES_MAIN_FN.insert(5, "   lda #$0F".to_string());
		LINES_MAIN_FN.insert(6, "   jsr BSOUT".to_string());
		LINES_MAIN_FN.insert(7, "".to_string());

		LINES_MAIN_FN.push("   rts".to_string());
		LINES_MAIN_FN.push("".to_string());

		for ln in LINES_MAIN_FN.iter() {
			writeln!(outfile, "{}", ln).unwrap();
		}
	}
}

fn write_variable_defs(outfile: &mut File) {
	//------------------------------------------------------------------------//
	// Write out the contents of the variable definitions.                    //
	//------------------------------------------------------------------------//
	unsafe {
		if LINES_VARIABLE_DEFS.len() == 0 {
			LINES_VARIABLE_DEFS.push("".to_string());
		}

		LINES_VARIABLE_DEFS.insert(0, ";--------------------------------------------------------;".to_string());
		LINES_VARIABLE_DEFS.insert(1, "; VARIABLE DEFINITIONS                                   ;".to_string());
		LINES_VARIABLE_DEFS.insert(2, ";--------------------------------------------------------;".to_string());

		for ln in LINES_VARIABLE_DEFS.iter() {
			writeln!(outfile, "{}", ln).unwrap();
		}
	}
}

fn write_builtin_fns(mut outfile: &File) {
	//------------------------------------------------------------------------//
	// Write out the builtin (standard) functions.                            //
	//------------------------------------------------------------------------//
	unsafe {
		if LINES_BUILTIN_FNS.len() == 0 {
			LINES_BUILTIN_FNS.push("".to_string());
		}

		LINES_BUILTIN_FNS.insert(0, ";--------------------------------------------------------;".to_string());
		LINES_BUILTIN_FNS.insert(1, "; BUILT-IN FUNCTIONS                                     ;".to_string());
		LINES_BUILTIN_FNS.insert(2, ";--------------------------------------------------------;".to_string());

		for ln in LINES_BUILTIN_FNS.iter() {
			writeln!(&mut outfile, "{}", ln).unwrap();
		}
	}
}

pub fn write() -> bool {
	let outp_fname: String;
	unsafe {
		if OUTPUT_FILENAME.len() > 0 {
			outp_fname = OUTPUT_FILENAME.to_string();
		} else {
			println!("ERROR: OUTPUT_FILENAME not set before writing output");
			return true;
		}
	}
    let mut outfile = File::create(&outp_fname).unwrap();

	write_platform_boilerplate(&mut outfile);
	write_variable_defs(&mut outfile);
	write_builtin_fns(&mut outfile);
	write_main_fn(&mut outfile);

	return false;
}

fn process_vardefs() -> bool {
	let mut arr8ind: usize = 0;
	let mut arr16ind: usize = 0;
	let mut varind:  usize = 0;

	unsafe {
		//--------------------------------------------------------------------//
		// TODO: I want to sort the variable names when writing the output,   //
		// however it will cause problems if I don't do so carefully.         //
		//--------------------------------------------------------------------//
		// VAR_NAMES.sort();
		for varname in VAR_NAMES.iter() {
			let vartype = VAR_TYPES[varind].to_string();
			let varvals = &VAR_VALUES[varind];
			let varlen  = varvals.len();

			if vartype == "str8".to_string() {
				LINES_VARIABLE_DEFS.push(format!(
					"{}: ; type: {}", varname, vartype));
				LINES_VARIABLE_DEFS.push(format!(
					"   .byte ${:02X} ; length (u8)", varlen));
				LINES_VARIABLE_DEFS.push(format!(
					"   .byte ${:02X} ; alloc (u8)", varlen));
				LINES_VARIABLE_DEFS.push(format!(
					"   .byte ${:02X} ; element size (u8)", 1));
				LINES_VARIABLE_DEFS.push(
					"   ; data start".to_string());

				//------------------------------------------------------------//
				// Write out contents of the string ten bytes at a time.      //
				//------------------------------------------------------------//
				let mut bytectr: u8 = 0;
				let mut dataln: String = format!("   .byte ");
				for value in varvals {
					if bytectr > 9 {
						dataln = (dataln.trim_end_matches(",")).to_string();
						LINES_VARIABLE_DEFS.push(dataln);
						
						dataln = format!("   .byte ");
						bytectr = 0;
					}
					dataln = format!("{}${:02X},", dataln, value);
					bytectr += 1
				}
				if dataln != "   .byte ".to_string() {
					dataln = (dataln.trim_end_matches(",")).to_string();
					LINES_VARIABLE_DEFS.push(dataln);
				}

				LINES_VARIABLE_DEFS.push(format!(
					"   .byte ${:02X} ; null terminator (u8)", 0));
				LINES_VARIABLE_DEFS.push("".to_string());
			} else if vartype == "ptr".to_string() {
				LINES_VARIABLE_DEFS.push(format!(
					"{}: ; type: {}", varname, vartype));
				LINES_VARIABLE_DEFS.push(format!(
					"   .byte $00, $00"));
				LINES_VARIABLE_DEFS.push("".to_string());
			} else if vartype == "u8".to_string() {
				LINES_VARIABLE_DEFS.push(format!(
					"{}: ; type: {}", varname, vartype));
				LINES_VARIABLE_DEFS.push(format!(
					"   .byte ${:02X}", 0));
				LINES_VARIABLE_DEFS.push("".to_string());
			} else if vartype == "u16".to_string() {
				LINES_VARIABLE_DEFS.push(format!(
					"{}: ; type: {}", varname, vartype));
				LINES_VARIABLE_DEFS.push(format!(
					"   .byte $00, $00"));
				LINES_VARIABLE_DEFS.push("".to_string());
			} else if vartype == "file".to_string() {
				LINES_VARIABLE_DEFS.push(format!(
					"{}: ; type: {}", varname, vartype));
				LINES_VARIABLE_DEFS.push(format!(
					"   .byte $00 ; mode (u8)"));
				LINES_VARIABLE_DEFS.push(format!(
					"   .byte $00 ; device (u8)"));
				LINES_VARIABLE_DEFS.push(format!(
					"   .byte $00 ; channel (u8)"));
				LINES_VARIABLE_DEFS.push(format!(
					"   .byte $00 ; status (u8)"));
				LINES_VARIABLE_DEFS.push(format!(
					"   .byte $00, $00 ; fname (u16)"));
				LINES_VARIABLE_DEFS.push("".to_string());
			} else {
				println!("ERROR: Unhandled vardef output type `{vartype}`.");
				return true;
			}

			varind += 1;
		}

		//--------------------------------------------------------------------//
		// TODO: I want to sort the arr8 names when writing the output,       //
		// however it will cause problems if I don't do so carefully.         //
		//--------------------------------------------------------------------//
		// ARR8_NAMES.sort();
		for arr8name in ARR8_NAMES.iter() {
			let arr8type = ARR8_TYPES[arr8ind].to_string();
			let arr8vals = &ARR8_VALUES[arr8ind];
			let arr8len  = arr8vals.len();

			if arr8type == "u8".to_string() {
				LINES_VARIABLE_DEFS.push(format!(
					"{}: ; type: arr8__{}", arr8name, arr8type));
				LINES_VARIABLE_DEFS.push(format!(
					"   .byte ${:02X} ; length (u8)", arr8len));
				LINES_VARIABLE_DEFS.push(format!(
					"   .byte ${:02X} ; alloc (u8)", arr8len));
				LINES_VARIABLE_DEFS.push(format!(
					"   .byte ${:02X} ; element size (u8)", 1));
				LINES_VARIABLE_DEFS.push(
					"   ; data start".to_string());

				//------------------------------------------------------------//
				// Write out contents of the string ten bytes at a time.      //
				//------------------------------------------------------------//
				let mut bytectr: u8 = 0;
				let mut dataln: String = format!("   .byte ");
				for value in arr8vals {
					if bytectr > 9 {
						dataln = (dataln.trim_end_matches(",")).to_string();
						LINES_VARIABLE_DEFS.push(dataln);
						
						dataln = format!("   .byte ");
						bytectr = 0;
					}
					dataln = format!("{}${:02X},", dataln, value);
					bytectr += 1
				}
				if dataln != "   .byte ".to_string() {
					dataln = (dataln.trim_end_matches(",")).to_string();
					LINES_VARIABLE_DEFS.push(dataln);
				}
				LINES_VARIABLE_DEFS.push("".to_string());
			}

			arr8ind += 1;
		}

		//--------------------------------------------------------------------//
		// TODO: I want to sort the arr16 names when writing the output,      //
		// however it will cause problems if I don't do so carefully.         //
		//--------------------------------------------------------------------//
		// ARR16_NAMES.sort();
		for arr16name in ARR16_NAMES.iter() {
			let arr16type = ARR16_TYPES[arr16ind].to_string();
			let arr16vals = &ARR16_VALUES[arr16ind];
			let arr16len  = arr16vals.len();
			let arr16len_lo = arr16len & 0x00FF;
			let arr16len_hi = (arr16len & 0xFF00) >> 8;

			if arr16type == "u8".to_string() {
				LINES_VARIABLE_DEFS.push(format!(
					"{}: ; type: arr16__{}", arr16name, arr16type));
				LINES_VARIABLE_DEFS.push(format!(
					"   .byte ${:02X},${:02X} ; length (u16)",
					arr16len_lo, arr16len_hi));
				LINES_VARIABLE_DEFS.push(format!(
					"   .byte ${:02X},${:02X} ; alloc (u16)",
					arr16len_lo, arr16len_hi));
				LINES_VARIABLE_DEFS.push(format!(
					"   .byte ${:02X} ; element size (u8)", 1));
				LINES_VARIABLE_DEFS.push(
					"   ; data start".to_string());

				//------------------------------------------------------------//
				// Write out contents of the string ten bytes at a time.      //
				//------------------------------------------------------------//
				let mut bytectr: u8 = 0;
				let mut dataln: String = format!("   .byte ");
				for value in arr16vals {
					if bytectr > 9 {
						dataln = (dataln.trim_end_matches(",")).to_string();
						LINES_VARIABLE_DEFS.push(dataln);
						
						dataln = format!("   .byte ");
						bytectr = 0;
					}
					dataln = format!("{}${:02X},", dataln, value);
					bytectr += 1
				}
				if dataln != "   .byte ".to_string() {
					dataln = (dataln.trim_end_matches(",")).to_string();
					LINES_VARIABLE_DEFS.push(dataln);
				}
				LINES_VARIABLE_DEFS.push("".to_string());
			}

			arr16ind += 1;
		}
	}

	return false
}

pub fn process() -> bool {
	return process_vardefs();
}