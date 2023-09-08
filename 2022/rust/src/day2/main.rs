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

fn my_option(end_game: GameStatus, op: GameOptions) -> GameOptions {
    return match op {
        GameOptions::Rock => match end_game {
            GameStatus::Match => GameOptions::Rock,
            GameStatus::Win => GameOptions::Paper,
            GameStatus::Lose => GameOptions::Scisor,
        },
        GameOptions::Paper => match end_game {
            GameStatus::Match => GameOptions::Paper,
            GameStatus::Win => GameOptions::Scisor,
            GameStatus::Lose => GameOptions::Rock,
        },
        GameOptions::Scisor => match end_game {
            GameStatus::Match => GameOptions::Scisor,
            GameStatus::Win => GameOptions::Rock,
            GameStatus::Lose => GameOptions::Paper,
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

        let (end_game, game_score) = match opts[1] {
            "X" => (GameStatus::Lose, 0),
            "Y" => (GameStatus::Match, 3),
            "Z" => (GameStatus::Win, 6),
            _ => panic!("Invalid option"),
        };

        let selected_score = match my_option(end_game, op) {
            GameOptions::Rock => 1,
            GameOptions::Paper => 2,
            GameOptions::Scisor => 3,
        };

        final_score += selected_score + game_score;
    }

    println!("{final_score}");
}
