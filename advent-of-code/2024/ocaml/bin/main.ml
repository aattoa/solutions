open Oaoc

type part = string array -> string

module type Day = sig
  val part1 : part
  val part2 : part
end

let days : (module Day) list = [ (module Day1) ]

let input_lines n =
  let channel = open_in (Printf.sprintf "../inputs/%d" n) in
  let lines = In_channel.input_lines channel in
  close_in channel;
  Array.of_list lines

let run n =
  let input = input_lines n in
  let module Day = (val List.nth days (n - 1)) in
  Printf.printf "Part 1: %s\nPart 2: %s\n" (Day.part1 input) (Day.part2 input)

let () =
  if Array.length Sys.argv = 2 then run (int_of_string Sys.argv.(1))
  else print_endline "Usage: ./run [number]"
