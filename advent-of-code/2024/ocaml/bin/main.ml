open Oaoc
open Printf

let run n =
  let input = Util.read_file (sprintf "../inputs/%d" n) in
  let module Day = (val Days.day n) in
  printf "Part 1: %s\nPart 2: %s\n" (Day.part1 input) (Day.part2 input)

let () =
  if Array.length Sys.argv = 2 then run (int_of_string Sys.argv.(1))
  else printf "Usage: ./run [number]\n"
