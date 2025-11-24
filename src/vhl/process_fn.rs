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

    return false;
}
