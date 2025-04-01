pub struct LinePart {
	pub ln_no: u64,    // number of line containing the part
	pub next:  String, // next part of a line
	pub rem:   String, // remainder of the line
}

impl LinePart {
	pub fn get_next(&self) -> LinePart {
		let mut next:    String = "".to_string();
		let mut rem:     String = "".to_string();
		let mut first:   bool   = true;
		let mut leading: bool   = true;
		let     part:    LinePart;

		let trimmed = self.rem.trim();
		let ln_no   = self.ln_no;

		for c in trimmed.chars() {
			if first {
				// read in first word of line; stop on whitespace
				if c == ' ' || c == '\t' {
					first = false;
					continue;
				}
				next = format!("{}{}", next, c);
			} else if leading {
				// skip over whitespace between next and remainder
				if c == ' ' || c == '\t' {
					continue;
				}
				rem = format!("{}", c);
				leading = false
			} else {
				rem = format!("{}{}", rem, c);
			}
		}

		part = LinePart{ln_no, next, rem};
		return part
	}

	fn get_char_part_len(&self) -> usize {
		let mut index:    usize = 0;
		let mut escaped:  bool = false;

		let trimmed = self.rem.trim();

		for c in trimmed.bytes() {
			match index {
				0 => {
					if c != b'\'' {
						return 0;
					}
				},
				1 => {
					if c == b'\\' {
						escaped = true;
					}
				},
				2 => {
					if !escaped {
						if c != b'\'' {
							return 0;
						}
						// else: char was valid
						break;
					}
				},
				3 => {
					if c != b'\'' {
						return 0;
					}
					// else: char was valid
					break;
				}
				_ => {
					break;
				}
			}
			index += 1;
		}

		return index
	}

	pub fn get_next_after_char(&self) -> LinePart {
		let mut next:    String = "".to_string();
		let mut rem:     String = "".to_string();
		let mut first:   bool   = true;
		let mut leading: bool   = true;
		let     part:    LinePart;

		let skiplen: usize = self.get_char_part_len();
		let rem_after_char: &_ = &self.rem[skiplen..];

		let trimmed = rem_after_char.trim();
		let ln_no   = self.ln_no;

		for c in trimmed.chars() {
			if first {
				// read in first word of line; stop on whitespace
				if c == ' ' || c == '\t' {
					first = false;
					continue;
				}
				next = format!("{}{}", next, c);
			} else if leading {
				// skip over whitespace between next and remainder
				if c == ' ' || c == '\t' {
					continue;
				}
				rem = format!("{}", c);
				leading = false
			} else {
				rem = format!("{}{}", rem, c);
			}
		}

		part = LinePart{ln_no, next, rem};
		return part
	}

	pub fn get_next_char(&self) -> Option<u8> {
		let mut index:    u8 = 0;
		let mut nextchar: u8 = 0;
		let mut escaped:  bool = false;

		let trimmed = self.rem.trim();

		for c in trimmed.bytes() {
			match index {
				0 => {
					if c != b'\'' {
						return None;
					}
				},
				1 => {
					if c != b'\\' {
						nextchar = c;
					} else {
						escaped = true;
					}
				},
				2 => {
					if escaped {
						nextchar = c;
					} else {
						if c != b'\'' {
							return None;
						}
						// else: char was valid
						break;
					}
				},
				3 => {
					if c != b'\'' {
						return None;
					}
					// else: char was valid
					break;
				}
				_ => {
					break;
				}
			}
			index += 1;
		}

		return Some(nextchar)
	}

	pub fn get_next_str(&self) -> Option<LinePart> {
		let mut next:   String = "".to_string();
		let mut rem:    String = "".to_string();
		let mut first:  bool   = true;
		let mut in_str: bool   = true;
		let     part:   LinePart;

		let trimmed = self.rem.trim();
		let ln_no   = self.ln_no;

		for c in trimmed.chars() {
			if first {
				// make sure the string starts with a double quote mark.
				if c != '"' {
					return None;
				}
				first = false;
				in_str = true;
				next = format!("{}{}", next, c);
			} else if in_str {
				// continue reading till the second double quote mark.
				next = format!("{}{}", next, c);
				if c == '"' {
					in_str = false;
					continue;
				}
			} else {
				rem = format!("{}{}", rem, c);
			}
		}

		part = LinePart{ln_no, next, rem};
		return Some(part)
	}

	pub fn is_arr8(&self) -> bool {
		if self.next.starts_with("arr8__") {
			return true
		}
		return false
	}
	pub fn is_arr16(&self) -> bool {
		if self.next.starts_with("arr16__") {
			return true
		}
		return false
	}
	pub fn is_break(&self) -> bool {
		if self.next == "break" {
			return true
		}
		return false
	}
	pub fn is_close(&self) -> bool {
		if self.next.starts_with("close__") {
			return true
		}
		return false
	}
	pub fn is_else(&self) -> bool {
		if self.next == "else" {
			return true
		}
		return false
	}
	pub fn is_endfn(&self) -> bool {
		if self.next == "endfn" {
			return true
		}
		return false
	}
	pub fn is_endif(&self) -> bool {
		if self.next == "endif" {
			return true
		}
		return false
	}
	pub fn is_endloop(&self) -> bool {
		if self.next == "endloop" {
			return true
		}
		return false
	}
	pub fn is_eval_eq(&self) -> bool {
		if self.next.starts_with("eval_eq__") {
			return true
		}
		return false
	}
	pub fn is_eval_neq(&self) -> bool {
		if self.next.starts_with("eval_neq__") {
			return true
		}
		return false
	}
	pub fn is_eval_lt(&self) -> bool {
		if self.next.starts_with("eval_lt__") {
			return true
		}
		return false
	}
	pub fn is_eval_lteq(&self) -> bool {
		if self.next.starts_with("eval_lteq__") {
			return true
		}
		return false
	}
	pub fn is_eval_gt(&self) -> bool {
		if self.next.starts_with("eval_gt__") {
			return true
		}
		return false
	}
	pub fn is_eval_gteq(&self) -> bool {
		if self.next.starts_with("eval_gteq__") {
			return true
		}
		return false
	}
	pub fn is_equals(&self) -> bool {
		if self.next.starts_with("equals__") {
			return true
		}
		return false
	}
	pub fn is_fn(&self) -> bool {
		if self.next == "fn" {
			return true
		}
		return false
	}
	pub fn is_if(&self) -> bool {
		if self.next == "if" {
			return true
		}
		return false
	}
	pub fn is_increment(&self) -> bool {
		if self.next.starts_with("increment__") {
			return true
		}
		return false
	}
	pub fn is_load(&self) -> bool {
		if self.next.starts_with("load__") {
			return true
		}
		return false
	}
	pub fn is_loop(&self) -> bool {
		if self.next == "loop" {
			return true
		}
		return false
	}
	pub fn is_lshift(&self) -> bool {
		if self.next.starts_with("lshift__") {
			return true
		}
		return false
	}
	pub fn is_minus_equals(&self) -> bool {
		if self.next.starts_with("minus_equals__") {
			return true
		}
		return false
	}
	pub fn is_open(&self) -> bool {
		if self.next.starts_with("open__") {
			return true
		}
		return false
	}
	pub fn is_plus_equals(&self) -> bool {
		if self.next.starts_with("plus_equals__") {
			return true
		}
		return false
	}
	pub fn is_print(&self) -> bool {
		if self.next.starts_with("print__") {
			return true
		}
		return false
	}
	pub fn is_ref(&self) -> bool {
		if self.next.starts_with("ref__") {
			return true
		}
		return false
	}
	pub fn is_rshift(&self) -> bool {
		if self.next.starts_with("rshift__") {
			return true
		}
		return false
	}
	pub fn is_setout(&self) -> bool {
		if self.next.starts_with("setout__") {
			return true
		}
		return false
	}
	pub fn is_setup(&self) -> bool {
		if self.next.starts_with("setup__") {
			return true
		}
		return false
	}
	pub fn is_shutdown(&self) -> bool {
		if self.next == "shutdown" {
			return true
		}
		return false
	}
	pub fn is_store(&self) -> bool {
		if self.next.starts_with("store__") {
			return true
		}
		return false
	}
	pub fn is_var(&self) -> bool {
		if self.next.starts_with("var__") {
			return true
		}
		return false
	}

	pub fn is_varname(&self) -> bool {
		if self.next.starts_with(".") && self.next.len() > 1{
			return true
		}
		return false
	}
}
