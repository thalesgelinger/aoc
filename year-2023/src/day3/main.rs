use std::{fs, u32, usize};

fn look_left(line: &str, j: usize) -> Option<String> {
    if j == 0 {
        return None;
    }
    let value = line.chars().nth(j - 1);
    match value {
        Some(val) if val.is_numeric() => match look_left(line, j - 1) {
            Some(v) => Some(v.to_string() + &val.to_string()),
            None => Some(val.to_string()),
        },
        _ => None,
    }
}

fn look_right(line: &str, j: usize) -> Option<String> {
    if j == line.chars().count() {
        return None;
    }
    let value = line.chars().nth(j + 1);
    match value {
        Some(val) if val.is_numeric() => {
            let from_init = &line[j + 1..line.chars().count()];
            println!("From init: {from_init}");
            println!("From init: {from_init}");
            match from_init.find(|c: char| !c.is_numeric()) {
                Some(index) => Some(from_init[..index].to_string()),
                None => Some(from_init.to_string()),
            }
        }
        _ => None,
    }
}

enum LookBoth {
    Number(String),
    Numbers(Vec<String>),
}

fn look_both(line: Option<&str>, j: usize) -> Option<LookBoth> {
    match line {
        Some(up_line) => match up_line.chars().nth(j) {
            Some(up_char) if up_char.is_numeric() => {
                let mut value = up_char.to_string();
                value = match look_left(up_line, j) {
                    None => value,
                    Some(v) => v.to_string() + &value,
                };
                value = match look_right(up_line, j) {
                    None => value,
                    Some(v) => {
                        println!("Right: {v}");
                        println!("Value: {value}");
                        value + &v.to_string()
                    }
                };
                Some(LookBoth::Number(value))
            }
            _ => {
                let mut results: Vec<String> = vec![];
                let left_value = look_left(up_line, j);
                if left_value.is_some() {
                    results.push(left_value.unwrap());
                }

                let right_value = look_right(up_line, j);
                if right_value.is_some() {
                    results.push(right_value.unwrap());
                }

                Some(LookBoth::Numbers(results))
            }
        },
        _ => None,
    }
}

fn look_up(file: String, j: usize, i: usize) -> Option<LookBoth> {
    if i == 0 {
        return None;
    }

    let prev_line = file.lines().nth(i - 1);
    return look_both(prev_line, j);
}

fn look_down(file: String, j: usize, i: usize) -> Option<LookBoth> {
    if i == file.lines().count() {
        return None;
    }

    let down_line = file.lines().nth(i + 1);
    return look_both(down_line, j);
}

fn main() {
    let file = fs::read_to_string("input2.txt").unwrap();

    let mut response: u32 = 0;

    for (i, line) in file.lines().enumerate() {
        for (j, l) in line.chars().enumerate() {
            match l {
                '*' => {
                    let mut part_numbers: Vec<String> = vec![];

                    match look_up(file.to_owned(), j, i) {
                        Some(LookBoth::Number(v)) => part_numbers.push(v),
                        Some(LookBoth::Numbers(a)) => {
                            for ele in a {
                                part_numbers.push(ele)
                            }
                        }
                        None => {}
                    };

                    match look_down(file.to_owned(), j, i) {
                        Some(LookBoth::Number(v)) => part_numbers.push(v),
                        Some(LookBoth::Numbers(a)) => {
                            for ele in a {
                                part_numbers.push(ele)
                            }
                        }
                        None => {}
                    };
                    let value_left = look_left(line, j);
                    if value_left.is_some() {
                        part_numbers.push(value_left.unwrap());
                    }

                    let value_right = look_right(line, j);
                    if value_right.is_some() {
                        part_numbers.push(value_right.unwrap());
                    }

                    if part_numbers.len() == 2 {
                        response += part_numbers[0].parse::<u32>().unwrap()
                            * part_numbers[1].parse::<u32>().unwrap();
                    }
                    for el in part_numbers {
                        println!("{el}");
                    }
                }
                _ => continue,
            };
        }
    }
    println!("Response: {response}");
}
