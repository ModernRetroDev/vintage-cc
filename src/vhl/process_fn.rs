use crate::vhl::outputs;

use crate::vhl::line_part::LinePart;


fn get_fn_args(line: &str, ln_no: u64) -> Option<Vec<outputs::FnArg>> {
    let mut fn_args: Vec<outputs::FnArg> = Vec::new();

    let mut arg_ind:       u8     = 0;
    let mut first:         bool   = true;
    let mut next_arg_name: String = "".to_string();
    let mut next_arg_type: String = "".to_string();
    let mut capture:       String = "arg_name".to_string();
    let mut skip:   bool   = true;

    let trimmed = line.trim();

    for c in trimmed.chars() {
        if skip {
            if c == '(' {
                skip = false;
            }
            continue;
        }
        // else:
        if first {
            if c == ' ' || c == '\t' {
                continue;
            }
            // else
            first = false;
        }

        if capture == "arg_name" {
            if c == ':' {
                if next_arg_name == "" {
                    println!(
                        "ERROR: ln:{} Function argument provided with no name.",
                        ln_no);
                    return None;
                }
                // else
                capture       = "arg_type".to_string();
                next_arg_type = "".to_string();
                first         = true;
            } else {
                next_arg_name.push(c);
            }
        } else if capture == "arg_type" {
            if c == ',' {
                if next_arg_type == "" {
                    println!(
                        "ERROR: ln:{} Function argument provided with no type.",
                        ln_no);
                    return None;
                }
                // else
                fn_args.push(outputs::new_fn_arg(
                    arg_ind, &next_arg_name, &next_arg_type));
                arg_ind += 1;
                capture       = "arg_name".to_string();
                next_arg_name = "".to_string();
                first         = true;
            } else if c == ')' {
                if next_arg_type == "" {
                    println!(
                        "ERROR: ln:{} Function argument provided with no type.",
                        ln_no);
                    return None;
                }
                // else
                fn_args.push(outputs::new_fn_arg(
                    arg_ind, &next_arg_name, &next_arg_type));
                break;
            } else {
                next_arg_type.push(c);
            }
        }
    }

    return Some(fn_args);
}

fn get_fn_returns(line: &str, ln_no: u64) -> Option<Vec<outputs::FnArg>> {
    let mut fn_rets: Vec<outputs::FnArg> = Vec::new();
    let mut arg_ind:       u8     = 0;
    let mut multi:         bool   = false;
    let mut first:         bool   = true;
    let mut next_arg_type: String = "".to_string();
    let mut capture:       String = "arrow".to_string();
    let mut skip:          bool   = true;

    let trimmed = line.trim();

    for c in trimmed.chars() {
        if skip {
            if c == ')' {
                skip = false;
            }
            continue;
        }
        // else:
        if first {
            if c == ' ' || c == '\t' {
                continue;
            } else if c == '{' {
                return Some(fn_rets);
            }
            // else
            first = false;
        }

        if capture == "arrow" {
            if c != '-' {
                println!(
                    "ERROR: ln:{} Function return start after `->`; got `{}`.",
                    ln_no, c);
                return None;
            }
            capture = "arrow2".to_string();
            continue;
        } else if capture == "arrow2" {
            if c != '>' {
                println!(
                    "ERROR: ln:{} Function return start after `->`; got `-{}`.",
                    ln_no, c);
                return None;
            }
            capture = "arg_type".to_string();
            first = true;
            continue;
        } else if capture == "arg_type" {
            if c == ' ' || c == '\t' {
                if next_arg_type == "" {
                    // leading whitespace
                    continue;
                } else if !multi {
                    // end of a single return type
                    fn_rets.push(outputs::new_fn_arg(
                        arg_ind, &format!("_ret_{}", arg_ind), &next_arg_type));
                    capture = "open_curly".to_string();
                    first   = true;
                    continue;
                } else {
                    println!(
                        "ERROR: ln:{} FN: Multi-return values must be separated by a `,` between each value.",
                        ln_no);
                    return None;
                }
            } else if c == '(' {
                multi = true;
                if next_arg_type != "" {
                    println!(
                        "ERROR: ln:{} FN: For multi-return values; the `(` must occur first.",
                        ln_no);
                    return None;
                }
                continue;
            } else if c == ',' {
                if !multi {
                    println!(
                        "ERROR: ln:{} FN: Unexpected comma; multi-return values start with a `(`.",
                        ln_no);
                    return None;
                } else if next_arg_type == "" {
                    println!(
                        "ERROR: ln:{} FN: Empty/blank argument type provided.",
                        ln_no);
                    return None;
                } else {
                    // this should be a fine variable type
                    fn_rets.push(outputs::new_fn_arg(
                        arg_ind, &format!("_ret_{}", arg_ind), &next_arg_type));
                    arg_ind += 1;
                    next_arg_type = "".to_string();
                    first         = true;
                }
            } else if c == ')' {
                if !multi {
                    println!(
                        "ERROR: ln:{} FN: Unexpected `)`; only used for multi-return values.",
                        ln_no);
                    return None;
                } else if next_arg_type == "" {
                    println!(
                        "ERROR: ln:{} FN: Empty/blank argument type provided.",
                        ln_no);
                    return None;
                } else {
                    // the final type of a multi-return function
                    fn_rets.push(outputs::new_fn_arg(
                        arg_ind, &format!("_ret_{}", arg_ind), &next_arg_type));
                    capture = "open_curly".to_string();
                    first   = true;
                    continue;
                }
            } else {
                next_arg_type.push(c);
            }
        } else if capture == "open_curly" {
            if c != '{' {
                println!(
                    "ERROR: ln:{} FN: Expected `{{`; got `{}`.",
                    ln_no, c);
                return None;
            }
            break;
        }
    }

    return Some(fn_rets);
}

pub fn now(part: LinePart, line: &str) -> bool {
    let fn_name: String;
    let fn_name_raw = part.get_next().next;

    match fn_name_raw.find("(") {
        Some(index) => {
            fn_name = (fn_name_raw[0..index]).to_string();
        },
        None => {
            return true
        }
    }

    outputs::set_active_fn(&fn_name);
    outputs::blktypes_push("fn");

    match get_fn_args(line, part.ln_no) {
        Some(fn_args) => {
            for fn_arg in &fn_args {
                // fn_arg.show();
                match &fn_arg.arg_type[..] {
                    "u8" => {
                        outputs::lines_vardecl_push(&format!(
                            "    var__u8 _arg_{}__{}",
                            fn_arg.arg_pos, fn_arg.arg_name));
                    },
                    "u16" => {
                        outputs::lines_vardecl_push(&format!(
                            "    var__u16 _arg_{}__{}",
                            fn_arg.arg_pos, fn_arg.arg_name));
                    },
                    "u24" => {
                        outputs::lines_vardecl_push(&format!(
                            "    var__u24 _arg_{}__{}",
                            fn_arg.arg_pos, fn_arg.arg_name));
                    },
                    "file" => {
                        outputs::lines_vardecl_push(&format!(
                            "    ptr__file _arg_{}__{}",
                            fn_arg.arg_pos, fn_arg.arg_name));
                    },
                    "str" => {
                        outputs::lines_vardecl_push(&format!(
                            "    ptr__str _arg_{}__{}",
                            fn_arg.arg_pos, fn_arg.arg_name));
                    },
                    _ => {
                        println!(
                            "ERROR: ln:{} Unhandled vartype `{}` as fn argument.",
                            part.ln_no, fn_arg.arg_type);
                        return true;            
                    }
                }
            }

            outputs::set_fn_args_in_active_fn(fn_args);
        },
        None => { return true; }
    }

    match get_fn_returns(line, part.ln_no) {
        Some(fn_returns) => {
            for ret_arg in &fn_returns {
                // ret_arg.show();
                match &ret_arg.arg_type[..] {
                    "u8" => {
                        outputs::lines_vardecl_push(&format!(
                            "    var__u8 _ret_{}",
                            ret_arg.arg_pos));
                    },
                    "u16" => {
                        outputs::lines_vardecl_push(&format!(
                            "    var__u16 _ret_{}",
                            ret_arg.arg_pos));
                    },
                    "u24" => {
                        outputs::lines_vardecl_push(&format!(
                            "    var__u24 _ret_{}",
                            ret_arg.arg_pos));
                    },
                    "file" => {
                        outputs::lines_vardecl_push(&format!(
                            "    ptr__file _ret_{}",
                            ret_arg.arg_pos));
                    },
                    "str" => {
                        outputs::lines_vardecl_push(&format!(
                            "    ptr__str _ret_{}",
                            ret_arg.arg_pos));
                    },
                    _ => {
                        println!(
                            "ERROR: ln:{} Unhandled vartype `{}` as fn argument.",
                            part.ln_no, ret_arg.arg_type);
                        return true;            
                    }
                }
            }

            outputs::set_fn_returns_in_active_fn(fn_returns);
        },
        None => { return true; }
    }

    return false;
}
