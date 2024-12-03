let parse line = line |> String.split_on_char ' ' |> List.map int_of_string

let is_predecessor a b ~incline =
  let diff = (b - a) * incline in
  diff = 1 || diff = 2 || diff = 3

let rec is_safe ~incline ~(prev : int) ints =
  match ints with
  | x :: xs -> is_predecessor prev x ~incline && is_safe ~incline ~prev:x xs
  | [] -> true

let p1 ints =
  match ints with
  | x :: y :: xs -> is_safe ~incline:(if x < y then 1 else -1) ~prev:x (y :: xs)
  | _ -> true

let p2 ints =
  Util.range 0 (List.length ints)
  |> Seq.map (fun n -> Util.remove_nth n ints |> p1)
  |> Util.any

let solve check input =
  let safe line = parse line |> check |> Util.int_of_bool in
  Util.lines input |> List.map safe |> List.fold_left ( + ) 0 |> string_of_int

let part1 = solve p1
let part2 = solve p2
