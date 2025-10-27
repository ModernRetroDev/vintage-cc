#![allow(static_mut_refs)]

use std::collections::HashMap;
use std::fs::File;
use std::io::Write;
use std::sync::{LazyLock, Mutex};

struct FnBlock {
    fn_name:        String,
    module_name:    Option<String>,
    //
    arr8_indices:   LazyLock<Mutex<HashMap<String, usize>>>,
    arr16_indices:  LazyLock<Mutex<HashMap<String, usize>>>,
    var_indices:    LazyLock<Mutex<HashMap<String, usize>>>,
    ifblk_has_else: LazyLock<Mutex<HashMap<String, bool>>>,
    //
    ifblk_levels:   Vec<String>,
    loopblk_levels: Vec<String>,
    //
    arr8_names:     Vec<String>,
    arr8_types:     Vec<String>,
    arr8_values:    Vec<Vec<u8>>,
    //
    arr16_names:    Vec<String>,
    arr16_types:    Vec<String>,
    arr16_values:   Vec<Vec<u8>>,
    //
    var_names:      Vec<String>,
    var_types:      Vec<String>,
    var_values:     Vec<Vec<u8>>,
    //
    lines_vardefs:  Vec<String>,
    lines_main:     Vec<String>,
}

fn new_fn_block(fn_name: &str) -> FnBlock {
    return FnBlock{
        fn_name        : fn_name.to_string(),
        module_name    : None,
        //
        arr8_indices   : LazyLock::new(|| Mutex::new(HashMap::new())),
        arr16_indices  : LazyLock::new(|| Mutex::new(HashMap::new())),
        var_indices    : LazyLock::new(|| Mutex::new(HashMap::new())),
        ifblk_has_else : LazyLock::new(|| Mutex::new(HashMap::new())),
        //
        ifblk_levels   : Vec::new(),
        loopblk_levels : Vec::new(),
        //
        arr8_names     : Vec::new(),
        arr8_types     : Vec::new(),
        arr8_values    : Vec::new(),
        //
        arr16_names    : Vec::new(),
        arr16_types    : Vec::new(),
        arr16_values   : Vec::new(),
        //
        var_names      : Vec::new(),
        var_types      : Vec::new(),
        var_values     : Vec::new(),
        //
        lines_vardefs  : Vec::new(),
        lines_main     : Vec::new(),
    }
}

impl FnBlock {
    pub fn set_arr8_index(&mut self, arr8name: &str) {
        let len = self.arr8_names.len();
        self.arr8_indices.lock().unwrap().insert(arr8name.to_string(), len);
    }

    pub fn get_arr8type(&self, arr8name: &str) -> Option<String> {
        let mut ind: usize = 0;
        for globvar in self.arr8_names.clone() {
            if arr8name == &globvar {
                return Some(self.arr8_types[ind].to_string());
            }
            ind += 1
        }
        return None;
    }

    pub fn set_arr16_index(&mut self, arr16name: &str) {
        let len = self.arr16_names.len();
        self.arr16_indices.lock().unwrap().insert(arr16name.to_string(), len);
    }

    pub fn get_arr16type(&self, arr16name: &str) -> Option<String> {
        let mut ind: usize = 0;
        for globvar in self.arr16_names.clone() {
            if arr16name == &globvar {
                return Some(self.arr16_types[ind].to_string());
            }
            ind += 1
        }
        return None;
    }

    pub fn set_var_index(&mut self, varname: &str) {
        let len = self.var_names.len();
        self.var_indices.lock().unwrap().insert(varname.to_string(), len);
    }

    pub fn get_vartype(&self, varname: &str) -> Option<String> {
        let mut ind: usize = 0;
            for globvar in self.var_names.clone() {
                if varname == &globvar {
                    return Some(self.var_types[ind].to_string());
                }
                ind += 1
            }
        return None;
    }

    pub fn ifblocks_push(&mut self, ifblk: &str) {
        self.ifblk_levels.push(ifblk.to_string());
    }

    pub fn ifblocks_peek(&mut self) -> Option<String> {
        if self.ifblk_levels.len() == 0 {
            return None
        }
        let lastblk = self.ifblk_levels.pop().unwrap();
        self.ifblk_levels.push(lastblk.to_string());

        return Some(lastblk);
    }

    pub fn ifblocks_pop(&mut self) -> Option<String> {
        if self.ifblk_levels.len() == 0 {
            return None
        }
        let lastblk = self.ifblk_levels.pop().unwrap();

        return Some(lastblk);
    }

    pub fn ifblock_has_else(&self, ifblk: &str) -> bool {
        return self.ifblk_has_else.lock().unwrap().contains_key(ifblk);
    }

    pub fn ifblock_set_else(&mut self, ifblk: &str) {
        self.ifblk_has_else.lock().unwrap().insert(ifblk.to_string(), true);
    }

    pub fn loopblocks_push(&mut self, loopblk: &str) {
        self.loopblk_levels.push(loopblk.to_string());
    }

    pub fn loopblocks_peek(&mut self) -> Option<String> {
        if self.loopblk_levels.len() == 0 {
            return None
        }
        let lastblk = self.loopblk_levels.pop().unwrap();
        self.loopblk_levels.push(lastblk.to_string());

        return Some(lastblk);
    }

    pub fn loopblocks_pop(&mut self) -> Option<String> {
        if self.loopblk_levels.len() == 0 {
            return None
        }
        let lastblk = self.loopblk_levels.pop().unwrap();

        return Some(lastblk);
    }

    pub fn arr8types_append(&mut self, arr8type: &str) {
        self.arr8_types.push(arr8type.to_string());
    }

    pub fn arr8names_append(&mut self, arr8type: &str) {
        self.arr8_names.push(arr8type.to_string());
    }

    pub fn arr8values_append(&mut self, value: Vec<u8>) {
        self.arr8_values.push(value);
    }

    pub fn arr16types_append(&mut self, arr16type: &str) {
        self.arr16_types.push(arr16type.to_string());
    }

    pub fn arr16names_append(&mut self, arr16type: &str) {
        self.arr16_names.push(arr16type.to_string());
    }

    pub fn arr16values_append(&mut self, value: Vec<u8>) {
        self.arr16_values.push(value);
    }

    pub fn vartypes_append(&mut self, vartype: &str) {
        self.var_types.push(vartype.to_string());
    }

    pub fn varnames_append(&mut self, varname: &str) {
        self.var_names.push(varname.to_string());
    }

    pub fn varvalues_append(&mut self, value: Vec<u8>) {
        self.var_values.push(value);
    }

    pub fn lines_main_append(&mut self, ln: &str) {
        self.lines_main.push(ln.to_string());
    }

    pub fn write_output(&mut self, outfile: &mut File) {
        //------------------------------------------------------------------------//
        // Write out the contents of the main function.                           //
        //------------------------------------------------------------------------//
        if self.fn_name == "main" && self.module_name.is_none() {
            self.lines_main.insert(0, ";--------------------------------------------------------;".to_string());
            self.lines_main.insert(1, "; MAIN FUNCTION                                          ;".to_string());
            self.lines_main.insert(2, ";--------------------------------------------------------;".to_string());
            self.lines_main.insert(3, "fn_main: ".to_string());
            self.lines_main.insert(4, "   ; set output mode to ISO".to_string());
            self.lines_main.insert(5, "   lda #$0F".to_string());
            self.lines_main.insert(6, "   jsr BSOUT".to_string());
            self.lines_main.insert(7, "".to_string());

            self.lines_main.push("   rts".to_string());
            self.lines_main.push("".to_string());
        } else {
            let fn_name = match &self.module_name {
                Some(mod_name) => {
                    format!("mod_{}_fn_{}", self.fn_name, self.module_name.as_ref().unwrap())
                },
                None => {
                    format!("fn_{}", self.fn_name)
                }
            };

            self.lines_main.insert(0, ";--------------------------------------------------------;".to_string());
            self.lines_main.insert(1, format!("; FUNCTION {}", fn_name));
            self.lines_main.insert(2, ";--------------------------------------------------------;".to_string());
            self.lines_main.insert(3, format!("{}: ", fn_name));
            self.lines_main.push("   rts".to_string());
            self.lines_main.push("".to_string());
        }

        for ln in self.lines_main.iter() {
            writeln!(outfile, "{}", ln).unwrap();
        }
    }

    pub fn process_vardefs(&mut self) -> bool {
        let mut arr8ind: usize = 0;
        let mut arr16ind: usize = 0;
        let mut varind:  usize = 0;

        for varname in self.var_names.iter() {
            let vartype = self.var_types[varind].to_string();
            let varvals = &self.var_values[varind];
            let varlen  = varvals.len();

            if vartype == "str8".to_string() {
                self.lines_vardefs.push(format!(
                    "{}: ; type: {}", varname, vartype));
                self.lines_vardefs.push(format!(
                    "   .byte ${:02X} ; length (u8)", varlen));
                self.lines_vardefs.push(format!(
                    "   .byte ${:02X} ; alloc (u8)", varlen));
                self.lines_vardefs.push(format!(
                    "   .byte ${:02X} ; element size (u8)", 1));
                self.lines_vardefs.push(
                    "   ; data start".to_string());

                //------------------------------------------------------------//
                // Write out contents of the string ten bytes at a time.      //
                //------------------------------------------------------------//
                let mut bytectr: u8 = 0;
                let mut dataln: String = format!("   .byte ");
                for value in varvals {
                    if bytectr > 9 {
                        dataln = (dataln.trim_end_matches(",")).to_string();
                        self.lines_vardefs.push(dataln);
                        
                        dataln = format!("   .byte ");
                        bytectr = 0;
                    }
                    dataln = format!("{}${:02X},", dataln, value);
                    bytectr += 1
                }
                if dataln != "   .byte ".to_string() {
                    dataln = (dataln.trim_end_matches(",")).to_string();
                    self.lines_vardefs.push(dataln);
                }

                self.lines_vardefs.push(format!(
                    "   .byte ${:02X} ; null terminator (u8)", 0));
                self.lines_vardefs.push("".to_string());
            } else if vartype == "ptr".to_string() {
                self.lines_vardefs.push(format!(
                    "{}: ; type: {}", varname, vartype));
                self.lines_vardefs.push(format!(
                    "   .byte $00, $00"));
                self.lines_vardefs.push("".to_string());
            } else if vartype == "bool".to_string() {
                self.lines_vardefs.push(format!(
                    "{}: ; type: {}", varname, vartype));
                self.lines_vardefs.push(format!(
                    "   .byte ${:02X}", 0));
            } else if vartype == "u8".to_string() {
                self.lines_vardefs.push(format!(
                    "{}: ; type: {}", varname, vartype));
                self.lines_vardefs.push(format!(
                    "   .byte ${:02X}", 0));
                self.lines_vardefs.push("".to_string());
            } else if vartype == "u16".to_string() {
                self.lines_vardefs.push(format!(
                    "{}: ; type: {}", varname, vartype));
                self.lines_vardefs.push(format!(
                    "   .byte $00, $00"));
                self.lines_vardefs.push("".to_string());
            } else if vartype == "file".to_string() {
                self.lines_vardefs.push(format!(
                    "{}: ; type: {}", varname, vartype));
                self.lines_vardefs.push(format!(
                    "   .byte $00, $00 ; ptr_addr (u16)"));
                self.lines_vardefs.push(format!(
                    "   .byte $00 ; mode (u8)"));
                self.lines_vardefs.push(format!(
                    "   .byte $00 ; device (u8)"));
                self.lines_vardefs.push(format!(
                    "   .byte $00 ; channel (u8)"));
                self.lines_vardefs.push(format!(
                    "   .byte $00 ; status (u8)"));
                self.lines_vardefs.push(format!(
                    "   .byte $00, $00 ; fname (u16)"));
                self.lines_vardefs.push("".to_string());
            } else {
                println!("ERROR: Unhandled vardef output type `{vartype}`.");
                return true;
            }

            varind += 1;
        }

        for arr8name in self.arr8_names.iter() {
            let arr8type = self.arr8_types[arr8ind].to_string();
            let arr8vals = &self.arr8_values[arr8ind];
            let arr8len  = arr8vals.len();

            if arr8type == "u8".to_string() {
                self.lines_vardefs.push(format!(
                    "{}: ; type: arr8__{}", arr8name, arr8type));
                self.lines_vardefs.push(format!(
                    "   .byte ${:02X} ; length (u8)", arr8len));
                self.lines_vardefs.push(format!(
                    "   .byte ${:02X} ; alloc (u8)", arr8len));
                self.lines_vardefs.push(format!(
                    "   .byte ${:02X} ; element size (u8)", 1));
                self.lines_vardefs.push(
                    "   ; data start".to_string());

                //------------------------------------------------------------//
                // Write out contents of the string ten bytes at a time.      //
                //------------------------------------------------------------//
                let mut bytectr: u8 = 0;
                let mut dataln: String = format!("   .byte ");
                for value in arr8vals {
                    if bytectr > 9 {
                        dataln = (dataln.trim_end_matches(",")).to_string();
                        self.lines_vardefs.push(dataln);
                        
                        dataln = format!("   .byte ");
                        bytectr = 0;
                    }
                    dataln = format!("{}${:02X},", dataln, value);
                    bytectr += 1
                }
                if dataln != "   .byte ".to_string() {
                    dataln = (dataln.trim_end_matches(",")).to_string();
                    self.lines_vardefs.push(dataln);
                }
                self.lines_vardefs.push("".to_string());
            }

            arr8ind += 1;
        }

        for arr16name in self.arr16_names.iter() {
            let arr16type = self.arr16_types[arr16ind].to_string();
            let arr16vals = &self.arr16_values[arr16ind];
            let arr16len  = arr16vals.len();
            let arr16len_lo = arr16len & 0x00FF;
            let arr16len_hi = (arr16len & 0xFF00) >> 8;

            if arr16type == "u8".to_string() {
                self.lines_vardefs.push(format!(
                    "{}: ; type: arr16__{}", arr16name, arr16type));
                self.lines_vardefs.push(format!(
                    "   .byte ${:02X},${:02X} ; length (u16)",
                    arr16len_lo, arr16len_hi));
                self.lines_vardefs.push(format!(
                    "   .byte ${:02X},${:02X} ; alloc (u16)",
                    arr16len_lo, arr16len_hi));
                self.lines_vardefs.push(format!(
                    "   .byte ${:02X} ; element size (u8)", 1));
                self.lines_vardefs.push(
                    "   ; data start".to_string());

                //------------------------------------------------------------//
                // Write out contents of the string ten bytes at a time.      //
                //------------------------------------------------------------//
                let mut bytectr: u8 = 0;
                let mut dataln: String = format!("   .byte ");
                for value in arr16vals {
                    if bytectr > 9 {
                        dataln = (dataln.trim_end_matches(",")).to_string();
                        self.lines_vardefs.push(dataln);
                        
                        dataln = format!("   .byte ");
                        bytectr = 0;
                    }
                    dataln = format!("{}${:02X},", dataln, value);
                    bytectr += 1
                }
                if dataln != "   .byte ".to_string() {
                    dataln = (dataln.trim_end_matches(",")).to_string();
                    self.lines_vardefs.push(dataln);
                }
                self.lines_vardefs.push("".to_string());
            }

            arr16ind += 1;
        }

        return false;
    }
}


static mut ACTIVE_FN:           String = String::new();
static mut PLATFORM:            String = String::new();
static mut OUTPUT_FILENAME:     String = String::new();
static mut FN_BLOCKS:           Vec<FnBlock> = Vec::new();
static mut LINES_PLATFORM_BP:   Vec<String>  = Vec::new();
static mut LINES_BUILTIN_FNS:   Vec<String>  = Vec::new();
static mut LINES_VARIABLE_DEFS: Vec<String> = Vec::new();


pub fn fn_is_defined(fn_name: &str) -> bool {
    unsafe {
        for fn_blk in FN_BLOCKS.iter() {
            if fn_blk.fn_name == fn_name {
                return true;
            }
        }
    }
    return false;
}

pub fn set_output_filename(outname: &str) {
    unsafe {
        OUTPUT_FILENAME = outname.to_string();
    }
}

pub fn get_platform() -> String {
    unsafe {
        return PLATFORM.clone();
    }
}

pub fn set_platform(platform: &str) {
    unsafe {
        LINES_PLATFORM_BP = Vec::new();
        LINES_PLATFORM_BP.push(";--------------------------------------------------------;".to_string());
        LINES_PLATFORM_BP.push("; PLATFORM BOILERPLATE                                   ;".to_string());
        LINES_PLATFORM_BP.push(";--------------------------------------------------------;".to_string());
    }
    if platform == "x16" {
        unsafe {
            PLATFORM = platform.to_string();

            LINES_PLATFORM_BP.push(".include \"x16.inc\"".to_string());
            LINES_PLATFORM_BP.push("".to_string());
            LINES_PLATFORM_BP.push(".org $080D".to_string());
            LINES_PLATFORM_BP.push(".segment \"STARTUP\"".to_string());
            LINES_PLATFORM_BP.push(".segment \"INIT\"".to_string());
            LINES_PLATFORM_BP.push(".segment \"ONCE\"".to_string());
            LINES_PLATFORM_BP.push(".segment \"CODE\"".to_string());
            LINES_PLATFORM_BP.push("".to_string());
            LINES_PLATFORM_BP.push("   jmp fn_main".to_string());
            LINES_PLATFORM_BP.push("".to_string());
        }
    }
}

pub fn set_active_fn(fn_name: &str) {
    unsafe {
        ACTIVE_FN = fn_name.to_string();

        FN_BLOCKS.push(new_fn_block(fn_name));
    }
}

pub fn get_active_fn() -> String {
    let active_fn: String;
    unsafe {
        active_fn = ACTIVE_FN.clone();
    }
    return active_fn
}

pub fn set_arr8_index(arr8name: &str) {
    unsafe {
        let last_ind = FN_BLOCKS.len() - 1;
        FN_BLOCKS[last_ind].set_arr8_index(arr8name);
    }
}

pub fn get_arr8type(arr8name: &str) -> Option<String> {
    unsafe {
        let last_ind = FN_BLOCKS.len() - 1;
        return FN_BLOCKS[last_ind].get_arr8type(arr8name);
    }
}

pub fn set_arr16_index(arr16name: &str) {
    unsafe {
        let last_ind = FN_BLOCKS.len() - 1;
        FN_BLOCKS[last_ind].set_arr16_index(arr16name);
    }
}

pub fn get_arr16type(arr16name: &str) -> Option<String> {
    unsafe {
        let last_ind = FN_BLOCKS.len() - 1;
        return FN_BLOCKS[last_ind].get_arr16type(arr16name);
    }
}

pub fn set_var_index(varname: &str) {
    unsafe {
        let last_ind = FN_BLOCKS.len() - 1;
        FN_BLOCKS[last_ind].set_var_index(varname);
    }
}

pub fn get_vartype(varname: &str) -> Option<String> {
    unsafe {
        for fn_blk in FN_BLOCKS.iter() {
            match fn_blk.get_vartype(varname) {
                Some(vtype) => {
                    return Some(vtype);
                },
                None => {},
            }
        }
        return None;
    }
}

pub fn ifblocks_push(ifblk: &str) {
    unsafe {
        let last_ind = FN_BLOCKS.len() - 1;
        FN_BLOCKS[last_ind].ifblocks_push(ifblk);
    }
}

pub fn ifblocks_peek() -> Option<String> {
    unsafe {
        let last_ind = FN_BLOCKS.len() - 1;
        return FN_BLOCKS[last_ind].ifblocks_peek();
    }
}

pub fn ifblocks_pop() -> Option<String> {
    unsafe {
        let last_ind = FN_BLOCKS.len() - 1;
        return FN_BLOCKS[last_ind].ifblocks_pop();
    }
}

pub fn ifblock_has_else(ifblk: &str) -> bool {
    unsafe {
        let last_ind = FN_BLOCKS.len() - 1;
        return FN_BLOCKS[last_ind].ifblock_has_else(ifblk);
    }
}

pub fn ifblock_set_else(ifblk: &str) {
    unsafe {
        let last_ind = FN_BLOCKS.len() - 1;
        FN_BLOCKS[last_ind].ifblock_set_else(ifblk);
    }
}

pub fn loopblocks_push(loopblk: &str) {
    unsafe {
        let last_ind = FN_BLOCKS.len() - 1;
        FN_BLOCKS[last_ind].loopblocks_push(loopblk);
    }
}

pub fn loopblocks_peek() -> Option<String> {
    unsafe {
        let last_ind = FN_BLOCKS.len() - 1;
        return FN_BLOCKS[last_ind].loopblocks_peek();
    }
}

pub fn loopblocks_pop() -> Option<String> {
    unsafe {
        let last_ind = FN_BLOCKS.len() - 1;
        return FN_BLOCKS[last_ind].loopblocks_pop();
    }
}

pub fn arr8types_append(arr8type: &str) {
    unsafe {
        let last_ind = FN_BLOCKS.len() - 1;
        FN_BLOCKS[last_ind].arr8types_append(arr8type);
    }
}

pub fn arr8names_append(arr8name: &str) {
    unsafe {
        let last_ind = FN_BLOCKS.len() - 1;
        FN_BLOCKS[last_ind].arr8names_append(arr8name);
    }
}

pub fn arr8values_append(value: Vec<u8>) {
    unsafe {
        let last_ind = FN_BLOCKS.len() - 1;
        FN_BLOCKS[last_ind].arr8values_append(value);
    }
}

pub fn arr16types_append(arr16type: &str) {
    unsafe {
        let last_ind = FN_BLOCKS.len() - 1;
        FN_BLOCKS[last_ind].arr16types_append(arr16type);
    }
}

pub fn arr16names_append(arr16name: &str) {
    unsafe {
        let last_ind = FN_BLOCKS.len() - 1;
        FN_BLOCKS[last_ind].arr16names_append(arr16name);
    }
}

pub fn arr16values_append(value: Vec<u8>) {
    unsafe {
        let last_ind = FN_BLOCKS.len() - 1;
        FN_BLOCKS[last_ind].arr16values_append(value);
    }
}

pub fn vartypes_append(vartype: &str) {
    unsafe {
        let last_ind = FN_BLOCKS.len() - 1;
        FN_BLOCKS[last_ind].vartypes_append(vartype);
    }
}

pub fn varnames_append(varname: &str) {
    unsafe {
        let last_ind = FN_BLOCKS.len() - 1;
        FN_BLOCKS[last_ind].varnames_append(varname);
    }
}

pub fn varvalues_append(value: Vec<u8>) {
    unsafe {
        let last_ind = FN_BLOCKS.len() - 1;
        FN_BLOCKS[last_ind].varvalues_append(value);
    }
}

pub fn mainfn_append(ln: &str) {
    unsafe {
        let last_ind = FN_BLOCKS.len() - 1;
        FN_BLOCKS[last_ind].lines_main_append(ln);
    }
}

pub fn builtin_append(ln: &str) {
    unsafe {
        LINES_BUILTIN_FNS.push(ln.to_string());
    }
}

fn write_platform_boilerplate(outfile: &mut File) {
    //------------------------------------------------------------------------//
    // Write out platform specific boilerplate lines.                         //
    //------------------------------------------------------------------------//
    unsafe {
        for ln in LINES_PLATFORM_BP.iter() {
            writeln!(outfile, "{}", ln).unwrap();
        }
    }
}

fn write_variable_defs(outfile: &mut File) {
    //------------------------------------------------------------------------//
    // Write out the contents of the variable definitions.                    //
    //------------------------------------------------------------------------//
    unsafe {
        for fn_blk in FN_BLOCKS.iter() {
            for ln in fn_blk.lines_vardefs.iter() {
                LINES_VARIABLE_DEFS.push(ln.to_string());
            }
        }

        if LINES_VARIABLE_DEFS.len() == 0 {
            LINES_VARIABLE_DEFS.push("".to_string());
        }

        LINES_VARIABLE_DEFS.insert(0, ";--------------------------------------------------------;".to_string());
        LINES_VARIABLE_DEFS.insert(1, "; VARIABLE DEFINITIONS                                   ;".to_string());
        LINES_VARIABLE_DEFS.insert(2, ";--------------------------------------------------------;".to_string());

        for ln in LINES_VARIABLE_DEFS.iter() {
            writeln!(outfile, "{}", ln).unwrap();
        }
    }
}

fn write_builtin_fns(mut outfile: &File) {
    //------------------------------------------------------------------------//
    // Write out the builtin (standard) functions.                            //
    //------------------------------------------------------------------------//
    unsafe {
        if LINES_BUILTIN_FNS.len() == 0 {
            LINES_BUILTIN_FNS.push("".to_string());
        }

        LINES_BUILTIN_FNS.insert(0, ";--------------------------------------------------------;".to_string());
        LINES_BUILTIN_FNS.insert(1, "; BUILT-IN FUNCTIONS                                     ;".to_string());
        LINES_BUILTIN_FNS.insert(2, ";--------------------------------------------------------;".to_string());

        for ln in LINES_BUILTIN_FNS.iter() {
            writeln!(&mut outfile, "{}", ln).unwrap();
        }
    }
}

pub fn write() -> bool {
    let outp_fname: String;
    unsafe {
        if OUTPUT_FILENAME.len() > 0 {
            outp_fname = OUTPUT_FILENAME.to_string();
        } else {
            println!("ERROR: OUTPUT_FILENAME not set before writing output");
            return true;
        }
    }
    let mut outfile = File::create(&outp_fname).unwrap();

    write_platform_boilerplate(&mut outfile);
    write_variable_defs(&mut outfile);
    write_builtin_fns(&mut outfile);

    unsafe {
        for fn_blk in &mut FN_BLOCKS {
            fn_blk.write_output(&mut outfile);
        }
    }

    return false;
}

fn process_vardefs() -> bool {
    //------------------------------------------------------------------------//
    // Write out platform specific boilerplate lines.                         //
    //------------------------------------------------------------------------//
    unsafe {
        for fn_blk in FN_BLOCKS.iter_mut() {
            if fn_blk.process_vardefs() {
                return true;
            }
        }
    }
    return false;
}

pub fn process() -> bool {
    return process_vardefs();
}