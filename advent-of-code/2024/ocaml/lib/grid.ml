type 'a t = { arr : 'a array; w : int; h : int }
type pos = { x : int; y : int }

module Pos = struct
  type t = pos
  let compare a b = if a.y = b.y then compare a.x b.x else compare a.y b.y
  let advance d pos =
    let x, y = Direction.offset d in
    { x = pos.x + x; y = pos.y + y }
end

let is_valid_index grid { x; y } = 0 <= x && x < grid.w && 0 <= y && y < grid.h

let to_index grid pos =
  if is_valid_index grid pos then Some ((pos.y * grid.w) + pos.x) else None

let get_opt grid pos = to_index grid pos |> Option.map (Array.get grid.arr)
let get grid pos = to_index grid pos |> Option.get |> Array.get grid.arr
let set grid pos = to_index grid pos |> Option.get |> Array.set grid.arr

let positions grid =
  Seq.init grid.h (fun y -> Seq.init grid.w (fun x -> { x; y })) |> Seq.concat

let find predicate grid =
  positions grid |> Seq.find (Fun.compose predicate (get grid))

let find_eq x = find (( = ) x)

(* Inefficient, fine for now *)
let of_string_lines string =
  let lines = Util.lines string in
  let arr = List.to_seq lines |> Seq.flat_map String.to_seq |> Array.of_seq in
  let w = String.length (List.nth lines 0) in
  let h = List.length lines in
  { arr; w; h }
