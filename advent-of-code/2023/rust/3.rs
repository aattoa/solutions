use std::collections::HashMap;

#[derive(PartialEq, Eq, Hash)]
struct Coords {
    x: usize,
    y: usize,
}

fn adjacent_symbol_if(
    grid: &[String],
    Coords { x, y }: Coords,
    is_symbol: impl Fn(u8) -> bool,
) -> Option<Coords> {
    for dy in -1..=1 {
        for dx in -1..=1 {
            if dy == 0 && dx == 0 {
                continue;
            }
            if let (Some(x), Some(y)) = (x.checked_add_signed(dx), y.checked_add_signed(dy)) {
                if let Some(row) = grid.get(y) {
                    if let Some(&char) = row.as_bytes().get(x) {
                        if is_symbol(char) {
                            return Some(Coords { x, y });
                        }
                    }
                }
            }
        }
    }
    None
}

fn parse_grid(
    grid: &[String],
    is_symbol: impl Fn(u8) -> bool,
    mut callback: impl FnMut(Coords, usize),
) {
    for y in 0..grid.len() {
        let mut digits = String::new();
        let mut adjacent_symbol: Option<Coords> = None;

        for x in 0..grid[y].len() {
            let char: u8 = grid[y].as_bytes()[x];
            if char.is_ascii_digit() {
                digits.push(char as char);
                if adjacent_symbol.is_none() {
                    adjacent_symbol = adjacent_symbol_if(grid, Coords { x, y }, &is_symbol);
                }
            }
            else if !digits.is_empty() {
                if let Some(coords) = adjacent_symbol {
                    callback(coords, digits.parse::<usize>().unwrap());
                    adjacent_symbol = None;
                }
                digits.clear();
            }
        }
        if let Some(coords) = adjacent_symbol {
            callback(coords, digits.parse::<usize>().unwrap());
        }
    }
}

fn part_one(grid: &[String]) -> usize {
    let mut sum = 0;
    parse_grid(grid, |c| (!c.is_ascii_digit() && c != b'.'), |_, number| sum += number);
    sum
}

fn part_two(grid: &[String]) -> usize {
    let mut gear_map = HashMap::<Coords, Vec<usize>>::new();
    parse_grid(
        grid,
        |c| c == b'*',
        |coords, number| gear_map.entry(coords).or_default().push(number),
    );
    gear_map
        .values()
        .filter_map(|vec| {
            if vec.len() == 2 {
                return Some(vec.first()? * vec.last()?);
            }
            None
        })
        .sum()
}

fn main() {
    let grid: Vec<String> = util::lines(3).collect();
    println!("1: {}", part_one(&grid));
    println!("2: {}", part_two(&grid));
}
