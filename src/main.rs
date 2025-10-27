mod vhl;
mod vll;
mod process_vhl;
mod process_vll;

use std::env;
use process_vhl::process_vhl;
use process_vll::process_vll;

fn show_usage() {
	println!("Usage: vintagecc FILE");
	println!();
}

fn main() {
	let args: Vec<_> = env::args().collect();

	if args.len() == 1 {
		show_usage();
		return;
	}

	if args[1].ends_with(".vll") {
		process_vll();
	} else if args[1].ends_with(".vnt") {
		process_vhl();
	}
}
