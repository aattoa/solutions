let rec hike grid seen prev pos =
  match Grid.get_opt grid pos with
  | None -> 0
  | Some tile ->
      if tile != prev + 1 then 0
      else if tile = 9 then
        match seen with
        | Some seen ->
            if Util.tbl_contains seen pos then 0
            else (
              Hashtbl.add seen pos ();
              1)
        | None -> 1
      else
        let r dir = hike grid seen tile (Grid.Pos.advance dir pos) in
        r Direction.Left + r Direction.Right + r Direction.Up + r Direction.Down

let score seen grid pos =
  if Grid.get grid pos = 0 then hike grid (seen ()) (-1) pos else 0

let solve score input =
  let grid = Grid.of_string_lines_map Util.int_of_digit input in
  Grid.positions grid |> Util.sum (score grid) |> string_of_int

let part1 = solve (score (fun () -> Some (Hashtbl.create 1000)))
let part2 = solve (score (fun () -> None))
