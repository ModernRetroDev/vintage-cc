pub struct RunCfg {
    pub help:    bool,
    pub level:   Option<String>,
    pub srcfile: Option<String>,
    pub target:  Option<String>,
}

impl RunCfg {
    pub fn show(&self) {
        println!("RUNCFG:");
        println!(" - help:    `{:?}`", self.help);
        println!(" - level:   `{:?}`", self.level);
        println!(" - srcfile: `{:?}`", self.srcfile);
        println!(" - target:  `{:?}`", self.target);
    }
}

pub fn show_usage() {
    println!("Usage: vintagecc [OPTION]... FILE");
    println!("Compiler for Vintage language code.");
    println!("Example: vintagecc -t x16 -l vll hello.vll");
    println!();
    println!("Options:");
    println!("  -h, --help        Show help/usage info (this text)");
    println!("  -l, --level=LVL   LVL is the compilation level: [vll, vhl]");
    println!("  -t, --target=TGT  TGT is the target platform: [c64, x16]");
    println!();
}

pub fn process_args(args: Vec<String>) -> Option<RunCfg> {
    let cfg: RunCfg;
    let mut shortexp:  String = "".to_string();
    //
    let mut help:      bool           = false;
    let mut level:     Option<String> = None;
    let mut srcfile:   Option<String> = None;
    let mut target:    Option<String> = None;

    if args.len() == 1 {
        show_usage();
        return None;
    }

    for arg in &args[1..] {
        if shortexp == "" {
            if arg.starts_with("--") {
                // longflag
                if arg == "--help" {
                    help = true;
                    continue;
                }
                if arg.starts_with("--level=") {
                    level = Some(arg[8..].to_string());
                    continue;
                }
                if arg.starts_with("--target=") {
                    target = Some(arg[9..].to_string());
                    continue;
                }

                println!("ERROR: Unsupported argument option `{}`.",
                    arg);
                return None;

            } else if arg.starts_with("-") {
                // shortflag
                match &arg[..] {
                    "-h" => {
                        help = true;
                        continue;
                    },
                    "-l" => {
                        shortexp = "-l".to_string();
                        continue;
                    },
                    "-t" => {
                        shortexp = "-t".to_string();
                        continue;
                    },
                    _ => {
                        println!("ERROR: Unsupported argument option `{}`.",
                            arg);
                        return None;
                    }
                }
            } else {
                match srcfile {
                    Some(_) => {
                        println!("ERROR: Only one unmatched argument supported; got `{}`.",
                            arg);
                        return None;
                    },
                    None => {
                        srcfile = Some(arg.clone());
                    }
                }
            }
        } else {
            if arg.starts_with("-") {
                println!("ERROR: Expected value for shortflag `{}`; not `{}`.",
                    shortexp, arg);
                return None;
            }

            match &shortexp[..] {
                "-l" => {
                    level = Some(arg.clone());
                },
                "-t" => {
                    target = Some(arg.clone());
                },
                _ => {
                    println!("ERROR: Unexpected value for shortflag `{}`.",
                        shortexp);
                    return None;
                }
            }
            shortexp = "".to_string();
        }
    }

    if srcfile.is_none() {
        show_usage();
        return None;
    }

    cfg = RunCfg{
        help,
        level,
        srcfile,
        target,
    };
    return Some(cfg);
}
