use crate::vhl::outputs;

use crate::vhl::line_part::LinePart;
use crate::vhl::process_if_rpn;


pub fn now(part: LinePart) -> bool {
    let mut is_else: bool = false;
    let mut is_elif: bool = false;
    let mut next: LinePart;

    // check if this endblock line is actually `} else {`
    next = part.get_next();
    if next.next == "else" {
        next = next.get_next();
        if next.next == "{" {
            is_else = true;
        } else if next.next == "if" {
            is_elif = true;
        }
    }

    match outputs::blktypes_pop() {
        Some(blktype) => {
            let blktype_str = &blktype[..];
            match blktype_str {
                "fn" => {
                    if is_else {
                        println!("ERROR: ln:{} an else block can not follow a fn block.",
                            part.ln_no);
                        return true;
                    }
                    outputs::set_active_fn("");
                },
                "if" => {
                    if is_else {
                        // an if block is ending and an else block beginning
                        outputs::blktypes_push("else");

                        outputs::lines_main_push("    # } else {");
                        outputs::lines_main_push("    else");
                    } else if is_elif {
                        // an if block is ending and an else block beginning
                        outputs::blktypes_push("else");

                        outputs::lines_main_push("    # } else if ... {");
                        outputs::lines_main_push("    else");
                        return process_if_rpn::now(part);
                    } else {
                        // an if block is ending; no follow-up block
                        outputs::lines_main_push("    endif");
                        outputs::lines_main_push("");
                    }
                },
                "elif" => {
                    if is_else {
                        // an elif block is ending and an else block beginning
                        outputs::blktypes_push("else_x2");

                        outputs::lines_main_push("    else");
                        outputs::lines_main_push("    # } else {");
                    } else if is_elif {
                        // an if block is ending and an else block beginning
                        outputs::blktypes_push("else");

                        outputs::lines_main_push("    # else if");
                        outputs::lines_main_push("    else");
                        return process_if_rpn::now(part);
                    } else {
                        // an if block is ending; no follow-up block
                        outputs::lines_main_push("    endif");
                        outputs::lines_main_push("");
                    }
                },
                "else" => {
                    if is_else {
                        println!("ERROR: ln:{} an else block can not follow an else block.",
                            part.ln_no);
                        return true;
                    }
                    outputs::lines_main_push("    endif");
                    outputs::lines_main_push("");
                },
                "else_x2" => {
                    if is_else {
                        println!("ERROR: ln:{} an else block can not follow an else block.",
                            part.ln_no);
                        return true;
                    }
                    if outputs::blktypes_pop() != Some("else".to_string()) {
                        println!("ERROR: ln:{} double-pop didnt work.",
                            part.ln_no);
                        return true;
                    }
                    outputs::lines_main_push("    endif");
                    outputs::lines_main_push("    endif");
                    outputs::lines_main_push("");
                },
                "loop" => {
                    _ = outputs::loop_ctr_types_pop();
                    outputs::lines_main_push("    endloop");
                    outputs::lines_main_push("");
                },
                _ => {
                    if blktype_str.starts_with("loop:") {
                        _ = outputs::loop_ctr_types_pop();
                        outputs::lines_main_push(         "    endloop");
                        outputs::lines_main_push(&format!("    label loop_{}", &blktype_str[5..]));
                        outputs::lines_main_push("");
                    } else {
                        println!("ERROR: ln:{} unhandled blktype `{}` at block end.",
                            part.ln_no, blktype_str);
                        return true;
                    }
                }
            }
        },
        None => {
            println!("ERROR: ln:{} unmatched block end character `}}`.",
                part.ln_no);
            return true;
        }
    }

    return false;
}
