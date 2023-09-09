use std::{collections::HashMap, fs};

fn main() {
    let input: String = fs::read_to_string("values.txt").expect("Should inform file path");

    let lines: Vec<&str> = input.lines().collect();

    let map = build_letter_map();

    let mut sum_of_props = 0;

    for i in (0..lines.len()).step_by(3) {
        let line1 = lines[i].to_owned();
        let line2 = lines[i + 1].to_owned();
        let line3 = lines[i + 2].to_owned();
        let same_letter = find_same_in_lines(line1, line2, line3);
        let value = map.get(&same_letter).unwrap_or(&0);
        sum_of_props += value;
    }
    println!("{sum_of_props}");
}

fn find_same_in_lines(line1: String, line2: String, line3: String) -> char {
    let mut res = '-';

    line1.chars().for_each(|letter| {
        if line2.contains(letter) {
            if line3.contains(letter) {
                res = letter;
            }
        }
    });

    res
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
