use crate::vhl::outputs;

use crate::vhl::line_part::LinePart;
use crate::vhl::process_println;


fn get_string_arg(line: &str, _ln_no: u64, start: usize) -> Option<String> {
    let mut escaped:    bool   = false;
    let mut expect_var: bool   = false;
    let mut is_first:   bool   = true;
    let mut str_arg:    String = "".to_string();

    for c in line[start..].chars() {
        if is_first {
            if c != '"' {
                expect_var = true;
                break;
            }
            str_arg.push(c);
            is_first = false;
            continue;
        }
        if escaped {
            str_arg.push('\\');
            str_arg.push(c);
            escaped = false;
            continue;
        }

        if c == '\\' {
            escaped = true;
            continue;
        } else if c == '"' {
            str_arg.push(c);
            return Some(str_arg);
        } else {
            str_arg.push(c);
        }
    }

    if expect_var {
        for c in line[start..].chars() {
            let var_stop: bool;
            match c {
                ' '  => { var_stop = true; },
                ','  => { var_stop = true; },
                ')'  => { var_stop = true; },
                '\t' => { var_stop = true; },
                _    => { var_stop = false },
            }
            if var_stop {
                return Some(str_arg);
            }

            if escaped {
                str_arg.push('\\');
                str_arg.push(c);
                escaped = false;
                continue;
            }

            if c == '\\' {
                escaped = true;
                continue;
            } else if c == '"' {
                str_arg.push(c);
                return Some(str_arg);
            } else {
                str_arg.push(c);
            }
        }
    }

    return None
}

fn get_variable_name(part: &LinePart) -> Option<String> {
    let varname: String;

    if part.next.contains(".") {
        let dot_ind: usize = part.next.find('.').unwrap();
        varname = part.next[..dot_ind].to_string();

        return Some(varname);
    }
    return None;
}

fn get_method_name(part: &LinePart) -> Option<String> {
    let method_name: String;
    if part.next.contains(".") {
        let dot_ind:   usize = part.next.find('.').unwrap();
        let paren_ind: usize = part.next.find('(').unwrap();
        method_name = part.next[dot_ind+1..paren_ind].to_string();

        return Some(method_name);
    }
    return None;
}

pub fn now(part: LinePart, line: &str) -> bool {
    let varname: String;
    let methname: String;

    match get_variable_name(&part) {
        Some(vname) => {
            varname = vname.clone();
        },
        None => {
            println!(
                "ERROR: ln:{} Unable to get variable name from method call.",
                part.ln_no);
            return true;
        }
    }

    match get_method_name(&part) {
        Some(mname) => {
            methname = mname.clone();
        },
        None => {
            println!(
                "ERROR: ln:{} Unable to get method name from method call.",
                part.ln_no);
            return true;
        }
    }

    let methname_str = &methname[..];
    match methname_str {
        "close" => {
            outputs::lines_main_push(
                &format!("    close__file .{}", varname));
        },
        "create" => {
            let all_text: String = format!("{}{}", part.next, part.rem);
            let paren_ind: usize = all_text.find('(').unwrap();
            let fname_arg: String;

            match get_string_arg(&all_text, part.ln_no, paren_ind+1) {
                Some(str_arg) => {
                    fname_arg = str_arg.clone();
                },
                None => {
                    println!(
                        "ERROR: ln:{} Failed to get leading string argument.",
                        part.ln_no);
                    return true;
                }
            }

            if fname_arg.starts_with("\"") {
                outputs::lines_main_push(&format!("    # {}", line.trim()));
                match &outputs::get_platform()[..] {
                    "c64" => {
                        let fname_len = fname_arg.len();
                        outputs::lines_main_push(
                            &format!("    setup__file .{} 'w' \"@0:{},S,W\"", 
                                varname, &fname_arg[1..fname_len-1]));
                    },
                    "f256k" => {
                        outputs::lines_main_push(
                            &format!("    setup__file .{} 'w' \"{}", 
                                varname, &fname_arg[1..]));
                    },
                    "x16" => {
                        outputs::lines_main_push(
                            &format!("    setup__file .{} 'w' \"@:{}", 
                                varname, &fname_arg[1..]));
                    },
                    _ => {
                        println!(
                            "ERROR: ln:{} Unsupported platform.",
                            part.ln_no);
                        return true;
                    }
                }
                outputs::lines_main_push(
                    &format!("    open__file .{}", varname));
                outputs::lines_main_push("");
            } else {
                println!(
                    "TODO: ln:{} file.{}() Load file from string argument.",
                    part.ln_no, methname_str);
                return true;
            }
        },
        "writeln" => {
            return process_println::now(part, line, Some("writeln".to_string()));
        },
        _ => {
            println!(
                "ERROR: ln:{} Unsupported method `{}` for type file.",
                part.ln_no, methname_str);
            return true;
        }
    }

    return false
}
