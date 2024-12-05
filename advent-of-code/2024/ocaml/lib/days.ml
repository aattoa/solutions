type part = string -> string

module type Day = sig
  val part1 : part
  val part2 : part
end

let days : (module Day) list =
  [ (module Day1); (module Day2); (module Day3); (module Day4); (module Day5) ]

let day (n : int) : (module Day) = List.nth days (n - 1)
