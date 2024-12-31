type part = string -> string

module type Day = sig
  val part1 : part
  val part2 : part
end

let placeholder (n : int) : (module Day) =
  (module struct
    let part1 _ = Printf.sprintf "Day %i placeholder part 1" n
    let part2 _ = Printf.sprintf "Day %i placeholder part 2" n
  end)

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
    (module Day9);
    (module Day10);
    (module Day11);
    (module Day12);
    placeholder 13;
    (module Day14);
    (module Day15);
    placeholder 16;
    (module Day17);
    placeholder 18;
    placeholder 19;
    placeholder 20;
    placeholder 21;
    placeholder 22;
    placeholder 23;
    placeholder 24;
    placeholder 25;
  ]

let day (n : int) : (module Day) = List.nth days (n - 1)
