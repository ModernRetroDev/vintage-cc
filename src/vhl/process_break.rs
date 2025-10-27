use crate::vhl::outputs;

use crate::vhl::line_part::LinePart;

pub fn now(part: LinePart) -> bool {
    let mut next:        LinePart;
    let     loop_label: Option<String>;

    next = part.clone();
    if next.next == "break;" {
        loop_label = None;
    } else if next.next == "break" {
        next = next.get_next();
        if next.next == ";" {
            loop_label = None;
        } else if next.next.starts_with("@") {
            if next.next.ends_with(";") {
                let stop = next.next.len() - 1;
                loop_label = Some(next.next[1..stop].to_string());
            } else {
                println!(
                    "ERROR: ln:{} Function call is missing a trailing semicolon.",
                    part.ln_no);
                return true;
            }

            if !outputs::blktypes_has_named_loop(&loop_label.as_ref().unwrap()) {
                println!(
                    "ERROR: ln:{} BREAK: Can't break named loop `{}`, as it isn't active.",
                    part.ln_no, loop_label.unwrap());
                return true;
            }

        } else {
            println!(
                "ERROR: ln:{} Loop labels must start with an `@` char; got `{}`.",
                part.ln_no, next.next.chars().nth(0).unwrap());
            return true;
        }
    } else {
        println!(
            "ERROR: ln:{} Expected `break` got `{}`.", part.ln_no, next.next);
        return true;
    }

    //------------------------------------------------------------------------//
    // Make sure that we are within at least one loop construct.              //
    //------------------------------------------------------------------------//
    if !outputs::blktypes_has_loop() {
        println!(
            "ERROR: ln:{} Keyword `break` can not be used outside of a loop.", 
                part.ln_no);
        return true;
    }

    outputs::lines_main_push(&format!("    # break {}", part.rem));
    match loop_label {
        Some(label) => {
            outputs::lines_main_push(&format!("    goto loop_{}", label));
        },
        None => {
            outputs::lines_main_push("    break");
        }
    }
    outputs::lines_main_push("");

    return false;
}
