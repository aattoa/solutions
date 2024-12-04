let grid_check grid x y c =
  Grid.get_opt grid { x; y } |> Util.is_some_and (( = ) c)

let rec try_read grid x y dx dy chars =
  match chars with
  | c :: cs ->
      let x, y = (x + dx, y + dy) in
      grid_check grid x y c && try_read grid x y dx dy cs
  | [] -> true

let p1 grid x y =
  let count = ref 0 in
  if Grid.get grid { x; y } = 'X' then
    for dy = -1 to 1 do
      for dx = -1 to 1 do
        if try_read grid x y dx dy [ 'M'; 'A'; 'S' ] then count := !count + 1
      done
    done;
  !count

let p2 grid x y =
  if Grid.get grid { x; y } != 'A' then 0
  else
    let arms = ref 0 in
    for dy = -1 to 1 do
      for dx = -1 to 1 do
        if
          (dx != 0 && dy != 0)
          && grid_check grid (x + dx) (y + dy) 'M'
          && grid_check grid (x - dx) (y - dy) 'S'
        then arms := !arms + 1
      done
    done;
    if !arms = 2 then 1 else 0

let solve check string =
  let grid = Grid.of_string_lines string in
  let count = ref 0 in
  for y = 0 to grid.h - 1 do
    for x = 0 to grid.w - 1 do
      count := !count + check grid x y
    done
  done;
  string_of_int !count

let part1 = solve p1
let part2 = solve p2
