use std::fs;

fn main() {
    let file = fs::read_to_string("example.txt").unwrap();
    file.lines().for_each(|line| print!("{line}\n"))
}
