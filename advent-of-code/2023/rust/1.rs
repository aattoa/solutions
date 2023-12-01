use std::{
    fs::File,
    io::{self, BufRead},
};

fn first_digit_as_integer(mut it: impl Iterator<Item = char>) -> u32 {
    it.find(|c| c.is_ascii_digit()).and_then(|c| c.to_digit(10)).unwrap()
}

fn parse_string(string: &str) -> u32 {
    first_digit_as_integer(string.chars()) * 10 + first_digit_as_integer(string.chars().rev())
}

fn replace(string: &mut String, a: &str, b: &str) -> bool {
    // Stupid, but works
    let result = string.replace(a, b);
    if *string != result {
        *string = result;
        return true;
    }
    false
}

#[rustfmt::skip]
fn fix_digits(mut string: String) -> String {
    while replace(&mut string, "one",   "o1e")
       || replace(&mut string, "two",   "t2o")
       || replace(&mut string, "three", "t3e")
       || replace(&mut string, "four",  "f4r")
       || replace(&mut string, "five",  "f5e")
       || replace(&mut string, "six",   "s6x")
       || replace(&mut string, "seven", "s7n")
       || replace(&mut string, "eight", "e8t")
       || replace(&mut string, "nine",  "n9e")
    {}
    string
}

fn main() {
    let sum = io::BufReader::new(File::open("input").unwrap())
        .lines()
        .map(|line| parse_string(&line.map(fix_digits).unwrap()))
        .sum::<u32>();
    println!("{}", sum);
}

#[cfg(test)]
mod tests {
    #[test]
    fn first_digit_as_integer() {
        assert_eq!(8, super::first_digit_as_integer("ab8cd4ef".chars()));
        assert_eq!(4, super::first_digit_as_integer("ab8cd4ef".chars().rev()));
    }
    #[test]
    fn parse_string() {
        assert_eq!(12, super::parse_string("1abc2"));
        assert_eq!(38, super::parse_string("pqr3stu8vwx"));
        assert_eq!(15, super::parse_string("a1b2c3d4e5f"));
        assert_eq!(77, super::parse_string("treb7uchet"));
    }
    #[test]
    fn fix_digits() {
        assert_eq!("s7n9e8t", super::fix_digits(String::from("sevenineight")));
    }
}
