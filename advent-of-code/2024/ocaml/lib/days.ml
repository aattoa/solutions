type part = string -> string

module type Day = sig
  val part1 : part
  val part2 : part
end

let days : (module Day) list =
  [
    (module Day1);
    (module Day2);
    (module Day3);
    (module Day4);
    (module Day5);
    (module Day6);
    (module Day7);
    (module Day8);
    (module Day10);
    (module Day11);
    (module Day14);
  ]

let day (n : int) : (module Day) = List.nth days (n - 1)
