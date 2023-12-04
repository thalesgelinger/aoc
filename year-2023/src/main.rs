use std::{fs, usize};

fn is_symbol(c: char) -> bool {
    !c.is_numeric() && c != '.'
}

fn main() {
    let file = fs::read_to_string("input.txt").unwrap();

    let mut response: u32 = 0;

    for (line_idx, line) in file.lines().enumerate() {
        let mut number: u32 = 0;
        let mut number_idx = -1;
        for (j, letter) in line.chars().enumerate() {
            number = match letter {
                l if l.is_numeric() => {
                    if number_idx < 0 {
                        number_idx = j.to_string().parse::<isize>().unwrap();
                    }
                    number * 10 + l.to_digit(10).unwrap() as u32
                }
                _ => number,
            };

            let last_one = j == line.chars().count() - 1 && number > 0;
            if number > 0 && !letter.is_numeric() || last_one {
                let mut has_adjacent = false;
                let mut number_str = number.to_string();

                let nid = number_idx as usize;
                let has_top = line_idx > 0;
                if has_top {
                    let previous_line = file.lines().nth(line_idx - 1).unwrap();
                    let substring_to_look_at = match (nid, &mut number_str) {
                        (idx, nbr) if idx > 0 && (nid + nbr.len()) < previous_line.len() => {
                            &previous_line[nid - 1..nid + nbr.len() + 1]
                        }
                        (_, nbr) if (nid + nbr.len()) < previous_line.len() => {
                            &previous_line[nid..nid + nbr.len() + 1]
                        }
                        (idx, nbr) if idx > 0 => &previous_line[nid - 1..nid + nbr.len()],
                        (_, nbr) => &previous_line[nid..nid + nbr.len()],
                    };
                    // println!("Number: {number_str}, Top to look: {substring_to_look_at}");
                    substring_to_look_at.chars().for_each(|c| {
                        if is_symbol(c) {
                            has_adjacent = true;
                        }
                    })
                }

                if nid > 0 {
                    let value_left = line.chars().nth(nid - 1).unwrap();
                    // println!("Number: {number_str}, Left to look: {value_left}");
                    if is_symbol(value_left) {
                        has_adjacent = true;
                    }
                }

                if (nid + number_str.len()) < line.len() {
                    let value_right = line.chars().nth(nid + number_str.len()).unwrap();
                    // println!("Number: {number_str}, Right to look: {value_right}");
                    if is_symbol(value_right) {
                        has_adjacent = true;
                    }
                }

                let has_bottom = line_idx < file.lines().count() - 1;
                if has_bottom {
                    let next_line = file.lines().nth(line_idx + 1).unwrap();
                    let substring_to_look_at = match (nid, &mut number_str) {
                        (idx, nbr) if idx > 0 && (nid + nbr.len()) < next_line.len() => {
                            &next_line[nid - 1..nid + nbr.len() + 1]
                        }
                        (_, nbr) if (nid + nbr.len()) < next_line.len() => {
                            &next_line[nid..nid + nbr.len() + 1]
                        }
                        (idx, nbr) if idx > 0 => &next_line[nid - 1..nid + nbr.len()],
                        (_, nbr) => &next_line[nid..nid + nbr.len()],
                    };
                    substring_to_look_at.chars().for_each(|c| {
                        if is_symbol(c) {
                            has_adjacent = true;
                        }
                    })
                }

                if has_adjacent {
                    response += number;
                };

                number = 0;
                number_idx = -1;
            }
        }
    }
    println!("Response: {response}");
}
