use std::fs;

fn main() {
    let input: String = fs::read_to_string("sample.txt").expect("Should inform file path");
    let lines = input.lines();

    let mut fully_contain_pairs = 0;

    for line in lines {
        let mut pairs = line.split(",");
        let left = pairize_tuples(pairs.next().unwrap().to_owned());
        let right = pairize_tuples(pairs.next().unwrap().to_owned());

        fully_contain_pairs += match (left, right) {
            ((l1, l2), (r1, r2)) if l1 <= r1 && r2 <= l2 => 1,
            ((l1, l2), (r1, r2)) if r1 <= l1 && l2 <= r2 => 1,
            _ => 0,
        }
    }

    return println!("{fully_contain_pairs}");
}

fn pairize_tuples(str_pair: String) -> (usize, usize) {
    let mut side = str_pair.split("-");

    let first = side
        .next()
        .unwrap()
        .parse::<usize>()
        .expect("Why this is not a number?");

    let second = side
        .next()
        .unwrap()
        .parse::<usize>()
        .expect("Why this is not a number?");

    return (first, second);
}
