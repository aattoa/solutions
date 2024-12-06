module PosSet = Set.Make (Grid.Pos)
module PosMap = Map.Make (Grid.Pos)

let rec walk grid seen guard dir =
  let seen = PosSet.add guard seen in
  let guard' = Grid.Pos.advance dir guard in
  match Grid.get_opt grid guard' with
  | Some '#' -> walk grid seen guard @@ Direction.turn_right dir
  | Some _ -> walk grid seen guard' dir
  | None -> seen

let part1 string =
  let grid = Grid.of_string_lines string in
  let start = Grid.find_eq '^' grid |> Option.get in
  walk grid PosSet.empty start Direction.Up |> PosSet.cardinal |> string_of_int

let rec does_get_stuck grid seen guard dir =
  PosMap.find_opt guard seen |> Util.is_some_and (List.mem dir)
  ||
  let seen = PosMap.add_to_list guard dir seen in
  let guard' = Grid.Pos.advance dir guard in
  match Grid.get_opt grid guard' with
  | Some '#' -> does_get_stuck grid seen guard @@ Direction.turn_right dir
  | Some _ -> does_get_stuck grid seen guard' dir
  | None -> false

let causes_loop grid guard dir pos =
  let original = Grid.get grid pos in
  Grid.set grid pos '#';
  let stuck = does_get_stuck grid PosMap.empty guard dir in
  Grid.set grid pos original;
  stuck

(* Unintelligent brute force solution *)
let part2 string =
  let grid = Grid.of_string_lines string in
  let guard = Grid.find_eq '^' grid |> Option.get in
  let seen = walk grid PosSet.empty guard Direction.Up in
  let check pos =
    Grid.get grid pos = '.' && causes_loop grid guard Direction.Up pos
  in
  PosSet.to_seq seen
  |> Util.sum (Fun.compose Util.int_of_bool check)
  |> string_of_int
