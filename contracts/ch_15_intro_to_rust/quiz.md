[
  {
    "id": 1,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "A scripting language that runs line by line inside a browser sandbox" },
      { "id": "b", "text": "A systems programming language that guarantees memory safety at compile time — without a garbage collector" },
      { "id": "c", "text": "A database query language for managing large datasets" },
      { "id": "d", "text": "A visual programming tool for building user interfaces" }
    ],
    "question": "Which description best defines the Rust programming language?"
  },
  {
    "id": 2,
    "type": "TF",
    "answer": false,
    "points": 1,
    "question": "Rust achieves memory safety by running a garbage collector in the background while your program executes."
  },
  {
    "id": 3,
    "type": "MCQ",
    "answer": "c",
    "points": 1,
    "choices": [
      { "id": "a", "text": "Rust programs are interpreted line by line by software preinstalled on every computer" },
      { "id": "b", "text": "The desktop downloads the Rust toolchain automatically the first time the program runs" },
      { "id": "c", "text": "Compiling Rust produces a standalone native binary — no interpreter or runtime installation is required to run it" },
      { "id": "d", "text": "Rust programs only run on machines that already have cargo installed" }
    ],
    "question": "Dan compiles his Rust program on his laptop, copies it to the carinderia's offline desktop on a USB, and it runs with nothing installed. Why does this work?"
  },
  {
    "id": 4,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "rustup — the compiler; rustc — the package manager; cargo — the installer" },
      { "id": "b", "text": "rustup — toolchain installer and version manager; rustc — the compiler; cargo — build tool and package manager" },
      { "id": "c", "text": "rustup — the build tool; rustc — the version manager; cargo — the compiler" },
      { "id": "d", "text": "All three are interchangeable names for the same program" }
    ],
    "question": "Which option correctly matches each Rust tool to its role?"
  },
  {
    "id": 5,
    "type": "FIB",
    "answer": "cargo",
    "points": 1,
    "question": "Rust's build tool and package manager — the command you use daily to create, build, run, and test projects — is called ______."
  },
  {
    "id": 6,
    "type": "MCQ",
    "answer": "a",
    "points": 1,
    "choices": [
      { "id": "a", "text": "Execution starts in fn main, and println! is a macro — the exclamation mark marks it as one" },
      { "id": "b", "text": "Execution starts at the first line of the file, and println! is an ordinary function" },
      { "id": "c", "text": "Execution starts in a function named start, and printing requires installing an external crate" },
      { "id": "d", "text": "Rust programs have no fixed entry point; any function can run first" }
    ],
    "question": "In a minimal Rust program like Hello World, which statement is correct?"
  },
  {
    "id": 7,
    "type": "TF",
    "answer": false,
    "points": 1,
    "question": "A variable declared with a plain `let` in Rust can be freely reassigned later, just like a variable in Python."
  },
  {
    "id": 8,
    "type": "FIB",
    "answer": "mut",
    "points": 1,
    "question": "To allow a `let` variable's value to change after it is first assigned, you add the keyword ______ right after `let`."
  },
  {
    "id": 9,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "Hiding a variable from other modules using a privacy keyword" },
      { "id": "b", "text": "Declaring a new variable with `let` that reuses an existing name, replacing the old binding — even with a different type" },
      { "id": "c", "text": "Creating a backup copy of a variable in case the original is dropped" },
      { "id": "d", "text": "Marking a variable as deprecated so the compiler warns when it is used" }
    ],
    "question": "What is shadowing in Rust?"
  },
  {
    "id": 10,
    "type": "MCQ",
    "answer": "c",
    "points": 1,
    "choices": [
      { "id": "a", "text": "Rust does not support floating-point numbers at all" },
      { "id": "b", "text": "Integers can hold larger maximum values than any float" },
      { "id": "c", "text": "Floats cannot represent some decimal fractions exactly, so centavo amounts can silently pick up rounding errors — integer centavos stay exact" },
      { "id": "d", "text": "Floats are not allowed inside `println!` output" }
    ],
    "question": "Why does the course store money amounts (like carinderia prices in centavos) in an integer type such as `u32` instead of a float like `f64`?"
  },
  {
    "id": 11,
    "type": "TF",
    "answer": true,
    "points": 1,
    "question": "Rust's `char` type is four bytes wide and can hold any Unicode scalar value, such as '₱'."
  },
  {
    "id": 12,
    "type": "MCQ",
    "answer": "a",
    "points": 1,
    "choices": [
      { "id": "a", "text": "Its body ends with an expression that has no trailing semicolon — that expression's value becomes the return value" },
      { "id": "b", "text": "It assigns the value to a special variable named `result`" },
      { "id": "c", "text": "It prints the value with `println!`, and the caller reads it from the console" },
      { "id": "d", "text": "It cannot — every Rust function must use an explicit `return` statement" }
    ],
    "question": "How does a Rust function return a value without using the `return` keyword?"
  },
  {
    "id": 13,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "Any non-zero number or non-empty string counts as true, like in some other languages" },
      { "id": "b", "text": "The condition must evaluate to a `bool`, and `if` is itself an expression — so it can produce a value assigned with `let`" },
      { "id": "c", "text": "The condition requires parentheses, and the branches can never produce values" },
      { "id": "d", "text": "`if` can only appear inside `match` arms" }
    ],
    "question": "Which statement about `if` in Rust is correct?"
  },
  {
    "id": 14,
    "type": "MCQ",
    "answer": "c",
    "points": 1,
    "choices": [
      { "id": "a", "text": "repeat, until, foreach" },
      { "id": "b", "text": "while, do-while, goto" },
      { "id": "c", "text": "loop, while, for" },
      { "id": "d", "text": "for, map, reduce" }
    ],
    "question": "Which option correctly lists Rust's three looping constructs?"
  },
  {
    "id": 15,
    "type": "TF",
    "answer": true,
    "points": 1,
    "question": "Running `cargo run --release` compiles with optimizations enabled, producing a faster binary than the default debug build."
  },
  {
    "id": 16,
    "type": "MCQ",
    "answer": "a",
    "points": 1,
    "choices": [
      { "id": "a", "text": "Each value has an owner; there can be only one owner at a time; when the owner goes out of scope, the value is dropped" },
      { "id": "b", "text": "Each value has an owner; values can have many owners at once; values are freed by a garbage collector" },
      { "id": "c", "text": "Only structs have owners; ownership is optional; values live until the program ends" },
      { "id": "d", "text": "Each function owns all of its variables forever; ownership can never be transferred" }
    ],
    "question": "Which option correctly states all three rules of ownership in Rust?"
  },
  {
    "id": 17,
    "type": "MCQ",
    "answer": "c",
    "points": 1,
    "choices": [
      { "id": "a", "text": "It works fine — both variables share the data safely" },
      { "id": "b", "text": "It compiles, but reading `s1` crashes the program at runtime" },
      { "id": "c", "text": "Compilation fails with error E0382 (borrow of moved value) — ownership moved to `s2`; call `.clone()` if you need an independent copy" },
      { "id": "d", "text": "`s1` automatically becomes an empty string" }
    ],
    "question": "After `let s2 = s1;` where `s1` is a `String`, what happens if the code tries to use `s1` again?"
  },
  {
    "id": 18,
    "type": "TF",
    "answer": true,
    "points": 1,
    "question": "Integer types like `u32` implement the `Copy` trait, so assigning one variable to another copies the value instead of moving it."
  },
  {
    "id": 19,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "You can have unlimited mutable references as long as they live in different functions" },
      { "id": "b", "text": "At any given time you can have either any number of immutable references (&) or exactly one mutable reference (&mut) — never both at once" },
      { "id": "c", "text": "References are only allowed to types that implement `Copy`" },
      { "id": "d", "text": "Each value allows at most one reference of any kind during its entire lifetime" }
    ],
    "question": "Which option correctly states Rust's borrowing rule?"
  },
  {
    "id": 20,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "A growable copy of part of a collection, stored in its own heap allocation" },
      { "id": "b", "text": "A view (reference) into a contiguous portion of existing data — no copying involved" },
      { "id": "c", "text": "A compressed version of the original data" },
      { "id": "d", "text": "A special kind of loop for iterating over arrays" }
    ],
    "question": "In Rust, what is a slice (like `&str` or `&[T]`)?"
  },
  {
    "id": 21,
    "type": "MCQ",
    "answer": "a",
    "points": 1,
    "choices": [
      { "id": "a", "text": "`String` is an owned, growable string allocated on the heap; `&str` is a borrowed view into string data — and `format!` builds a new `String` from a template" },
      { "id": "b", "text": "`String` is for ASCII text only, while `&str` supports Unicode" },
      { "id": "c", "text": "They are identical; `&str` is just an older spelling of `String`" },
      { "id": "d", "text": "`&str` is mutable by default, while a `String` can never change" }
    ],
    "question": "Which correctly describes `String` and `&str`?"
  },
  {
    "id": 22,
    "type": "TF",
    "answer": false,
    "points": 1,
    "question": "In a Rust `String`, every character occupies exactly one byte of memory."
  },
  {
    "id": 23,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "Methods must be written inside the struct's curly braces, next to its fields" },
      { "id": "b", "text": "Methods are defined in an `impl` block, and adding `#[derive(Debug)]` lets instances be printed with the `{:?}` formatter" },
      { "id": "c", "text": "Structs cannot have methods; only enums can" },
      { "id": "d", "text": "Every struct automatically implements every trait in the standard library" }
    ],
    "question": "Which statement about Rust structs is correct?"
  },
  {
    "id": 24,
    "type": "MCQ",
    "answer": "c",
    "points": 1,
    "choices": [
      { "id": "a", "text": "With a special `null` value that any type can hold" },
      { "id": "b", "text": "With a -1 or empty-string sentinel value by convention" },
      { "id": "c", "text": "With the `Option<T>` enum — `Some(value)` when present, `None` when absent — so the missing case must be handled explicitly" },
      { "id": "d", "text": "With a global error flag that functions set when data is missing" }
    ],
    "question": "How does Rust represent a value that might be absent — like a menu item that may not exist?"
  },
  {
    "id": 25,
    "type": "TF",
    "answer": true,
    "points": 1,
    "question": "Rust enum variants can carry data — for example, a `Payment::GCash(String)` variant holding a reference number."
  },
  {
    "id": 26,
    "type": "FIB",
    "answer": "match",
    "points": 1,
    "question": "The Rust keyword that compares a value against a series of patterns and requires every possible case to be handled is ______."
  },
  {
    "id": 27,
    "type": "MCQ",
    "answer": "a",
    "points": 1,
    "choices": [
      { "id": "a", "text": "When you care about only one pattern (like `Some(price)`) and want to ignore every other case concisely" },
      { "id": "b", "text": "When you need the compiler to verify that every variant is handled" },
      { "id": "c", "text": "When the value being tested is a number rather than an enum" },
      { "id": "d", "text": "When you need the code to run faster — `if let` compiles to faster machine code than `match`" }
    ],
    "question": "When is `if let` a better fit than a full `match`?"
  },
  {
    "id": 28,
    "type": "MCQ",
    "answer": "d",
    "points": 1,
    "choices": [
      { "id": "a", "text": "It panics immediately if the value is an `Err`" },
      { "id": "b", "text": "It converts the `Result` into an `Option`, discarding any error message" },
      { "id": "c", "text": "It retries the failed operation until it succeeds" },
      { "id": "d", "text": "If the value is `Ok`, it unwraps the inner value; if it is `Err`, it returns that error from the current function right away" }
    ],
    "question": "What does the `?` operator do when placed after an expression that returns a `Result`?"
  },
  {
    "id": 29,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "It deletes the key `item` from the HashMap if its count is 0" },
      { "id": "b", "text": "It returns a mutable reference to the value for `item`, inserting 0 first if the key is not yet present — the standard tally idiom" },
      { "id": "c", "text": "It sorts the HashMap entries by value in ascending order" },
      { "id": "d", "text": "It resets the existing count to 0 every time it is called" }
    ],
    "question": "In the lunch-rush tally, what does `counts.entry(item).or_insert(0)` do?"
  },
  {
    "id": 30,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "Public — anything outside the module can use them unless marked otherwise" },
      { "id": "b", "text": "Private — they can only be used inside that module unless marked with `pub`" },
      { "id": "c", "text": "Visible to the whole package but hidden from other packages" },
      { "id": "d", "text": "There is no default; visibility must always be declared explicitly" }
    ],
    "question": "By default, how visible are the items (functions, structs, fields) inside a Rust module?"
  },
  {
    "id": 31,
    "type": "MCQ",
    "answer": "c",
    "points": 1,
    "choices": [
      { "id": "a", "text": "They are exact synonyms with no difference" },
      { "id": "b", "text": "A crate contains many packages, each with its own Cargo.toml" },
      { "id": "c", "text": "A package (defined by a Cargo.toml) can contain crates — such as a binary crate and a library crate; a crate is the unit of compilation" },
      { "id": "d", "text": "Packages only refer to code downloaded from crates.io; local code is never a package" }
    ],
    "question": "In Cargo's terminology, what is the relationship between a package and a crate?"
  },
  {
    "id": 32,
    "type": "TF",
    "answer": false,
    "points": 1,
    "question": "To use one of your own local library crates (like `lutolib`) as a dependency, you must first publish it to crates.io."
  },
  {
    "id": 33,
    "type": "MCQ",
    "answer": "a",
    "points": 1,
    "choices": [
      { "id": "a", "text": "Printing its values directly with {} in `println!` and `format!` — just as deriving `Debug` implements the `Debug` trait behind {:?}" },
      { "id": "b", "text": "Automatic conversion of the type to JSON" },
      { "id": "c", "text": "Comparing two values of the type with ==" },
      { "id": "d", "text": "Storing the type inside a `Vec`, which is otherwise forbidden" }
    ],
    "question": "What does implementing the standard `Display` trait for a type like `MenuItem` enable?"
  },
  {
    "id": 34,
    "type": "MCQ",
    "answer": "c",
    "points": 1,
    "choices": [
      { "id": "a", "text": "It checks types dynamically each time the function is called" },
      { "id": "b", "text": "It boxes every generic argument on the heap" },
      { "id": "c", "text": "Through monomorphization — the compiler generates a specialized copy of the generic code for each concrete type used" },
      { "id": "d", "text": "It restricts generics to types that have the same memory size" }
    ],
    "question": "How does Rust make generic functions cost nothing extra at runtime?"
  },
  {
    "id": 35,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "It extends how long a value lives, preventing it from being dropped" },
      { "id": "b", "text": "It describes the relationships between the lifetimes of references so the compiler can verify no reference outlives its data — it never changes how long anything lives" },
      { "id": "c", "text": "It schedules the value for cleanup after a fixed amount of time" },
      { "id": "d", "text": "It measures how many milliseconds a function takes to run" }
    ],
    "question": "What does a lifetime annotation like 'a actually do?"
  },
  {
    "id": 36,
    "type": "TF",
    "answer": false,
    "points": 1,
    "question": "Every Rust function that accepts a reference parameter must spell out an explicit lifetime annotation like <'a>."
  },
  {
    "id": 37,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "Create a separate test script and run it with an external test framework" },
      { "id": "b", "text": "Mark functions with the #[test] attribute and run `cargo test`, which finds and runs them all, reporting pass or fail for each" },
      { "id": "c", "text": "Add `assert!` calls inside `main` and run the program normally" },
      { "id": "d", "text": "Install a third-party crate first; the standard toolchain cannot run tests" }
    ],
    "question": "How do you write and run unit tests in Rust?"
  },
  {
    "id": 38,
    "type": "TF",
    "answer": true,
    "points": 1,
    "question": "A test marked #[should_panic(expected = \"kulang ang bayad\")] passes only if the code panics and the panic message contains that expected text."
  },
  {
    "id": 39,
    "type": "MCQ",
    "answer": "c",
    "points": 1,
    "choices": [
      { "id": "a", "text": "Rust cannot parse booleans from text at all" },
      { "id": "b", "text": "The CSV file was corrupted during the USB transfer" },
      { "id": "c", "text": "The file was exported from Python/pandas, which writes True with a capital T — Rust's bool parser accepts only lowercase true and false, so Dan compares fields[5] == \"True\" instead" },
      { "id": "d", "text": "`read_to_string` converts the whole file to lowercase before parsing" }
    ],
    "question": "Dan reads the sales CSV with `fs::read_to_string`, but `fields[5].parse::<bool>()` fails on the payday column. Why?"
  },
  {
    "id": 40,
    "type": "MCQ",
    "answer": "d",
    "points": 1,
    "choices": [
      { "id": "a", "text": "It reads a configuration file named summary.toml from the desktop" },
      { "id": "b", "text": "It opens a window asking her to confirm the command" },
      { "id": "c", "text": "Cargo passes the subcommand to it, so cargo must be installed on the desktop" },
      { "id": "d", "text": "It collects `std::env::args()` into a `Vec<String>` — args[0] is the program's own path, so her subcommand is args[1]" }
    ],
    "question": "On ship day, Tita Malou types `lutocli summary` on the offline desktop. How does the compiled `--release` binary know which subcommand she typed?"
  }
]
