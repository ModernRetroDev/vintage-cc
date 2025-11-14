use crate::vll::outputs;

use crate::vll::line_part::LinePart;


pub fn now(part: LinePart) -> bool {
    let mut ifblk_else: String;
    let mut ifblk_out:  String;
    let mut rep_ctr: u8 = 0;
    let     rep_num: u8;
    let rep_str = part.get_next().next;

    if rep_str.len() > 0 {
        rep_num = match rep_str.parse::<u8>() {
            Ok(val) => {
                val
            },
            Err(_) => {
                println!("ERROR: ln:{} `endif` with invalid repetition of `{}`.",
                    part.ln_no, rep_str);
                return true;
            }
        };
    } else {
        rep_num = 1;
    }

    while rep_ctr < rep_num {
        rep_ctr += 1;

        match outputs::ifblocks_pop() {
            Some(ifblk_name) => {

                ifblk_else = format!("{}_else", &ifblk_name);
                ifblk_out  = format!("{}_out",  &ifblk_name);

                outputs::mainfn_append("   ; endif");
                if !outputs::ifblock_has_else(&ifblk_name) {
                    outputs::mainfn_append(&format!("{}:", ifblk_else));
                }
                outputs::mainfn_append(&format!("{}:", ifblk_out));
                outputs::mainfn_append("");
            },
            None => {
                println!("ERROR: ln:{} `endif` found without corresponding `if`.",
                    part.ln_no);
                return true;
            }
        }
    }

    return false;
}
