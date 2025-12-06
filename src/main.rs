mod vhl;
mod vll;
mod process_vhl;
mod process_vll;
mod runconfig;

use std::env;
use process_vhl::process_vhl;
use process_vll::process_vll;


fn main() {
    let args: Vec<_> = env::args().collect();

    let runcfg: runconfig::RunCfg = match runconfig::process_args(args) {
        Some(cfg) => { cfg },
        None      => { return; }
    };

    match &runcfg.level {
        Some(lvl) => {
            match &lvl[..] {
                "vll" => {
                    process_vll(runcfg);
                },
                "vhl" => {
                    process_vhl(runcfg);
                },
                _ => {
                    println!("ERROR: Unsupported compilation level `{}`.",
                        lvl);
                    return;
                },
            }
        },
        None => {
            let srcfile: String = runcfg.srcfile.clone().unwrap();

            if srcfile.ends_with(".vll") {
             process_vll(runcfg);
            } else if srcfile.ends_with(".vnt") {
             process_vhl(runcfg);
            }
        }
    }
}
