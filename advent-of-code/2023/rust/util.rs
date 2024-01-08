use std::{
    fs::File,
    io::{BufRead, BufReader},
};

pub fn lines(day: u32) -> impl Iterator<Item = String> {
    File::open(format!("inputs/{}", day))
        .map(BufReader::new)
        .map(BufRead::lines)
        .unwrap()
        .map(Result::unwrap)
}
