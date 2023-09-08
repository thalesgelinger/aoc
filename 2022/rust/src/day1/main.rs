use std::fs;

fn main() {
    let input: String = fs::read_to_string("values.txt").expect("Should inform file path");

    let lines = input.lines();

    let mut result = 0;

    let mut sum = 0;

    for line in lines {
        match line.trim() {
            "" => {
                if sum > result {
                    result = sum;
                }
                sum = 0;
            }
            s => sum += s.parse::<usize>().unwrap(),
        }
    }

    println!("Result : {result}");
}
