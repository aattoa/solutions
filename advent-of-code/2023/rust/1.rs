fn first_digit_as_integer(mut it: impl Iterator<Item = char>) -> u32 {
    it.find_map(|c| c.to_digit(10)).unwrap()
}

fn parse(string: &str) -> u32 {
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

fn solve(callback: fn(String) -> u32) -> u32 {
    util::lines(1).map(callback).sum()
}

fn main() {
    println!("1: {}", solve(|line| parse(&line)));
    println!("2: {}", solve(|line| parse(&fix_digits(line))));
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
        assert_eq!(12, super::parse("1abc2"));
        assert_eq!(38, super::parse("pqr3stu8vwx"));
        assert_eq!(15, super::parse("a1b2c3d4e5f"));
        assert_eq!(77, super::parse("treb7uchet"));
    }
    #[test]
    fn fix_digits() {
        assert_eq!("s7n9e8t", super::fix_digits(String::from("sevenineight")));
    }
}
