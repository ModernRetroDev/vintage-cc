use crate::vhl::outputs;

use crate::vhl::line_part::LinePart;


pub fn resolve_line(ln_no: u64, line: &str) -> Option<String> {
    // return Some(line.to_string());
    let mut resolved: String = "".to_string();

    if !line.contains("#") {
        return Some(line.to_string());
    }

    //------------------------------------------------------------------------//
    // Otherwise, we need to make sure it's not within a string.              //
    //------------------------------------------------------------------------//
    if line.contains("\"") {
        println!("[TODO]: Preproc defines not currently handled with strings");
        return Some(line.to_string());
    }

    let mut indef: bool = false;
    let mut defstr: String = "".to_string();

    for c in line.chars() {
        if indef {
            if c == '_' || c.is_uppercase() || c.is_digit(10) {
                defstr.push(c);
                continue;
            } else {
                if !outputs::preproc_def_exists(&defstr) {
                    println!(
                        "ERROR: ln:{} Definition name `#{}` does not exist.",
                        ln_no, &defstr);
                    return None;
                } else {
                    match outputs::preproc_get_def_str(&defstr) {
                        Some(defval) => {
                            resolved.push_str(&defval);
                            defstr = "".to_string();
                        },
                        None => {
                            println!(
                                "ERROR: ln:{} Unable to resolve definition `#{}`.",
                                ln_no, &defstr);
                            return None;
                        },
                    }
                }

                if c == '#' {
                    indef = true;
                } else {
                    indef = false;
                    resolved.push(c);
                }
                continue;
            }
        } else {
            if c == '#' {
                indef = true;
                continue;
            } else {
                resolved.push(c);
            }
        }
    }

    return Some(resolved);
}

fn defname_matches_defblk(defname: &str) -> bool {
    let defblk: String = outputs::get_active_defblk();
    if defblk == "" {
        return true;
    }

    let prefix: String = format!("{}__", defblk);
    return defname.starts_with(&prefix);
}

fn defname_is_valid(defname: &str) -> bool {
    let defblk: String = outputs::get_active_defblk();
    let prefix: String;
    let mut ctr:     u8   = 0;
    let mut uscored: bool = false;


    if defblk == "" {
        prefix = "".to_string();
    } else {
        prefix = format!("{}__", defblk);
    }

    let prefix_len = prefix.len();

    let substr: String = defname[prefix_len..].to_string();

    for c in substr.chars() {
        if ctr == 0 {
            if c == '_' || c.is_digit(10) {
                return false;
            }
            if ! c.is_uppercase() {
                return false;
            }
            ctr += 1;
            continue;
        }

        if c == '_' {
            if uscored {
                return false;
            }
            uscored = true;
        } else if c.is_uppercase() || c.is_digit(10) {
            uscored = false;
        } else {
            return false;
        }

        ctr += 1;
    }

    return true;
}

fn get_defname(line: &str) -> String {
    let mut leading: bool = true;
    let mut defname: String = "".to_string();


    for c in line.chars() {
        if leading {
            if c == ' ' || c == '\t' {
                continue;
            } else {
                defname.push(c);
                leading = false;
            }
        } else {
            if c == ' ' || c == '\t' {
                break;
            } else {
                defname.push(c);
            }
        }
    }
    return defname;
}

fn get_defvalue(line: &str) -> String {
    let mut leading: bool = true;
    let mut get_value: bool = false;
    let mut defvalue: String = "".to_string();

    for c in line.chars() {
        if get_value {
            if leading {
                if c == ' ' || c == '\t' {
                    continue;
                } else {
                    defvalue.push(c);
                    leading = false;
                }
            } else {
                if c == ' ' || c == '\t' {
                    break;
                } else {
                    defvalue.push(c);
                }
            }
        } else {
            if leading {
                if c == ' ' || c == '\t' {
                    continue;
                } else {
                    leading = false;
                }
            } else {
                if c == ' ' || c == '\t' {
                    get_value = true;
                    leading   = true;
                    continue;
                }
            }
        }
    }
    defvalue = defvalue.trim().to_string();

    return defvalue;
}

pub fn load_def(ln_no: u64, line: &str) -> bool {
    let defname: String = get_defname(line);

    //------------------------------------------------------------------------//
    // Make sure the defname has the correct defblk prefix.                   //
    //------------------------------------------------------------------------//
    if !defname_matches_defblk(&defname) {
        let prefix: String = format!("{}__", outputs::get_active_defblk());
        println!(
            "ERROR: ln:{} Invalid definition `{}`; must start with `{}`.",
            ln_no, &defname, prefix);
        return true;
    }

    //------------------------------------------------------------------------//
    // Make sure the defname is otherwise syntactically correct.              //
    //------------------------------------------------------------------------//
    if !defname_is_valid(&defname) {
        println!(
            "ERROR: ln:{} Invalid name `{}` used in definition.",
            ln_no, &defname);
        return true;
    }

    //------------------------------------------------------------------------//
    // Make sure the defname isn't already in use.                            //
    //------------------------------------------------------------------------//
    if outputs::preproc_def_exists(&defname) {
        println!(
            "ERROR: ln:{} Definition name `{}` is already in use.",
            ln_no, &defname);
        return true;
    }

    let defvalue: String = get_defvalue(line);

    println!("[TODO]: Make sure that defs don't include other defs");
    outputs::defblk_push(&defname, &defvalue);


    return false;
}