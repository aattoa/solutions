type 'a t = { arr : 'a array; w : int; h : int }
type pos = { x : int; y : int }

module Pos = struct
  type t = pos
  let compare a b = if a.y = b.y then compare a.x b.x else compare a.y b.y
  let advance ?(step = 1) d pos =
    let x, y = Direction.offset d in
    { x = pos.x + (x * step); y = pos.y + (y * step) }
  let sub a b = { x = a.x - b.x; y = a.y - b.y }
  let add a b = { x = a.x + b.x; y = a.y + b.y }
end

let is_valid_pos grid { x; y } = 0 <= x && x < grid.w && 0 <= y && y < grid.h

let to_index grid pos =
  if is_valid_pos grid pos then Some ((pos.y * grid.w) + pos.x) else None

let get_opt grid pos = to_index grid pos |> Option.map (Array.get grid.arr)
let get grid pos = to_index grid pos |> Option.get |> Array.get grid.arr
let set grid pos = to_index grid pos |> Option.get |> Array.set grid.arr

let swap grid a b =
  let a = to_index grid a |> Option.get in
  let b = to_index grid b |> Option.get in
  Util.arr_swap grid.arr a b

let positions grid =
  Seq.init grid.h (fun y -> Seq.init grid.w (fun x -> { x; y })) |> Seq.concat

let find predicate grid =
  positions grid |> Seq.find (Fun.compose predicate (get grid))

let find_eq x = find (( = ) x)

let fill grid = Array.fill grid.arr 0 (Array.length grid.arr)

let make (w, h) x = { arr = Array.make (w * h) x; w; h }

(* Below functions terribly inefficient, fine for now *)

let of_lines_map f lines =
  let w = String.length (List.nth lines 0) in
  let h = List.length lines in
  assert (w != 0 && h != 0);
  let seq = List.to_seq lines |> Seq.flat_map String.to_seq |> Seq.map f in
  { arr = Array.of_seq seq; w; h }

let of_lines = of_lines_map Fun.id
let of_string_lines_map f string = of_lines_map f (Util.lines string)
let of_string_lines = of_string_lines_map Fun.id
