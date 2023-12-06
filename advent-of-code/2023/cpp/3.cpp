#include <cstddef>
#include <utility>
#include <compare>
#include <concepts>

#include <span>
#include <vector>
#include <optional>
#include <string>
#include <string_view>
#include <unordered_map>

#include <iostream>
#include <fstream>

using Grid_view = std::span<std::string const>;

struct Coords {
    std::size_t x {};
    std::size_t y {};

    auto operator==(Coords const&) const -> bool = default;
};

template <>
struct std::hash<Coords> {
    auto operator()(Coords const coords) const -> std::size_t
    {
        using Hash = std::hash<std::size_t>;
        return Hash()(coords.x) + Hash()(coords.y);
    }
};

auto is_digit(char const c) -> bool
{
    return ('0' <= c) && (c <= '9');
}

auto adjacent_symbol_if(
    Grid_view const grid, Coords const coords, std::predicate<char> auto const& is_symbol)
    -> std::optional<Coords>
{
    for (int dy = -1; dy != 2; ++dy) {
        for (int dx = -1; dx != 2; ++dx) {
            std::size_t const x = coords.x + dx;
            std::size_t const y = coords.y + dy;
            if ((dx == 0 && dy == 0) || y >= grid.size() || x >= grid[y].size()) {
                continue;
            }
            if (is_symbol(grid[y][x])) {
                return Coords { x, y };
            }
        }
    }
    return std::nullopt;
}

auto parse_grid(
    Grid_view const                                 grid,
    std::predicate<char> auto const&                is_symbol,
    std::invocable<Coords, std::size_t> auto const& callback) -> void
{
    for (std::size_t y = 0; y != grid.size(); ++y) {
        std::string           digits;
        std::optional<Coords> adjacent_symbol;

        for (std::size_t x = 0; x != grid[y].size(); ++x) {
            char const c = grid[y][x];
            if (is_digit(c)) {
                digits.push_back(c);
                if (!adjacent_symbol) {
                    adjacent_symbol = adjacent_symbol_if(grid, { x, y }, is_symbol);
                }
            }
            else if (!digits.empty()) {
                if (adjacent_symbol) {
                    callback(adjacent_symbol.value(), std::stoull(digits));
                    adjacent_symbol.reset();
                }
                digits.clear();
            }
        }
        if (adjacent_symbol) {
            callback(adjacent_symbol.value(), std::stoull(digits));
        }
    }
}

auto part_one(Grid_view const grid) -> std::size_t
{
    std::size_t sum {};
    parse_grid(
        grid,
        [](char const c) { return !is_digit(c) && c != '.'; },
        [&](Coords, std::size_t const number) { sum += number; });
    return sum;
}

auto part_two(Grid_view const grid) -> std::size_t
{
    std::unordered_map<Coords, std::vector<std::size_t>> gear_map;
    parse_grid(
        grid,
        [](char const c) { return c == '*'; },
        [&](Coords const coords, std::size_t const number) { gear_map[coords].push_back(number); });

    std::size_t sum {};
    for (auto const& [_, numbers] : gear_map) {
        if (numbers.size() == 2) {
            sum += numbers.front() * numbers.back();
        }
    }
    return sum;
}

auto main() -> int
{
    std::vector<std::string> grid;
    {
        std::ifstream file { "inputs/3" };
        for (std::string line; std::getline(file, line);) {
            grid.push_back(std::move(line));
        }
    }
    std::cout << part_one(grid) << '\n' << part_two(grid) << '\n';
}
