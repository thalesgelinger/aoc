use std::fs;

enum GameOptions {
    Rock,
    Paper,
    Scisor,
}

enum GameStatus {
    Win,
    Match,
    Lose,
}

fn check(me: GameOptions, op: GameOptions) -> GameStatus {
    return match me {
        GameOptions::Rock => match op {
            GameOptions::Rock => GameStatus::Match,
            GameOptions::Paper => GameStatus::Lose,
            GameOptions::Scisor => GameStatus::Win,
        },
        GameOptions::Paper => match op {
            GameOptions::Rock => GameStatus::Win,
            GameOptions::Paper => GameStatus::Match,
            GameOptions::Scisor => GameStatus::Lose,
        },
        GameOptions::Scisor => match op {
            GameOptions::Rock => GameStatus::Lose,
            GameOptions::Paper => GameStatus::Win,
            GameOptions::Scisor => GameStatus::Match,
        },
    };
}

fn main() {
    let input: String = fs::read_to_string("values.txt").expect("Should inform file path");

    let rounds = input.lines();

    let mut final_score: i32 = 0;

    for round in rounds {
        let opts: Vec<&str> = round.split(" ").collect();

        let op = match opts[0] {
            "A" => GameOptions::Rock,
            "B" => GameOptions::Paper,
            "C" => GameOptions::Scisor,
            _ => panic!("Invalid oponent option"),
        };

        let (me, selected_score) = match opts[1] {
            "X" => (GameOptions::Rock, 1),
            "Y" => (GameOptions::Paper, 2),
            "Z" => (GameOptions::Scisor, 3),
            _ => panic!("Invalid option"),
        };

        let game_score = match check(me, op) {
            GameStatus::Win => 6,
            GameStatus::Match => 3,
            GameStatus::Lose => 0,
        };

        final_score += selected_score + game_score;
    }

    println!("{final_score}");
}
