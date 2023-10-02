use std::fmt::format;
use std::fs::{File, OpenOptions};
use std::io::{BufRead, BufReader, Read, Seek, Write};
use std::vec;

use regex::Regex;

#[derive(Clone)]
struct XkbEntry {
    name: String,
    is_active: bool,
    bracket_count: i32,
    is_done: bool,
}

impl XkbEntry {
    fn new(name: &str) -> Self {
        Self {
            name: name.to_string(),
            is_active: false,
            bracket_count: 0,
            is_done: false,
        }
    }
    fn set_current_line(&mut self, line: &str) {
        if line.contains(&self.name) {
            println!("{} entry found at line: {}", self.name, line);
            self.is_active = true;
        }

        if !self.is_active {
            return;
        }

        if self.is_done {
            self.is_active = false;
        }

        if line.contains("{") {
            self.bracket_count += 1;
            // return;
        }

        if line.contains("}") {
            self.bracket_count -= 1;
            if self.bracket_count == 0 {
                self.is_done = true;
            }
            return;
        }

        if self.bracket_count == 0 && self.is_active {
            self.is_active = false;
            self.is_done = true;
        }
    }
}

#[derive(Clone)]
#[derive(Copy)]
struct KeyInfo {
    code: &'static str,
    base_symbol: &'static str,
    shift_symbol: &'static str,
}

#[derive(Clone)]
#[derive(Copy)]
struct MappedKey {
    symbol: &'static str, 
    action: &'static str, 
}

#[derive(Clone)]
struct Key {
    symbol: KeyInfo,
    custom_key: MappedKey,
    symbols: String,
    actions: String,
    entry: XkbEntry,
}

impl Key {
    fn new(
        symbol: KeyInfo,
        custom_key: MappedKey,
    ) -> Self {
        let _symbols = format!(
            "\t\tsymbols[Group1]= [{}, {}, {} ]",
            symbol.base_symbol, symbol.shift_symbol, custom_key.symbol
        );
        let _actions = format!(
            ",\n\t\tactions[Group1]= [NoAction(),NoAction(),RedirectKey(keycode=<{}>,clearmods=Lock) ]",
            custom_key.action
        );
        Self {
            symbol: symbol,
            custom_key: custom_key,
            symbols: _symbols,
            actions: _actions,
            entry: XkbEntry::new(symbol.code),
        }
    }

    fn new_modifier(symbol: KeyInfo, new_key: &str) -> Self {
        let _symbols = format!("\t\tsymbols[Group1]= [{}, {} ],\n", symbol.base_symbol, symbol.shift_symbol);
        let _actions = format!(
            "\t\tactions[Group1]= [      NoAction(),      NoAction(),   RedirectKey(keycode=<{}>,clearmods=Lock,modifiers=Control+Shift) ]",
            new_key
        );
        Self {
            symbol: symbol,
            custom_key: MappedKey { symbol: "", action: "" },
            symbols: _symbols,
            actions: _actions,
            entry: XkbEntry::new(symbol.code),
        }
    }

    fn new_map(symbol: KeyInfo, custom_key: MappedKey) -> Self {
        let _symbols = format!(
            "\t\tsymbols[Group1]= [{}, {}, {} ]\n",
            symbol.base_symbol,symbol.shift_symbol, custom_key.symbol
        );
        let _actions = String::new();
        Self {
            symbol: symbol,
            custom_key: custom_key,
            symbols: _symbols,
            actions: _actions,
            entry: XkbEntry::new(symbol.code),
        }
    }

    fn new_mod(symbol: KeyInfo, modifier: &str) -> Self {
        let _symbols = format!("\t\tsymbols[Group1]= [{}, {} ],\n", symbol.base_symbol, symbol.shift_symbol);
        let _actions = format!(
            "\t\tactions[Group1]= [      NoAction(),      NoAction(),   SetMods(modifiers={}) ]",
            modifier
        );
        Self {
            symbol: symbol,
            custom_key: MappedKey { symbol:"", action: "" },
            symbols: _symbols,
            actions: _actions,
            entry: XkbEntry::new(symbol.code),
        }
    }

    fn formatted_entry(&mut self) -> String {
        let begin = "key <".to_string();
        let end = ">".to_string();
        let formatted_key = begin + &self.symbol.code + &end;

        let mut out = String::new();
        out.push_str(format!("\t{} {{\n", formatted_key).as_str());
        out.push_str(format!("\t\ttype= \"CUST_CAPSLOCK\",\n").as_str());

        if !self.symbols.is_empty() {
            out.push_str(&self.symbols);
        }
        if !self.actions.is_empty() {
            out.push_str(&self.actions);
            // out.push_str(format!(",\n\t\tactions[Group1]= [NoAction(),NoAction(),RedirectKey(keycode=<{}>,clearmods=Lock) ]\n", &self.new_keycode).as_str());
        }
        out.push_str("\t};\n");
        return out;
    }
}


const KEY_A: KeyInfo = KeyInfo {
    code: "AC01",
    base_symbol: "a",
    shift_symbol: "A",
};
const KEY_D: KeyInfo = KeyInfo {
    code: "AC03",
    base_symbol: "d",
    shift_symbol: "D",
};
const KEY_E: KeyInfo = KeyInfo {
    code: "AD03",
    base_symbol: "e",
    shift_symbol: "E",
};
const KEY_F: KeyInfo = KeyInfo {
    code: "AC04",
    base_symbol: "f",
    shift_symbol: "F",
};
const KEY_H: KeyInfo = KeyInfo {
    code: "AC06",
    base_symbol: "h",
    shift_symbol: "H",
};
const KEY_I: KeyInfo = KeyInfo {
    code: "AD08",
    base_symbol: "i",
    shift_symbol: "I",
};
const KEY_J: KeyInfo = KeyInfo {
    code: "AC07",
    base_symbol: "j",
    shift_symbol: "J",
};
const KEY_K: KeyInfo = KeyInfo {
    code: "AC08",
    base_symbol: "k",
    shift_symbol: "K",
};
const KEY_L: KeyInfo = KeyInfo {
    code: "AC09",
    base_symbol: "l",
    shift_symbol: "L",
};
const KEY_M: KeyInfo = KeyInfo {
    code: "AB07",
    base_symbol: "m",
    shift_symbol: "M",
};
const KEY_N: KeyInfo = KeyInfo {
    code: "AB06",
    base_symbol: "n",
    shift_symbol: "N",
};
const KEY_O: KeyInfo = KeyInfo {
    code: "AD09",
    base_symbol: "o",
    shift_symbol: "O",
};
const KEY_Q: KeyInfo = KeyInfo {
    code: "AD01",
    base_symbol: "q",
    shift_symbol: "Q",
};
const KEY_R: KeyInfo = KeyInfo {
    code: "AD04",
    base_symbol: "r",
    shift_symbol: "R",
};
const KEY_U: KeyInfo = KeyInfo {
    code: "AD07",
    base_symbol: "u",
    shift_symbol: "U",
};
const KEY_V: KeyInfo = KeyInfo {
    code: "AB04",
    base_symbol: "v",
    shift_symbol: "V",
};

const KEY_ONE: KeyInfo = KeyInfo {
    code: "AE01",
    base_symbol: "1",
    shift_symbol: "exclam",
};
const KEY_TWO: KeyInfo = KeyInfo {
    code: "AE02",
    base_symbol: "2",
    shift_symbol: "at",
};
const KEY_THREE: KeyInfo = KeyInfo {
    code: "AE03",
    base_symbol: "3",
    shift_symbol: "numbersign",
};
const KEY_FOUR: KeyInfo = KeyInfo {
    code: "AE05",
    base_symbol: "5",
    shift_symbol: "percent",
};

const KEY_APOSTROPHE: KeyInfo = KeyInfo {
    code: "AC11",
    base_symbol: "apostrophe",
    shift_symbol: "quotedbl",
};
const KEY_BRACKETLEFT: KeyInfo = KeyInfo {
    code: "AD11",
    base_symbol: "bracketleft",
    shift_symbol: "braceleft",
};
const KEY_SEMICOLON: KeyInfo = KeyInfo {
    code: "AC10",
    base_symbol: "semicolon",
    shift_symbol: "colon",
};

const KEY_W: KeyInfo = KeyInfo {
    code: "AD02",
    base_symbol: "w",
    shift_symbol: "W",
};

const KEY_T: KeyInfo = KeyInfo {
    code: "AD05",
    base_symbol: "t",
    shift_symbol: "T",
};

// --

const KEY_DELE: MappedKey = MappedKey{ symbol: "Delete", action: "DELE"};
const KEY_FK17: MappedKey = MappedKey{ symbol: "XF86Launch8", action: "FK17"};
const KEY_RTRN: MappedKey = MappedKey{ symbol: "Return", action: "RTRN"};
const KEY_I171: MappedKey = MappedKey{ symbol: "XF86AudioNext", action: "I171"};
const KEY_UP: MappedKey = MappedKey{ symbol: "Up", action: "UP"};
const KEY_LEFT: MappedKey = MappedKey{ symbol: "Left", action: "LEFT"};
const KEY_DOWN: MappedKey = MappedKey{ symbol: "Down", action: "DOWN"};
const KEY_RGHT: MappedKey = MappedKey{ symbol: "Right", action: "RGHT"};
const KEY_PGDN: MappedKey = MappedKey{ symbol: "Next", action: "PGDN"};
const KEY_PGUP: MappedKey = MappedKey{ symbol: "Prior", action: "PGUP"};
const KEY_END: MappedKey = MappedKey{ symbol: "End", action: "END"};
const KEY_ESC: MappedKey = MappedKey{ symbol: "Escape", action: "ESC"};
const KEY_FK18: MappedKey = MappedKey{ symbol: "XF86Launch9", action: "FK18"};
const KEY_HOME: MappedKey = MappedKey{ symbol: "Home", action: "HOME"};
const KEY_I211: MappedKey = MappedKey{ symbol: "XF86Launch4", action: "I211"};
const KEY_FK14: MappedKey = MappedKey{ symbol: "XF86Launch5", action: "FK14"};
const KEY_FK15: MappedKey = MappedKey{ symbol: "XF86Launch6", action: "FK15"};
const KEY_FK16: MappedKey = MappedKey{ symbol: "XF86Launch7", action: "FK16"};
const KEY_FK05: MappedKey = MappedKey{ symbol: "F5", action: "FK05"};

const KEY_AE: MappedKey = MappedKey{ symbol: "ae", action: ""};
const KEY_ARING: MappedKey = MappedKey{ symbol: "aring", action: ""};
const KEY_OSLASH: MappedKey = MappedKey{ symbol: "oslash", action: ""};

fn main() {
    const FILENAME: &str = "/home/jk/linux-config/xkeyboard_patcher/original.xkb";
    const OUTPUT_FILENAME: &str = "output.xkb";
    const INPUT_FILENAME: &str = "/home/jk/linux-config/xkeyboard_patcher/powercaps.txt";

    let mut output = File::create(&OUTPUT_FILENAME).expect("Failed to open output file");
    let file = File::open(&FILENAME).expect("Failed to open file");
    let reader = BufReader::new(file);

    let keys = vec![
        Key::new_map(KEY_APOSTROPHE, KEY_AE),
        Key::new_map(KEY_BRACKETLEFT, KEY_ARING),
        Key::new_map(KEY_SEMICOLON, KEY_OSLASH),
        Key::new_mod(KEY_A, "Control"), // no key

        Key::new(KEY_D, KEY_DELE),
        Key::new(KEY_E, KEY_FK17), // code: glob.search.prev
        Key::new(KEY_F, KEY_RTRN),
        Key::new(KEY_H, KEY_I171),
        Key::new(KEY_I, KEY_UP),
        Key::new(KEY_J, KEY_LEFT),
        Key::new(KEY_K, KEY_DOWN),
        Key::new(KEY_L, KEY_RGHT),
        Key::new(KEY_M, KEY_PGDN),
        Key::new(KEY_N, KEY_PGUP),
        Key::new(KEY_O, KEY_END),
        Key::new(KEY_Q, KEY_ESC),
        Key::new(KEY_R, KEY_FK18), // code: glob.search.next
        Key::new(KEY_U, KEY_HOME),
        Key::new(KEY_V, KEY_I211), // copy-history: $ sleep 5 && xdotool key XF86Launch4
        Key::new(KEY_ONE, KEY_FK14), // code: editor.action.previousMatchFindAction
        Key::new(KEY_TWO, KEY_FK15),     // code: actions.findWithSelection
        Key::new(KEY_THREE, KEY_FK16), // code: editor.action.nextMatchFindAction
        Key::new(KEY_FOUR, KEY_FK05),

        Key::new_modifier(KEY_T, "AC04"), // code: glob.search.prev
    ];

    let mut current_key: Option<Key> = None;

    let mut xkb_types = XkbEntry::new("xkb_types");
    let mut xkb_symbols = XkbEntry::new("xkb_symbols");
    let mut xkb_caps_lock = XkbEntry::new("interpret Caps_Lock+AnyOfOrNone(all)");

    for line in reader.lines() {
        let line = line.expect("Failed to read line");

        xkb_types.set_current_line(&line);
        xkb_symbols.set_current_line(&line);
        xkb_caps_lock.set_current_line(&line);

        // Add type
        if xkb_types.is_active && xkb_types.bracket_count == 0 {
            let mut input_file = File::open(&INPUT_FILENAME).expect("Failed to open input file");
            let mut contents = String::new();
            match input_file.read_to_string(&mut contents) {
                Ok(_) => (),
                Err(_) => {
                    println!("Failed to read input string");
                    return;
                }
            }

            match output.write_all(contents.as_bytes()) {
                Ok(_) => (),
                Err(_) => {
                    println!("Failed to write output file");
                    return;
                }
            }
        }

        // Map caps
        if xkb_caps_lock.is_active && xkb_caps_lock.bracket_count == 0 {
            println!("input: {}", line);
            let content = "\t\taction= SetMods(modifiers=Lock);\n";
            match output.write_all(content.as_bytes()) {
                Ok(_) => (),
                Err(_) => {
                    println!("Failed to write output file");
                    return;
                }
            }
        }

        if xkb_caps_lock.is_active {
            if line.contains("action= LockMods(modifiers=Lock);") {
                println!("Skipping: {}", line);
                continue;
            }
        }

        // Add symbols
        if xkb_symbols.is_active && !xkb_symbols.is_done {
            if current_key.is_none() {
                //
                let pattern = Regex::new(r"key <.{4}>").unwrap();
                if pattern.is_match(&line) {
                    let start = &line.find('<').unwrap() + 1;
                    let end = line.find('>').unwrap();
                    let result = &line[start..end];

                    //check if we have this symbol
                    for mut symbol in &keys {
                        if symbol.symbol.code.contains(result) {
                            // let mykey = current_key.as_mut().unwrap();
                            current_key = Some(symbol.clone());
                            // mykey = current_key.expect("O");
                            println!("Patching key {}", current_key.as_ref().unwrap().symbol.base_symbol)
                        }
                    }
                }
            }

            if current_key.as_ref().is_some() && current_key.as_ref().unwrap().entry.is_done {
                let foo = line.find('<');
                if foo.is_none() {
                    match output.write(format!("{}\n", line).as_bytes()) {
                        Ok(_) => (),
                        Err(_) => {
                            println!("Failed to write line to output file");
                            return;
                        }
                    }
                    continue;
                }

                let start = line.find('<').unwrap() + 1;
                let end = line.find('>').unwrap();
                let result = &line[start..end];
                // println!("{}", result);

                //check if we have this symbol
                for mut symbol in &keys {
                    if symbol.symbol.code.contains(result) {
                        // let mykey = current_key.as_mut().unwrap();
                        current_key = Some(symbol.clone());
                        // mykey = current_key.expect("O");
                        println!("Patching key {}", current_key.as_ref().unwrap().symbol.base_symbol)
                    }
                }
            }

            if current_key.is_none() {
                // write file
                match output.write(format!("{}\n", line).as_bytes()) {
                    Ok(_) => (),
                    Err(_) => {
                        println!("Failed to write line to output file");
                        return;
                    }
                }
                continue;
            }

            let mykey = current_key.as_mut().unwrap();

            mykey.entry.set_current_line(&line);

            let begin = "key <".to_string();
            let end = ">".to_string();
            let formatted_key = begin + &mykey.symbol.code + &end;

            if line.contains(&formatted_key) {
                println!("Found symbol {} ", formatted_key);

                let out = mykey.formatted_entry();

                println!("Writing new key: \n{}", out);
                match output.write(format!("{}\n", out).as_bytes()) {
                    Ok(_) => (),
                    Err(_) => {
                        println!("Failed to write line to output file");
                        return;
                    }
                }

                continue;
            }

            if mykey.entry.is_active {
                println!("Skip writing line: {}", line);
                continue;
            }
        }

        match output.write(format!("{}\n", line).as_bytes()) {
            Ok(_) => (),
            Err(_) => {
                println!("Failed to write line to output file");
                return;
            }
        }
    }
}
