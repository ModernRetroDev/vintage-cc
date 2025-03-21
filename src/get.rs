use crate::outputs;

static mut UNIQUE_EVAL_CTR:    u32 = 0;
static mut UNIQUE_IFBLK_CTR:   u32 = 0;
static mut UNIQUE_LOOPBLK_CTR: u32 = 0;
static mut UNIQUE_STR8_CTR:    u32 = 0;


pub fn arr8_fullname(v: &str) -> String {
	return format!("arr8__{}__{}", 
		outputs::get_active_fn(), 
		v.trim_start_matches("."));
}

pub fn arr16_fullname(v: &str) -> String {
	return format!("arr16__{}__{}", 
		outputs::get_active_fn(), 
		v.trim_start_matches("."));
}

pub fn var_fullname(v: &str) -> String {
	return format!("var__{}__{}", 
		outputs::get_active_fn(), 
		v.trim_start_matches("."));
}

pub fn unique_eval_label() -> String {
	let eval_no: u32;

	unsafe {
		eval_no = UNIQUE_EVAL_CTR;
		UNIQUE_EVAL_CTR += 1;
	}

	return format!("eval_0x{:04X}", eval_no);
}

pub fn unique_str8_varname() -> String {
	let str8_no: u32;

	unsafe {
		str8_no = UNIQUE_STR8_CTR;
		UNIQUE_STR8_CTR += 1;
	}

	return format!("str8_0x{:04X}", str8_no);
}

pub fn unique_ifblk_name() -> String {
	let ifblk_no: u32;

	unsafe {
		ifblk_no = UNIQUE_IFBLK_CTR;
		UNIQUE_IFBLK_CTR += 1;
	}

	return format!("if_0x{:04X}", ifblk_no);
}


pub fn unique_loopblk_name() -> String {
	let loopblk_no: u32;

	unsafe {
		loopblk_no = UNIQUE_LOOPBLK_CTR;
		UNIQUE_LOOPBLK_CTR += 1;
	}

	return format!("loop_0x{:04X}", loopblk_no);
}

