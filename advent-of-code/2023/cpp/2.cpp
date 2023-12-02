#include <algorithm>
#include <charconv>
#include <cstddef>
#include <format>
#include <iostream>
#include <fstream>
#include <string_view>

struct Colors {
    std::size_t red {};
    std::size_t blue {};
    std::size_t green {};
};

struct Game {
    std::size_t id {};
    Colors      colors {};
};

auto remove_prefix(std::string_view& string, std::string_view const prefix) -> bool
{
    bool const result = string.starts_with(prefix);
    if (result) {
        string.remove_prefix(prefix.size());
    }
    return result;
}

auto extract_integer(std::string_view& string) -> std::size_t
{
    std::size_t value {};
    auto const [ptr, _] = std::from_chars(string.data(), string.data() + string.size(), value);
    string.remove_prefix(static_cast<std::size_t>(std::distance(string.data(), ptr)));
    return value;
}

auto extract_color(std::string_view& string) -> std::size_t Colors::*
{
    if (remove_prefix(string, "red")) {
        return &Colors::red;
    }
    if (remove_prefix(string, "blue")) {
        return &Colors::blue;
    }
    if (remove_prefix(string, "green")) {
        return &Colors::green;
    }
    std::abort();
}

auto parse_game(std::string_view string) -> Game
{
    Game game;

    remove_prefix(string, "Game ");
    game.id = extract_integer(string);
    remove_prefix(string, ": ");

    do {
        auto const count = extract_integer(string);
        remove_prefix(string, " ");
        auto const color = extract_color(string);

        game.colors.*color = std::max(game.colors.*color, count);
    } while (remove_prefix(string, "; ") || remove_prefix(string, ", "));

    return game;
};

auto part_1(Game const game) -> std::size_t
{
    return game.colors.red <= 12 && game.colors.blue <= 14 && game.colors.green <= 13 ? game.id : 0;
}

auto part_2(Game const game) -> std::size_t
{
    return game.colors.red * game.colors.blue * game.colors.green;
}

auto main() -> int
{
    std::size_t sum = 0;
    {
        std::ifstream file { "inputs/2" };
        for (std::string line; std::getline(file, line);) {
            sum += part_1(parse_game(line));
        }
    }
    std::cout << sum << '\n';
}
