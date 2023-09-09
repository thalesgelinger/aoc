use std::{collections::HashMap, fs};

fn main() {
    let input: String = fs::read_to_string("values.txt").expect("Should inform file path");

    let lines = input.lines();

    let map = build_letter_map();

    let mut sum_of_props = 0;

    for line in lines {
        let middle = line.len() / 2;
        let r_side = &line[0..middle];
        let l_side = &line[middle..];
        let same_letter = find_same(r_side, l_side);
        let value = map.get(&same_letter).unwrap();
        sum_of_props += value;
    }
    println!("{sum_of_props}");
}

fn find_same(r_side: &str, l_side: &str) -> char {
    let mut res = '-';
    r_side.chars().into_iter().for_each(|l| {
        if l_side.contains(l) {
            res = l;
        }
    });
    res
}

fn build_letter_map() -> HashMap<char, usize> {
    let mut letters_map = HashMap::new();

    let lower_letters = ('a'..='z').enumerate();
    let upper_letters = ('A'..='Z').enumerate();

    lower_letters.for_each(|(i, v)| {
        letters_map.insert(v, i + 1);
    });

    upper_letters.for_each(|(i, v)| {
        letters_map.insert(v, i + 27);
    });

    letters_map
}
