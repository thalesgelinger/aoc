use std::fs;

fn main() {
    let input: String = fs::read_to_string("values.txt").expect("Should inform file path");

    let lines = input.lines();

    let mut sum = 0;

    let mut sums: Vec<usize> = Vec::new();

    for line in lines {
        match line.trim() {
            "" => {
                sums.push(sum);
                sum = 0;
            }
            s => sum += s.parse::<usize>().unwrap(),
        }
    }
    sums.push(sum);

    sums.sort();
    sums.reverse();
    let mut total_top3 = 0;

    for i in 0..3 {
        total_top3 += sums[i];
    }

    let result = sums[0];
    println!("Result : {result}");
    println!("Result top 3: {total_top3}");
}
