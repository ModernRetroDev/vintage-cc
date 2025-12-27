#![allow(static_mut_refs)]

use std::collections::HashMap;
use std::fs::File;
use std::io::Write;
use std::sync::{LazyLock, Mutex};

pub struct FnArg {
    pub arg_pos:  u8,
    pub arg_name: String,
    pub arg_type: String,
}

pub fn new_fn_arg(apos: u8, aname: &str, atype: &str) -> FnArg {
    return FnArg{
        arg_pos:  apos,
        arg_name: aname.to_string(),
        arg_type: atype.to_string(),
    }
}

struct DefBlock {
    blk_name:   String,
    def_names:  Vec<String>,
    def_values: Vec<String>,
}

fn new_def_block(defblk_name: &str) -> DefBlock {
    return DefBlock{
        blk_name   : defblk_name.to_string(),
        def_names  : Vec::new(),
        def_values : Vec::new(),
    }
}

impl DefBlock {
    pub fn defblk_push(&mut self, defname: &str, defvalue: &str) {
        self.def_names.push(defname.to_string());
        self.def_values.push(defvalue.to_string());
    }
}

struct FnBlock {
    fn_name:        String,
    module_name:    Option<String>,
    //
    fn_args:        Vec<FnArg>,
    //
    var_names:      Vec<String>,
    var_types:      Vec<String>,
    var_indices:    LazyLock<Mutex<HashMap<String, usize>>>,
    //
    fn_stk_size:         u8,
    fn_stk_elem_size:    u8,
    fn_blktype_levels:   Vec<String>,
    //
    fn_unique_ptrs:      Vec<String>,
    fn_unique_ptrs_stk:  Vec<String>,
    fn_unique_ptrs_len:  u8,
    //
    fn_loop_ctr_types:   Vec<String>,
    fn_loop_ctr_len_u8:  u8,
    fn_loop_ctr_len_u16: u8,
    //
    fn_has_cmpres:       bool,
    fn_has_array_ptr:    bool,
    fn_temp_types:       Vec<String>,
    //
    lines_vardecls: Vec<String>,
    lines_vardefs:  Vec<String>,
    lines_main:     Vec<String>,
}

fn new_fn_block(fn_name: &str) -> FnBlock {
    return FnBlock{
        fn_name        : fn_name.to_string(),
        module_name    : None,
        //
        fn_args        : Vec::new(),
        //
        var_names      : Vec::new(),
        var_types      : Vec::new(),
        var_indices    : LazyLock::new(|| Mutex::new(HashMap::new())),
        //
        fn_stk_size:         0,
        fn_stk_elem_size:    0,
        fn_blktype_levels:   Vec::new(),
        //
        fn_unique_ptrs:      Vec::new(),
        fn_unique_ptrs_stk:  Vec::new(),
        fn_unique_ptrs_len:  0,
        //
        fn_loop_ctr_types:   Vec::new(),
        fn_loop_ctr_len_u8:  0,
        fn_loop_ctr_len_u16: 0,
        //
        fn_has_cmpres:       false,
        fn_has_array_ptr:    false,
        fn_temp_types:       Vec::new(),
        //
        lines_vardecls : Vec::new(),
        lines_vardefs  : Vec::new(),
        lines_main     : Vec::new(),
    }
}

impl FnBlock {
    pub fn mark_temptype_in_fn(&mut self, temptype: &str) {
        for oldtype in self.fn_temp_types.clone() {
            if oldtype == temptype {
                return;
            }
        }
        self.fn_temp_types.push(temptype.to_string());
    }

    fn varname_is_fn_arg(&self, vname: &str) -> bool {
        for fn_arg in &self.fn_args {
            if fn_arg.arg_name == vname {
                return true;
            }
        }
        return false;
    }

    fn get_fn_arg_vartype(&self, vname: &str) -> String {
        let mut vtype: String = "".to_string();

        for fn_arg in &self.fn_args {
            if fn_arg.arg_name == vname {
                vtype = fn_arg.arg_type.clone();
                break;
            }
        }
        return vtype;
    }

    fn get_fn_arg_varname(&self, arg_name: &str) -> String {
        let mut varname: String = "".to_string();

        for fn_arg in &self.fn_args {
            if fn_arg.arg_name == arg_name {
                varname = format!("_arg_{}__{}", fn_arg.arg_pos, arg_name);
            }
        }
        return varname;
    }

    pub fn set_cmpres_in_fn(&mut self) {
        self.fn_has_cmpres = true;
    }

    pub fn set_array_ptr_in_fn(&mut self) {
        self.fn_has_array_ptr = true;
    }

    pub fn update_fn_stack(&mut self, stk_len: u8, elem_size: u8) {
        if self.fn_stk_size < stk_len {
            self.fn_stk_size = stk_len;
        }
        if self.fn_stk_elem_size < elem_size {
            self.fn_stk_elem_size = elem_size;
        }
    }

    pub fn loop_ctr_types_push(&mut self, looptype: &str) -> bool {
        let mut u8_count:  u8 = 0;
        let mut u16_count: u8 = 0;

        self.fn_loop_ctr_types.push(looptype.to_string());

        for ltype in &self.fn_loop_ctr_types {
            match &ltype[..] {
                "u8" => {
                    u8_count += 1;
                },
                "u16" => {
                    u16_count += 1;
                },
                _ => {
                    println!(
                        "ERROR: loop_ctr_types_push(): unsupported type `{}`.",
                        ltype);
                    return true;
                }
            }
        }
        if u8_count > self.fn_loop_ctr_len_u8 {
            self.fn_loop_ctr_len_u8 = u8_count;
        }
        if u16_count > self.fn_loop_ctr_len_u16 {
            self.fn_loop_ctr_len_u16 = u16_count;
        }
        return false;
    }

    pub fn loop_ctr_types_pop(&mut self) -> Option<String> {
        if self.fn_loop_ctr_types.len() == 0 {
            return None
        }
        let lastblk = self.fn_loop_ctr_types.pop().unwrap();

        return Some(lastblk);
    }

    pub fn get_loop_ctr_tempvar(&self) -> Option<String> {
        let loop_type_len = self.fn_loop_ctr_types.len();

        if loop_type_len == 0 {
            return None
        }

        let final_loop_ctr_type =
            self.fn_loop_ctr_types[loop_type_len-1].clone();

        match &final_loop_ctr_type[..] {
            "u8" => {
                return Some(format!(
                    "_loop_ctr_u8_{}", self.fn_loop_ctr_len_u8-1));
            },
            "u16" => {
                return Some(format!(
                    "_loop_ctr_u16_{}", self.fn_loop_ctr_len_u16-1));
            },
            _ => {
                return None;
            }
        }
    }

    pub fn get_unique_ptr_var(&mut self, basetype: &str) -> Option<String> {
        let next_uptr_no = self.fn_unique_ptrs_len;

        self.fn_unique_ptrs_len += 1;

        match basetype {
            "char" => {
                let uptr: String = format!(
                    "_uptr_{}_{}", basetype, next_uptr_no);
                self.fn_unique_ptrs_stk.push(uptr.clone());
                self.fn_unique_ptrs.push(
                    format!("ptr__{} {}", basetype, uptr));
                return Some(uptr);
            },
            "u8" => {
                let uptr: String = format!(
                    "_uptr_{}_{}", basetype, next_uptr_no);
                self.fn_unique_ptrs_stk.push(uptr.clone());
                self.fn_unique_ptrs.push(
                    format!("ptr__{} {}", basetype, uptr));
                return Some(uptr);
            },
            "u16" => {
                let uptr: String = format!(
                    "_uptr_{}_{}",basetype, next_uptr_no);
                self.fn_unique_ptrs_stk.push(uptr.clone());
                self.fn_unique_ptrs.push(
                    format!("ptr__{} {}", basetype, uptr));
                return Some(uptr);
            },
            _ => {
                return None;
            }
        }
    }

    pub fn set_fn_args(&mut self, fn_args: Vec<FnArg>) {
        self.fn_args = fn_args;
    }

    pub fn set_var_index(&mut self, varname: &str) {
        let len = self.var_names.len();
        self.var_indices.lock().unwrap().insert(varname.to_string(), len);
    }

    pub fn get_vartype(&self, varname: &str) -> Option<String> {
        let mut ind: usize = 0;
        let     vname: &str;

        if varname.starts_with("_temp_") {
            return Some(varname[6..].to_string());
        } else if varname.starts_with("_loop_ctr_") {
            let remaining: String = varname[10..].to_string();
            let index = remaining.find("_").unwrap();
            let basetype = remaining[..index].to_string();
            return Some(basetype);
            //
        } else if varname.contains("[") {
            let stop = varname.find("[").unwrap();
            vname = &varname[..stop];
        } else {
            vname = varname;
        }

        if self.varname_is_fn_arg(vname) {
            return Some(self.get_fn_arg_vartype(vname).to_string());
        }

        for globvar in self.var_names.clone() {
            if vname == &globvar {
                return Some(self.var_types[ind].to_string());
            }
            ind += 1
        }
        return None;
    }

    pub fn blktypes_push(&mut self, blktype: &str) {
        self.fn_blktype_levels.push(blktype.to_string());
    }

    pub fn blktypes_peek(&mut self) -> Option<String> {
        if self.fn_blktype_levels.len() == 0 {
            return None
        }
        let lastblk = self.fn_blktype_levels.pop().unwrap();
        self.fn_blktype_levels.push(lastblk.to_string());

        return Some(lastblk);
    }

    pub fn blktypes_pop(&mut self) -> Option<String> {
        if self.fn_blktype_levels.len() == 0 {
            return None
        }
        let lastblk = self.fn_blktype_levels.pop().unwrap();

        return Some(lastblk);
    }

    pub fn blktypes_has_loop(&self) -> bool {
        if self.fn_blktype_levels.len() == 0 {
            return false
        }
        for blktype in &self.fn_blktype_levels {
            if blktype == "loop" {
                return true
            }
        }
        return false;
    }

    pub fn blktypes_has_named_loop(&self, loopname: &str) -> bool {
        let blksrc_name: String = format!("loop:{}", loopname);
        if self.fn_blktype_levels.len() == 0 {
            return false
        }
        for blktype in &self.fn_blktype_levels {

            if blktype == &blksrc_name {
                return true
            }
        }
        return false;
    }

    pub fn lines_vardecls_push(&mut self, decl_ln: &str) {
        self.lines_vardecls.push(decl_ln.to_string());
    }

    pub fn lines_vardef_push(&mut self, def_ln: &str) {
        self.lines_vardefs.push(def_ln.to_string());
    }

    pub fn lines_main_push(&mut self, main_ln: &str) {
        self.lines_main.push(main_ln.to_string());
    }

    pub fn vartypes_append(&mut self, vartype: &str) {
        self.var_types.push(vartype.to_string());
    }

    pub fn varnames_append(&mut self, varname: &str) {
        self.var_names.push(varname.to_string());
    }

    pub fn write_output(&self, outfile: &mut File) {
        //--------------------------------------------------------------------//
        // Write out the contents of the function.                            //
        //--------------------------------------------------------------------//
        let mut out_lines: Vec<String> = Vec::new();

        match &self.module_name {
            Some(mod_name) => {
                out_lines.push(format!("fn _m_{}__{}", 
                    mod_name, self.fn_name));
            },
            None => {
                out_lines.push(format!("fn {}", self.fn_name));
            }
        }

        if self.lines_vardecls.len() > 0 || self.fn_stk_size > 0 {
            for ln in self.lines_vardecls.iter() {
                out_lines.push(ln.to_string());
            }
            if self.fn_has_cmpres {
                out_lines.push("    var__bool _cmpres".to_string());
            }
            if self.fn_has_array_ptr {
                out_lines.push("    var__ptr _temp_ptr".to_string());
            }
            for temptype in self.fn_temp_types.clone() {
                out_lines.push(format!(
                    "    {}", temptype));
            }
            if self.fn_stk_size > 0 {
                if self.fn_stk_elem_size >= 1 {
                    let mut ind: u8 = 0;
                    loop {
                        out_lines.push(format!(
                            "    var__u8 _stk_8_{}", ind));
                        ind += 1;
                        if ind == self.fn_stk_size {
                            break
                        }
                    }
                }
                if self.fn_stk_elem_size >= 2 {
                    let mut ind: u8 = 0;
                    loop {
                        out_lines.push(format!(
                            "    var__u16 _stk_16_{}", ind));
                        ind += 1;
                        if ind == self.fn_stk_size {
                            break
                        }
                    }
                }
                if self.fn_stk_elem_size >= 3 {
                    let mut ind: u8 = 0;
                    loop {
                        out_lines.push(format!(
                            "    var__u24 _stk_24_{}", ind));
                        ind += 1;
                        if ind == self.fn_stk_size {
                            break
                        }
                    }
                }
            }
            if self.fn_loop_ctr_len_u8 > 0 {
                out_lines.push("    var__u8 _loop_len_u8".to_string());
                let mut ind: u8 = 0;
                loop {
                    out_lines.push(format!(
                        "    var__u8 _loop_ctr_u8_{}", ind));
                    ind += 1;
                    if ind == self.fn_loop_ctr_len_u8 {
                        break
                    }
                }
            }
            if self.fn_loop_ctr_len_u16 > 0 {
                out_lines.push("    var__u16 _loop_len_u16".to_string());
                let mut ind: u8 = 0;
                loop {
                    out_lines.push(format!(
                        "    var__u16 _loop_ctr_u16_{}", ind));
                    ind += 1;
                    if ind == self.fn_loop_ctr_len_u16 {
                        break
                    }
                }
            }
            if self.fn_unique_ptrs_len > 0 {
                let mut ind: usize = 0;
                loop {
                    out_lines.push(format!(
                        "    {}", self.fn_unique_ptrs[ind]));
                    ind += 1;
                    if ind == self.fn_unique_ptrs_len.into() {
                        break
                    }
                }
            }

            out_lines.push("".to_string());
        }

        if self.lines_vardefs.len() > 0 {
            for ln in self.lines_vardefs.iter() {
                out_lines.push(ln.to_string());
            }
            out_lines.push("".to_string());
        }

        for ln in self.lines_main.iter() {
            out_lines.push(ln.to_string());
        }

        out_lines.push("endfn".to_string());
        out_lines.push("".to_string());

        for ln in out_lines.iter() {
            writeln!(outfile, "{}", ln).unwrap();
        }
    }
}

static mut ACTIVE_FN:       String = String::new();
static mut ACTIVE_DEFBLK:   String = String::new();
static mut PLATFORM:        String = String::new();
static mut OUTPUT_FILENAME: String = String::new();
static mut DEF_BLOCKS:      Vec<DefBlock> = Vec::new();
static mut FN_BLOCKS:       Vec<FnBlock> = Vec::new();

// pub fn show_active_fn_args() {
//     unsafe {
//         for fn_blk in FN_BLOCKS.iter() {
//             if fn_blk.fn_name == ACTIVE_FN {
//                 // return true;
//                 println!("{}:", ACTIVE_FN);
//                 for name in fn_blk.var_names.iter() {
//                     println!(" * `{}`", name);
//                 }
//                 return;
//             }
//         }
//     }
// }

pub fn defblk_is_defined(defblk_name: &str) -> bool {
    unsafe {
        for def_blk in DEF_BLOCKS.iter() {
            if def_blk.blk_name == defblk_name {
                return true;
            }
        }
    }
    return false;
}

pub fn defblk_is_active() -> bool {
    unsafe {
        if ACTIVE_DEFBLK != "~" {
            return true;
        }
    }
    return false;
}

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

pub fn get_active_defblk() -> String {
    unsafe {
        return ACTIVE_DEFBLK.clone();
    }
}

pub fn get_active_fn() -> String {
    unsafe {
        return ACTIVE_FN.clone();
    }
}

pub fn get_required_fn_arg_count(fn_name: &str) -> Option<u8> {
    unsafe {
        for fn_blk in FN_BLOCKS.iter() {
            if fn_blk.fn_name == fn_name {
                // return true;
                return Some(fn_blk.fn_args.len().try_into().unwrap());
            }
        }
    }
    return None;
}

pub fn varname_is_fn_arg_in_active_fn(arg_name: &str) -> bool {
    unsafe {
        let last_ind = FN_BLOCKS.len() - 1;
        return FN_BLOCKS[last_ind].varname_is_fn_arg(arg_name);
    }
}

pub fn get_fn_arg_type_by_pos(fn_name: &str, arg_pos: usize) -> Option<String> {
    unsafe {
        for fn_blk in FN_BLOCKS.iter() {
            if fn_blk.fn_name == fn_name {
                return Some(fn_blk.fn_args[arg_pos].arg_type.clone());
            }
        }
        return None;
    }
}

pub fn get_fn_arg_type_by_name(fn_name: &str, arg_name: &str) -> Option<String> {
    unsafe {
        for fn_blk in FN_BLOCKS.iter() {
            if fn_blk.fn_name == fn_name {
                return Some(fn_blk.get_fn_arg_vartype(arg_name).clone());
            }
        }
        return None;
    }
}

pub fn get_fn_arg_varname_by_pos(fn_name: &str, arg_pos: usize) -> Option<String> {
    unsafe {
        for fn_blk in FN_BLOCKS.iter() {
            if fn_blk.fn_name == fn_name {
                // return true;
                let unresolved: String = fn_blk.fn_args[arg_pos].arg_name.clone();
                return Some(fn_blk.get_fn_arg_varname(&unresolved));
                // return Some(fn_blk.fn_args[arg_pos].arg_name.clone());
            }
        }
        return None;
    }
}

pub fn get_fn_arg_varname_in_active_fn(arg_name: &str) -> String {
    unsafe {
        let last_ind = FN_BLOCKS.len() - 1;
        return FN_BLOCKS[last_ind].get_fn_arg_varname(arg_name);
    }
}

pub fn set_output_filename(outname: &str) {
    unsafe {
        OUTPUT_FILENAME = outname.to_string();
    }
}

pub fn mark_temptype_in_active_fn(temptype: &str) {
    unsafe {
        let last_ind = FN_BLOCKS.len() - 1;
        FN_BLOCKS[last_ind].mark_temptype_in_fn(temptype);
    }
}

pub fn set_cmpres_in_active_fn() {
    unsafe {
        let last_ind = FN_BLOCKS.len() - 1;
        FN_BLOCKS[last_ind].set_cmpres_in_fn();
    }
}

pub fn set_array_ptr_in_active_fn() {
    unsafe {
        let last_ind = FN_BLOCKS.len() - 1;
        FN_BLOCKS[last_ind].set_array_ptr_in_fn();
    }
}

pub fn set_fn_args_in_active_fn(fn_args: Vec<FnArg>) {
    unsafe {
        let last_ind = FN_BLOCKS.len() - 1;
        FN_BLOCKS[last_ind].set_fn_args(fn_args);
    }
}

pub fn update_active_fn_stack(stk_len: u8, elem_size: u8) {
    unsafe {
        let last_ind = FN_BLOCKS.len() - 1;
        FN_BLOCKS[last_ind].update_fn_stack(stk_len, elem_size);
    }
}

pub fn set_active_defblk(defblk_name: &str) {
    unsafe {
        ACTIVE_DEFBLK = defblk_name.to_string();

        DEF_BLOCKS.push(new_def_block(defblk_name));
    }
}

pub fn get_platform() -> String {
    unsafe {
        return PLATFORM.clone();
    }
}

pub fn set_platform(platform: &str) {
    match &platform[..] {
        "c64" => {
            unsafe {
                PLATFORM = platform.to_string();
            }
        },
        "f256k" => {
            unsafe {
                PLATFORM = platform.to_string();
            }
        },
        "x16" => {
            unsafe {
                PLATFORM = platform.to_string();
            }
        },
        _ => {
            println!("TODO: Unsupported platform `{}`.", &platform);
        }
    }
}

pub fn set_active_fn(fn_name: &str) {
    if fn_name == "" {
        return
    }
    unsafe {
        ACTIVE_FN = fn_name.to_string();

        FN_BLOCKS.push(new_fn_block(fn_name));
    }
}

pub fn defblk_push(defname: &str, defvalue: &str) {
    unsafe {
        let last_ind = DEF_BLOCKS.len() - 1;
        DEF_BLOCKS[last_ind].defblk_push(defname, defvalue);
    }
}

pub fn loop_ctr_types_push(looptype: &str) -> bool {
    unsafe {
        let last_ind = FN_BLOCKS.len() - 1;
        return FN_BLOCKS[last_ind].loop_ctr_types_push(looptype);
    }
}

pub fn loop_ctr_types_pop() -> Option<String> {
    unsafe {
        let last_ind = FN_BLOCKS.len() - 1;
        return FN_BLOCKS[last_ind].loop_ctr_types_pop();
    }
}

pub fn get_loop_ctr_tempvar() -> Option<String> {
    unsafe {
        let last_ind = FN_BLOCKS.len() - 1;
        return FN_BLOCKS[last_ind].get_loop_ctr_tempvar();
    }
}

pub fn get_unique_ptr_var(basetype: &str) -> Option<String> {
    unsafe {
        let last_ind = FN_BLOCKS.len() - 1;
        return FN_BLOCKS[last_ind].get_unique_ptr_var(basetype);
    }
}

pub fn set_var_index(varname: &str) {
    unsafe {
        let last_ind = FN_BLOCKS.len() - 1;
        FN_BLOCKS[last_ind].set_var_index(varname);
    }
}

pub fn preproc_def_exists(defname: &str) -> bool {
    unsafe {
        for def_blk in DEF_BLOCKS.iter() {
            for blk_defname in def_blk.def_names.iter() {
                if defname == blk_defname {
                    return true;
                }
            }
        }
    }
    return false;
}

pub fn preproc_get_def_str(defname: &str) -> Option<String> {
    let mut def_ind: usize;
    unsafe {
        for def_blk in DEF_BLOCKS.iter() {
            def_ind = 0;
            for blk_defname in def_blk.def_names.iter() {
                if defname == blk_defname {
                    return Some(def_blk.def_values[def_ind].clone());
                }
                def_ind += 1;
            }
        }
    }
    return None;
}

pub fn get_vartype(varname: &str) -> Option<String> {
    unsafe {
        let last_ind = FN_BLOCKS.len() - 1;
        return FN_BLOCKS[last_ind].get_vartype(varname);
    }
}

pub fn blktypes_push(blktype: &str) {
    unsafe {
        let last_ind = FN_BLOCKS.len() - 1;
        FN_BLOCKS[last_ind].blktypes_push(blktype);
    }
}

pub fn blktypes_peek() -> Option<String> {
    unsafe {
        let last_ind = FN_BLOCKS.len() - 1;
        return FN_BLOCKS[last_ind].blktypes_peek();
    }
}

pub fn blktypes_pop() -> Option<String> {
    unsafe {
        let last_ind = FN_BLOCKS.len() - 1;
        return FN_BLOCKS[last_ind].blktypes_pop();
    }
}

pub fn blktypes_has_loop() -> bool {
    unsafe {
        let last_ind = FN_BLOCKS.len() - 1;
        return FN_BLOCKS[last_ind].blktypes_has_loop();
    }
}

pub fn blktypes_has_named_loop(loopname: &str) -> bool {
    unsafe {
        let last_ind = FN_BLOCKS.len() - 1;
        return FN_BLOCKS[last_ind].blktypes_has_named_loop(loopname);
    }
}

pub fn lines_vardecl_push(decl_ln: &str) {
    unsafe {
        let last_ind = FN_BLOCKS.len() - 1;
        return FN_BLOCKS[last_ind].lines_vardecls_push(decl_ln);
    }
}

pub fn lines_vardef_push(def_ln: &str) {
    unsafe {
        let last_ind = FN_BLOCKS.len() - 1;
        return FN_BLOCKS[last_ind].lines_vardef_push(def_ln);
    }
}

pub fn lines_main_push(ln: &str) {
    unsafe {
        let last_ind = FN_BLOCKS.len() - 1;
        return FN_BLOCKS[last_ind].lines_main_push(ln);
    }
}

pub fn vartypes_append(vartype: &str) {
    unsafe {
        let last_ind = FN_BLOCKS.len() - 1;
        return FN_BLOCKS[last_ind].vartypes_append(vartype);
    }
}

pub fn varnames_append(varname: &str) {
    unsafe {
        let last_ind = FN_BLOCKS.len() - 1;
        return FN_BLOCKS[last_ind].varnames_append(varname);
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

    unsafe {
        for fn_blk in &mut FN_BLOCKS {
            fn_blk.write_output(&mut outfile);
        }
    }

    return false;
}
