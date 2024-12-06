let grid_check grid x y c =
  Grid.get_opt grid { x; y } |> Util.is_some_and (( = ) c)

let rec try_read grid x y dx dy chars =
  match chars with
  | c :: cs ->
      let x, y = (x + dx, y + dy) in
      grid_check grid x y c && try_read grid x y dx dy cs
  | [] -> true

let p1 grid pos =
  let count = ref 0 in
  if Grid.get grid pos = 'X' then
    for dy = -1 to 1 do
      for dx = -1 to 1 do
        if try_read grid pos.x pos.y dx dy [ 'M'; 'A'; 'S' ] then
          count := !count + 1
      done
    done;
  !count

let p2 grid pos =
  if Grid.get grid pos != 'A' then 0
  else
    let arms = ref 0 in
    for dy = -1 to 1 do
      for dx = -1 to 1 do
        if
          (dx != 0 && dy != 0)
          && grid_check grid (pos.x + dx) (pos.y + dy) 'M'
          && grid_check grid (pos.x - dx) (pos.y - dy) 'S'
        then arms := !arms + 1
      done
    done;
    if !arms = 2 then 1 else 0

let solve count string =
  let grid = Grid.of_string_lines string in
  Grid.positions grid |> Util.sum (count grid) |> string_of_int

let part1 = solve p1
let part2 = solve p2
