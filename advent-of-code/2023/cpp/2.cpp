#include <util.hpp>
#include <charconv>

struct Colors {
    int red {};
    int blue {};
    int green {};
};

struct Game {
    int    id {};
    Colors colors {};
};

auto remove_prefix(std::string_view& string, std::string_view const prefix) -> bool
{
    bool const result = string.starts_with(prefix);
    if (result) {
        string.remove_prefix(prefix.size());
    }
    return result;
}

auto extract_integer(std::string_view& string) -> int
{
    int value {};
    auto const [ptr, _] = std::from_chars(string.data(), string.data() + string.size(), value);
    string.remove_prefix(static_cast<int>(std::distance(string.data(), ptr)));
    return value;
}

auto extract_color(std::string_view& string) -> int Colors::*
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
    cpputil::unreachable();
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

auto part_1(Game const game) -> int
{
    return game.colors.red <= 12 && game.colors.blue <= 14 && game.colors.green <= 13 ? game.id : 0;
}

auto part_2(Game const game) -> int
{
    return game.colors.red * game.colors.blue * game.colors.green;
}

auto solve(auto const& callback) -> int
{
    int  sum  = 0;
    auto file = cpputil::io::File::open_read("inputs/2");
    for (std::string const& line : cpputil::io::lines(file.get())) {
        sum += callback(parse_game(line));
    }
    return sum;
}

auto main() -> int
{
    std::println("1: {}", solve(part_1));
    std::println("2: {}", solve(part_2));
}
