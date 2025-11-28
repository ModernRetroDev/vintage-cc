use crate::vhl::outputs;

use crate::vhl::line_part::LinePart;


fn defblk_name_is_valid(blkname: &str) -> bool {
    let mut ctr:     u8   = 0;
    let mut uscored: bool = false;

    if blkname == "" {
        return true;
    }

    for c in blkname.chars() {
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
        } else {
            uscored = false;
        }

        ctr += 1;
    }

    return true;
}

pub fn now(part: LinePart, line: &str) -> bool {
    let defblk_name: String;
    let defblk_name_raw = part.get_next().next;

    if defblk_name_raw == "{" {
        defblk_name = "".to_string();
    } else {
        defblk_name = defblk_name_raw.clone();
    }

    //------------------------------------------------------------------------//
    // Make sure we aren't attempting to redefine a def block.                //
    //------------------------------------------------------------------------//
    if outputs::defblk_is_defined(&defblk_name) {
        if defblk_name == "" {
            println!(
                "ERROR: ln:{} Attempted redefintion of unlabeled `def` block.",
                part.ln_no);
        } else {
            println!(
                "ERROR: ln:{} Attempted redefintion of `def` block `{}`.",
                part.ln_no, defblk_name);
        }
        return true;
    }

    //------------------------------------------------------------------------//
    // Make sure that the def block was given a valid name.                   //
    //------------------------------------------------------------------------//
    if ! defblk_name_is_valid(&defblk_name) {
        println!(
            "ERROR: ln:{} Invalid name `{}` provided for `def` block.",
            part.ln_no, defblk_name);
        return true;
    }

    outputs::set_active_defblk(&defblk_name);

    return false;
}
