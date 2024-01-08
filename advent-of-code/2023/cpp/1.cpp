#include <util.hpp>

auto is_digit(char const c) -> bool
{
    return ('0' <= c) && (c <= '9');
}

auto first_digit_as_integer(auto const begin, auto const end) -> int
{
    auto const it = std::find_if(begin, end, is_digit);
    cpputil::always_assert(it != end);
    return *it - '0';
}

auto parse_integer(std::string_view const string) -> int
{
    return first_digit_as_integer(begin(string), end(string)) * 10
         + first_digit_as_integer(rbegin(string), rend(string));
}

auto replace(std::string& string, std::string_view const from, std::string_view const to) -> bool
{
    if (auto offset = string.find(from); offset != std::string::npos) {
        string.replace(offset, from.size(), to);
        return true;
    }
    return false;
}

auto fix_digits(std::string& string) -> void
{
    // clang-format off
    while (replace(string, "one",   "o1e")
        || replace(string, "two",   "t2o")
        || replace(string, "three", "t3e")
        || replace(string, "four",  "f4r")
        || replace(string, "five",  "f5e")
        || replace(string, "six",   "s6x")
        || replace(string, "seven", "s7n")
        || replace(string, "eight", "e8t")
        || replace(string, "nine",  "n9e"));
    // clang-format on
}

auto part_1(std::string_view const line) -> int
{
    return parse_integer(line);
}

auto part_2(std::string line) -> int
{
    fix_digits(line);
    return parse_integer(line);
}

auto solve(auto const& callback) -> int
{
    int  sum  = 0;
    auto file = cpputil::io::File::open_read("inputs/1");
    for (std::string const& line : cpputil::io::lines(file.get())) {
        sum += callback(line);
    }
    return sum;
}

auto main() -> int
{
    std::println("1: {}", solve(part_1));
    std::println("2: {}", solve(part_2));
}
