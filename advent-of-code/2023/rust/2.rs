use std::{
    fs::File,
    io::{self, BufRead},
};

struct Colors {
    red: u32,
    blue: u32,
    green: u32,
}

struct Game {
    colors: Colors,
    id: u32,
}

fn parse_game(line: &str) -> Game {
    let (head, tail) = line.split_once(':').unwrap();
    let id = head.split_once(' ').unwrap().1.parse::<u32>().unwrap();

    let mut colors = Colors { red: 0, blue: 0, green: 0 };

    for (count, name) in
        tail.split(|c| c == ';' || c == ',').map(|s| s.trim().split_once(' ').unwrap())
    {
        let update = |x: &mut u32| *x = (*x).max(count.parse().unwrap());
        match name {
            "red" => update(&mut colors.red),
            "blue" => update(&mut colors.blue),
            "green" => update(&mut colors.green),
            _ => unreachable!(),
        }
    }

    Game { id, colors }
}

fn part_one(game: Game) -> u32 {
    if game.colors.red <= 12 && game.colors.blue <= 14 && game.colors.green <= 13 {
        game.id
    }
    else {
        0
    }
}

fn part_two(game: Game) -> u32 {
    game.colors.red * game.colors.blue * game.colors.green
}

fn main() {
    let sum = io::BufReader::new(File::open("inputs/2").unwrap())
        .lines()
        .map(|line| part_two(parse_game(&line.unwrap())))
        .sum::<u32>();
    println!("{}", sum);
}

#[cfg(test)]
mod tests {
    #[test]
    fn parse_game() {
        let game = super::parse_game("Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green");
        assert_eq!(game.id, 5);
        assert_eq!(game.colors.red, 6);
        assert_eq!(game.colors.blue, 2);
        assert_eq!(game.colors.green, 3);
    }
}
