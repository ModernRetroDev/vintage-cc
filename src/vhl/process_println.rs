use crate::vhl::array;
use crate::vhl::fn_args;
use crate::vhl::outputs;

use crate::vhl::line_part::LinePart;

fn as_type_newline(altmode: &Option<String>) -> bool {
    outputs::lines_main_push("    print__endl");
    match altmode {
        Some(amode) => {
            if amode == "writeln" {
                outputs::lines_main_push("    setout__default");
            }
        },
        None => {},
    }
    outputs::lines_main_push("");

    return false;
}

// fn as_type_char(part: LinePart) -> bool {
//  let value      = part.get_next().next;
//  let value_part = part.get_next();
//  let resolved: String;

//  builtins::mark_as_used(&part.next);

//  if value_part.is_varname() {
//      resolved = get::var_fullname(&value);
//  } else {
//      let achar = part.get_next_char();
//      match achar {
//          Some(achar) => {
//              resolved = format!("#${:02X}", achar);
//          },
//          None => {
//              println!("ERROR: malformed char on LN {}", part.ln_no);
//              return true;
//          }
//      }
//  }

//  outputs::lines_main_push(&format!("   ; print__char {}", value));
//  outputs::lines_main_push(&format!("   lda {}", resolved));
//  outputs::lines_main_push(         "   jsr _print__char");
//  outputs::lines_main_push("");

//  return false;
// }

fn as_type_bool(bool_arg: &str) -> bool {
    outputs::lines_main_push(&format!("    print__bool {}", bool_arg));

    return false;
}

fn as_type_file(file_arg: &str) -> bool {
    outputs::lines_main_push(&format!("    print__file {}", file_arg));

    return false;
}

fn as_type_u8(u8_arg: &str) -> bool {
    outputs::lines_main_push(&format!("    print__u8 {}", u8_arg));

    return false;
}

fn as_type_u16(u16_arg: &str) -> bool {
    outputs::lines_main_push(&format!("    print__u16 {}", u16_arg));

    return false;
}

fn as_type_str8(str8_arg: &str) -> bool {
    if str8_arg.starts_with("\"") {
        outputs::lines_main_push(&format!("    print__str8 {}", str8_arg));
    } else {
        outputs::lines_main_push(&format!("    print__str8 {}", str8_arg));
    }

    return false;
}

fn wrapup_call(incl_endl: bool, altmode: &Option<String>) {
    if incl_endl {
        outputs::lines_main_push("    print__endl");
    }    
    match altmode {
        Some(amode) => {
            if amode == "writeln" {
                outputs::lines_main_push("    setout__default");
            }
        },
        None => {},
    }
    outputs::lines_main_push("");
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

// fn as_type_u8_x(part: LinePart) -> bool {
//  let value      = part.get_next().next;
//  let value_part = part.get_next();
//  let resolved: String;

//  builtins::mark_as_used(&part.next);

//  if value_part.is_varname() {
//      resolved = get::var_fullname(&value);
//  } else {
//      resolved = format!("#{}", value);
//  }

//  outputs::lines_main_push(&format!("   ; print__u8_x {}", value));
//  outputs::lines_main_push(&format!("   lda {}", resolved));
//  outputs::lines_main_push(         "   jsr _print__u8_x");
//  outputs::lines_main_push("");

//  return false;
// }

// fn as_type_u8_xx(part: LinePart) -> bool {
//  let value      = part.get_next().next;
//  let value_part = part.get_next();
//  let resolved: String;

//  builtins::mark_as_used(&part.next);

//  if value_part.is_varname() {
//      resolved = get::var_fullname(&value);
//  } else {
//      resolved = format!("#{}", value);
//  }

//  outputs::lines_main_push(&format!("   ; print__u8_X {}", value));
//  outputs::lines_main_push(&format!("   lda {}", resolved));
//  outputs::lines_main_push(         "   jsr _print__u8_xx");
//  outputs::lines_main_push("");

//  return false;
// }

// fn as_type_u16_x(part: LinePart) -> bool {
//  let value      = part.get_next().next;
//  let value_part = part.get_next();
//  let resolved: String;

//  builtins::mark_as_used(&part.next);

//  if value_part.is_varname() {
//      resolved = get::var_fullname(&value);
//  } else {
//      println!("ERROR/TODO: Non variable U16 print on LN {}", part.ln_no);
//      return true;
//  }

//  outputs::lines_main_push(&format!("   ; print__u16_x {}", value));
//  outputs::lines_main_push(&format!("   ldx {resolved}"));
//  outputs::lines_main_push(&format!("   ldy {resolved}+1"));
//  outputs::lines_main_push(         "   jsr _print__u16_x");
//  outputs::lines_main_push("");

//  return false;
// }

fn resolve_supplied_arg(ln_no: u64, supplied: &str) -> Option<String> {
    let resolved_arg: String;

    if array::arg_is_array(&supplied) {
        match array::get_value(ln_no, &supplied) {
            Some(temp_var) => {
                resolved_arg = format!(".{}", temp_var);
            },
            None => { return None },
        }
    } else if outputs::varname_is_fn_arg_in_active_fn(supplied) {
        resolved_arg = format!(".{}",
            outputs::get_fn_arg_varname_in_active_fn(supplied));
    } else if outputs::get_vartype(supplied).is_some() {
        resolved_arg = format!(".{}", supplied);
    } else {
        resolved_arg = supplied.to_string();
    }

    return Some(resolved_arg);
}

fn get_supplied_basetype(ln_no: u64, supplied: &str) -> Option<String> {
    let mut basetype: String = "".to_string();

    if array::arg_is_array(supplied) {
        match array::get_arraytype_basetype(ln_no, supplied) {
            Some(btype) => {
                basetype = btype.clone();
            },
            None => {},
        }
    } else if outputs::varname_is_fn_arg_in_active_fn(supplied) {
        basetype = outputs::get_fn_arg_type_by_name(
            &outputs::get_active_fn(), supplied).unwrap().clone();
    } else {
        match outputs::get_vartype(supplied) {
            Some(vtype) => {
                basetype = vtype.clone();
            },
            None => {},
        }
    }

    if basetype != "" {
        return Some(basetype);
    }

    if supplied.parse::<u8>().is_ok() {
        return Some("u8".to_string());
    } else if supplied.parse::<u16>().is_ok() {
        return Some("u16".to_string());
    }

    return None;
}

fn load_print_groups(
    grps: &mut Vec<String>, 
    resume: &mut usize, 
    part: &LinePart, 
    line: &str, 
    altmode: &Option<String>)
-> bool {
    //
    let     fn_args;
    let     search:   String;
    let mut is_first: bool = true;
    let mut lbracket: bool = false;
    let mut rbracket: bool = false;
    let mut escaped:  bool = false;
    let mut grp_next: String = "".to_string();
    let mut start_at: usize;

    match altmode {
        Some(amode) => {
            if amode == "writeln" {
                if part.next.ends_with(".writeln();") {
                    return false;
                }
            }
            search = ".writeln(".to_string();
        },
        None => {
            if part.next == "println();" {
                return false;
            }
            search = "println(".to_string();
        }
    }

    match line.find(&search) {
        Some(index) => {
            let start = index + search.len();
            start_at = start;
            fn_args = (line[start..]).to_string();
        },
        None => {
            println!("Skipping!!!");
            return true;
        }
    }

    for c in fn_args.chars() {
        start_at += 1;
        if is_first {
            if c != '"' {
                println!(
                    "ERROR: ln:{} First arg of println must be format string literal.",
                    part.ln_no);
                return true;
            } else {
                is_first = false;
            }
            continue;
        }
        if lbracket {
            if c == '{' {
                if grp_next.len() == 0 {
                    grp_next.push('@');
                }
                grp_next.push('{');
                lbracket = false;
                continue;
            } else {
                if grp_next.len() == 0 {
                    grp_next = "$".to_string();
                } else {
                    grps.push(grp_next.clone());
                    grp_next = "$".to_string();
                }
                lbracket = false;
            }
        }
        if rbracket {
            if grp_next.starts_with("$") {
                grps.push(grp_next.clone());
                grp_next = "".to_string();
                rbracket = false;
                // falls through to normal handling now...
            }
            else if c == '}' {
                if grp_next.len() == 0 {
                    grp_next.push('@');
                }
                grp_next.push('}');
                rbracket = false;
                continue;
            }
        }
        if escaped {
            if grp_next.len() == 0 {
                grp_next.push('@');
            }
            grp_next.push('\\');
            grp_next.push(c);
            escaped = false;
            continue;
        }

        if c == '{' {
            lbracket = true;
            continue;
        } else if c == '}' {
            rbracket = true;
            continue;
        } else if c == '\\' {
            escaped = true;
            continue;
        } else if c == '"' {
            if grp_next.len() > 0 {
                grps.push(grp_next.clone());
            }
            break;
        } else {
            if grp_next.len() == 0 {
                grp_next.push('@');
            }
            grp_next.push(c);
        }
    }

    *resume = start_at;
    return false
}

fn load_follow_args(
    fargs: &mut Vec<String>, 
    part: &LinePart, 
    line: &str,
    resume: usize,
    _altmode: &Option<String>)
-> bool {
    let fn_args: String = (line[resume..]).to_string();
    let mut first: bool = true;
    // let mut expect_another: bool = false;
    let mut close_fn: bool = false;
    let mut in_arg: bool = false;
    let mut arg_next: String = "".to_string();

    for c in fn_args.chars() {
        if first {
            if c == ' ' {
                continue;
            } else if c == ',' {
                // expect_another = true;
                first = false;
                continue;
            } else if c == ')' {
                close_fn = true;
                first = false;
                continue;
            }
        }
        if close_fn {
            if c == ' ' {
                continue;
            } else if c == ';' {
                break;
            } else {
                println!(
                    "ERROR: ln:{} Function call is missing a trailing semicolon.",
                    part.ln_no);
                return true;
            }
        }

        if in_arg {
            // capturing chars for an arg...
            if c == ' ' {
                // skip over ws within args
                continue;
            } else if c == ')' {
                fargs.push(arg_next.clone());
                arg_next = "".to_string();
                close_fn = true;
            } else if c == ',' {
                fargs.push(arg_next.clone());
                arg_next = "".to_string();
                // expect_another = true;
            } else if c == ';' {
                println!(
                    "ERROR: ln:{} Unexpected semicolon within arg.",
                    part.ln_no);
                return true;
            } else {
                arg_next.push(c);
            }

        } else {
            // waiting for an arg to start
            if c == ' ' {
                // skip over ws between args
                continue;
            } else if c == ')' {
                println!(
                    "ERROR: ln:{} Expected another arg; got `{}` instead.",
                    part.ln_no, c);
                return true;
            } else if c == ',' {
                println!(
                    "ERROR: ln:{} Expected another arg; got `{}` instead.",
                    part.ln_no, c);
                return true;
            } else if c == ';' {
                println!(
                    "ERROR: ln:{} Expected another arg; got `{}` instead.",
                    part.ln_no, c);
                return true;
            } else {
                in_arg = true;
                arg_next.push(c);
            }
        }
    }

    return false;
}

pub fn now(part: LinePart, line: &str, altmode: Option<String>) -> bool {
    let     varname: String;
    let mut resume: usize = 0;
    let mut fmt_grps: Vec<String> = Vec::new();
    let mut flw_args: Vec<String> = Vec::new();
    let mut flw_arg_ctr: usize = 0;
    let mut include_endl: bool = true;
    let mut vars_expected: usize = 0;
    let mut vars_provided: usize;
    let mut resolved_arg: String;

    outputs::lines_main_push(&format!("    # {}", line.trim()));

    match &altmode {
        Some(amode) => {
            if amode == "writeln" {
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

                let varname_res: String;
                match fn_args::resolve_varname(part.ln_no, &varname) {
                    Some(res) => { varname_res = res.clone(); }
                    None => {
                        println!(
                            "ERROR: ln:{} Unable to resolve variable name for {}.",
                            part.ln_no, varname);
                        return true;
                    }
                }
                outputs::lines_main_push(&format!("    setout__file .{}", varname_res));
            }
        },
        None => {},
    }

    if load_print_groups(&mut fmt_grps, &mut resume, &part, line, &altmode) {
        return true;
    }
    if load_follow_args(&mut flw_args, &part, line, resume, &altmode) {
        return true;
    }

    vars_provided = flw_args.len();
    for arg in &flw_args {
        if arg == "endl=false" {
            include_endl = false;
            vars_provided -= 1;
        } else if !include_endl {
            println!(
                "ERROR: ln:{} Normal arguments not allowed after optional ones (e.g., endl=false).",
                part.ln_no);
            return true;
        }
    }

    if fmt_grps.len() == 0 {
        return as_type_newline(&altmode);
    }

    for grp in fmt_grps {
        if grp.starts_with("@") {
            // print out a string literal
            let str_lit_raw: String = format!(
                "\"{}\"", (grp[1..]).to_string());
            let str_lit_len = str_lit_raw.len() - 2;
            if str_lit_len <= 255 {
                if as_type_str8(&str_lit_raw) {
                    return true;
                }
            } else {
                println!("[TODO] ^^^ SUPER SIMPLE (STR16)");
            }
        } else if grp.starts_with("$") {
            // print out some sort of variable
            vars_expected += 1;
            if flw_arg_ctr > flw_args.len() {
                println!(
                    "ERROR: ln:{} Println expected more follow on arguments.",
                    part.ln_no);
                return true;
            }

            let single_arg: String = flw_args[flw_arg_ctr].clone();
            flw_arg_ctr += 1;

            match resolve_supplied_arg(part.ln_no, &single_arg) {
                Some(resolved) => {
                    resolved_arg = resolved;
                },
                None => {
                    println!(
                        "ERROR: ln:{} Println: Unable to resolve `{}`.",
                        part.ln_no, single_arg);
                    return true;
                }
            };

            match get_supplied_basetype(part.ln_no, &single_arg) {
            // match outputs::get_vartype(&resolved_arg) {
                Some(vartype) => {
                    match &vartype[..] {
                        "bool" => {
                            if as_type_bool(&resolved_arg) {
                                return true;
                            }
                        },
                        "file" => {
                            if as_type_file(&resolved_arg) {
                                return true;
                            }
                        },
                        "u8" => {
                            if as_type_u8(&resolved_arg) {
                                return true;
                            }
                        },
                        "u16" => {
                            if as_type_u16(&resolved_arg) {
                                return true;
                            }
                        },
                        "str8" => {
                            if as_type_str8(&resolved_arg) {
                                return true;
                            }
                        },
                        _ => {
                            println!("[TODO] println(): Unsupported type `{}` for `{}`", 
                                vartype, resolved_arg);
                        }
                    }
                },
                None => {
                    println!(
                        "ERROR: ln:{} Unknown variable `{}` passed to println().",
                        part.ln_no, single_arg);
                    return true;
                }
            }
        }
    }
    if vars_expected != vars_provided {
        println!(
            "ERROR: ln:{} println() expected {} follow arguments; got `{}` instead.",
            part.ln_no, vars_expected, vars_provided);
        return true;
    }

    wrapup_call(include_endl, &altmode);

    // } else if part.next == "print__char" {
    //  return as_type_char(part);

    // } else if part.next == "print__u8_x" {
    //  return as_type_u8_x(part);

    // } else if part.next == "print__u8_xx" {
    //  return as_type_u8_xx(part);

    // } else if part.next == "print__u16_x" {
    //  return as_type_u16_x(part);

    return false
}
