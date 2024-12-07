let num_cat a b = Printf.sprintf "%i%i" a b |> int_of_string

let rec can_equal ~concat target acc nums =
  acc <= target
  &&
  match nums with
  | num :: nums ->
      let num = int_of_string num in
      can_equal ~concat target (acc * num) nums
      || can_equal ~concat target (acc + num) nums
      || (concat && can_equal ~concat target (num_cat acc num) nums)
  | [] -> acc = target

let count ~concat line =
  match String.split_on_char ' ' line with
  | target :: num :: nums ->
      let target = int_of_string (Util.str_drop_last 1 target) in
      if can_equal ~concat target (int_of_string num) nums then target else 0
  | _ -> 0

let solve ~concat input =
  Util.lines input |> List.to_seq |> Util.sum (count ~concat) |> string_of_int

let part1 = solve ~concat:false
let part2 = solve ~concat:true
