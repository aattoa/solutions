open Util.Ops

let p1 grid seen pos =
  if Util.tbl_contains seen pos then 0
  else
    let area, perimeter = (ref 0, ref 0) in
    let rec walk pos tile =
      match Grid.get_opt grid pos with
      | Some tile' ->
          if tile' = tile then (
            if not (Util.tbl_contains seen pos) then (
              area += 1;
              Hashtbl.add seen pos ();
              walk (Grid.Pos.advance Direction.Up pos) tile;
              walk (Grid.Pos.advance Direction.Down pos) tile;
              walk (Grid.Pos.advance Direction.Left pos) tile;
              walk (Grid.Pos.advance Direction.Right pos) tile))
          else perimeter += 1
      | None -> perimeter += 1
    in
    walk pos (Grid.get grid pos);
    !area * !perimeter

let solve walk input =
  let grid = Grid.of_string_lines input in
  let seen = Hashtbl.create (grid.w * grid.h) in
  Grid.positions grid |> Util.sum (walk grid seen) |> string_of_int

let part1 = solve p1

(* TODO *)
let part2 _ = "p2"
