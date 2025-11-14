use crate::vhl::outputs;

#[derive(Clone)]
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

    pub fn is__asm(&self) -> bool {
        if self.next.starts_with("_asm(") {
            return true
        }
        return false
    }

    pub fn is_break(&self) -> bool {
        if self.next == "break" {
            return true
        } else if self.next == "break;" {
            return true
        }
        return false
    }
    pub fn is_continue(&self) -> bool {
        if self.next == "continue" {
            return true
        } else if self.next == "continue;" {
            return true
        }
        return false
    }
    pub fn is_endblk(&self) -> bool {
        if self.next == "}" {
            return true
        }
        return false
    }
    pub fn is_file_method(&self) -> bool {
        let varname: String;
        if self.next.contains(".") {
            let dot_ind: usize = self.next.find('.').unwrap();
            varname = self.next[..dot_ind].to_string();

            match outputs::get_vartype(&varname) {
                Some(vartype) => {
                    // println!("vartype is `{}`", vartype);
                    if vartype == "file" {
                        // println!("varname = `{}`; IS FILE!", varname);
                        return true;
                    }
                },
                None => {}

            }

            println!("varname = `{}`", varname);
        }
        return false
    }
    pub fn is_fn(&self) -> bool {
        if self.next == "fn" {
            return true
        }
        return false
    }
    pub fn is_for(&self) -> bool {
        if self.next == "for" {
            return true
        }
        return false
    }
    pub fn is_if_rpn(&self) -> bool {
        if self.next == "if" {
            return true
        }
        return false
    }
    pub fn is_let(&self) -> bool {
        if self.next == "let" {
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
    pub fn is_println(&self) -> bool {
        if self.next.starts_with("println(") {
            return true
        }
        return false
    }
    pub fn is_return(&self) -> bool {
        if self.next == "return" || self.next == "return;" {
            return true
        }
        return false
    }
    pub fn is_while(&self) -> bool {
        if self.next == "while" {
            return true
        }
        return false
    }
    pub fn is_fn_call(&self) -> bool {
        let mut first_part: String = "".to_string();
        let mut first_char: bool   = false;

        for c in self.next.chars() {
            if first_char {
                if !c.is_ascii_alphabetic() {
                    return false;
                }
                first_part.push(c);
                first_char = false;
                continue;
            }
            // else
            if c.is_ascii_alphabetic() || c.is_ascii_digit() || c == '_' {
                first_part.push(c);
                continue;
            }
            // else
            if c == '(' {
                first_part.push(c);
                return true;
            } else {
                return false;
            }
        }
        return false
    }
}
