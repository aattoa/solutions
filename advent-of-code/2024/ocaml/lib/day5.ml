type rules = (int, int list) Hashtbl.t

let sort_update rules =
  List.sort @@ fun l r ->
  match Hashtbl.find_opt rules l with
  | Some xs -> if List.mem r xs then -1 else 1
  | None -> 1

let rec is_valid rules update encountered =
  match update with
  | x :: xs -> (
      match Hashtbl.find_opt rules x with
      | Some list ->
          let good n = List.mem n encountered || not (List.mem n update) in
          List.for_all good list && is_valid rules xs (x :: encountered)
      | None -> is_valid rules xs (x :: encountered))
  | [] -> true

let parse_update line = String.split_on_char ',' line |> List.map int_of_string

let rec parse count rules lines =
  match lines with
  | "" :: lines ->
      Util.sum (Fun.compose (count rules) parse_update) (List.to_seq lines)
  | line :: lines ->
      Scanf.sscanf line "%i|%i" (Fun.flip (Util.add_to_list rules));
      parse count rules lines
  | [] -> invalid_arg "Unexpected end of input"

let mid list = List.nth list (List.length list / 2)
let p1 rules xs = if is_valid rules xs [] then mid xs else 0
let p2 rules xs = if is_valid rules xs [] then 0 else mid (sort_update rules xs)

let solve count input =
  Util.lines input |> parse count (Hashtbl.create 100) |> string_of_int

let part1 = solve p1
let part2 = solve p2
