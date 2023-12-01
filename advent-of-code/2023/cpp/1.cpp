#include <string_view>
#include <string>
#include <algorithm>
#include <iostream>
#include <fstream>

auto is_digit(char const c) -> bool
{
    return ('0' <= c) && (c <= '9');
}

auto first_digit_as_integer(auto const begin, auto const end) -> int
{
    return *std::find_if(begin, end, is_digit) - '0';
}

auto parse_integer(std::string_view const string) -> int
{
    return first_digit_as_integer(begin(string), end(string)) * 10
         + first_digit_as_integer(rbegin(string), rend(string));
}

auto replace(std::string& string, std::string_view const a, std::string_view const b) -> bool
{
    if (auto offset = string.find(a); offset != std::string::npos) {
        string.replace(offset, a.size(), b);
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

auto main() -> int
{
    int sum = 0;
    {
        std::ifstream file { "input" };
        for (std::string line; std::getline(file, line);) {
            fix_digits(line);
            sum += parse_integer(line);
        }
    }
    std::cout << sum << '\n';
}
