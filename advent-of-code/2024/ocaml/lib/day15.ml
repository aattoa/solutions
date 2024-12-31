let gps grid pos = if Grid.get grid pos = 'O' then (100 * pos.y) + pos.x else 0

let expand_char char =
  match char with
  | '#' -> Seq.cons '#' (Seq.return '#')
  | 'O' -> Seq.cons '[' (Seq.return ']')
  | '.' -> Seq.cons '.' (Seq.return '.')
  | '@' -> Seq.cons '@' (Seq.return '.')
  | _ -> Seq.return char

let expand input =
  String.to_seq input |> Seq.flat_map expand_char |> String.of_seq

let part1 input =
  let grid, dirs = Util.lines input |> Util.list_split_by Util.str_empty in
  let grid = String.concat "\n" grid |> Grid.of_string_lines in
  let bot = Grid.find_eq '@' grid |> Option.get |> ref in

  let walk dir =
    let next = Grid.Pos.advance dir !bot in
    match Grid.get grid next with
    | '.' ->
        Grid.swap grid !bot next;
        bot := next
    | 'O' ->
        let rec aux pos =
          match Grid.get grid pos with
          | '.' ->
              Grid.swap grid next pos;
              Grid.swap grid !bot next;
              bot := next
          | '#' -> ()
          | 'O' -> aux (Grid.Pos.advance dir pos)
          | _ -> invalid_arg "bad tile"
        in
        aux (Grid.Pos.advance dir next)
    | _ -> ()
  in

  Seq.iter walk
    (List.to_seq dirs |> Seq.flat_map String.to_seq |> Seq.map Direction.of_char);

  Grid.positions grid |> Util.sum (gps grid) |> string_of_int

(* TODO *)
let part2 _ = "p2"
