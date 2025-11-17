use crate::vhl::outputs;

use crate::vhl::line_part::LinePart;


fn is_valid_loop_label(loop_lbl: &str) -> bool {
    if !loop_lbl.starts_with("@") {
        return false;
    }
    if loop_lbl.len() <= 1 {
        return false;
    }
    if ! loop_lbl.chars().nth(1).unwrap().is_alphabetic() {
        return false;
    }

    for next in loop_lbl[2..].chars() {
        if next.is_alphabetic() {
            continue;
        }
        if next.is_digit(10) {
            continue;
        }
        if next == '_' {
            continue;
        }
        // else; invalid character
        return false;
    }

    return true;
}

pub fn now(part: LinePart) -> bool {
    let mut next:        LinePart;
    let     loop_label: Option<String>;

    next = part.clone();
    if next.next == "loop" {
    } else if next.next == "loop{" {
        println!(
            "ERROR: ln:{} There must be at least one space between `loop` keyword and `{{`.",
            part.ln_no);
        return true;
    } else {
        println!(
            "ERROR: ln:{} Expected `loop` got `{}`.",
            part.ln_no, next.next);
        return true;
    }

    next = next.get_next();
    if next.next != "{" {
        println!(
            "ERROR: ln:{} Loop keywords must be immediately followed by a `{{`.",
            part.ln_no);
        return true;
    }

    next = next.get_next();
    if next.next == "" {
        loop_label = None;
    } else if !next.next.starts_with("@") {
        println!(
            "ERROR: ln:{} Loop labels must start with an `@` char; got `{}`.",
            part.ln_no, next.next.chars().nth(0).unwrap());
        return true;
    } else if is_valid_loop_label(&next.next) {
        loop_label = Some(next.next[1..].to_string());
    } else {
        println!(
            "ERROR: ln:{} Invalid loop label provided; got `{}`.",
            part.ln_no, &next.next);
        return true;
    }

    match loop_label {
        Some(label) => {
            outputs::blktypes_push(&format!("loop:{}", label));
        },
        None => {
            outputs::blktypes_push("loop");
        }
    }

    outputs::lines_main_push(&format!("    # loop {}", part.rem));
    outputs::lines_main_push(         "    loop");
    outputs::lines_main_push("");

    return false;
}
