fn main() {
    let x: u32 = "this is not a u32";  // deliberate type error for CI smoke test
    println!("{}", x)
}
