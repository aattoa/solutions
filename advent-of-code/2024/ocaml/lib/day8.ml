let solve f input =
  let grid = Grid.of_string_lines input in
  let antennae = Hashtbl.create grid.h in
  let antinodes = Hashtbl.create grid.h in

  let add_antinode pos =
    let valid = Grid.is_valid_pos grid pos in
    if valid then Hashtbl.replace antinodes pos ();
    valid
  in

  Fun.flip Seq.iter (Grid.positions grid) (fun pos ->
      let char = Grid.get grid pos in
      if char != '.' then Util.add_to_list antennae char pos);

  Fun.flip Seq.iter (Hashtbl.to_seq_values antennae) (fun list ->
      Fun.flip List.iter list @@ fun a ->
      Fun.flip List.iter list @@ fun b ->
      if a != b then (
        f add_antinode a b;
        f add_antinode b a));

  Hashtbl.length antinodes |> string_of_int

let p1 add_antinode a b =
  add_antinode (Grid.Pos.add a (Grid.Pos.sub a b)) |> ignore

let p2 add_antinode a b =
  let p = ref a in
  while add_antinode !p do
    p := Grid.Pos.add !p (Grid.Pos.sub a b)
  done

let part1 = solve p1
let part2 = solve p2
