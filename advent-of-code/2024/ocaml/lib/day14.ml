open Util.Ops

let w, h = (101, 103)

let parse line =
  Scanf.sscanf line "p=%i,%i v=%i,%i" (fun x y dx dy -> (x, y, dx, dy))

let simulate time (x, y, dx, dy) =
  let x = (x + (dx * time)) mod w in
  let y = (y + (dy * time)) mod h in
  let norm dim n = if n < 0 then dim + n else n in
  (norm w x, norm h y)

let part1 input =
  let q1, q2, q3, q4 = (ref 0, ref 0, ref 0, ref 0) in
  Fun.flip List.iter (Util.lines input) (fun line ->
      let x, y = simulate 100 (parse line) in
      let wmid, hmid = (w / 2, h / 2) in
      if x != wmid && y != hmid then
        (match (x < wmid, y < hmid) with
        | true, true -> q1
        | false, true -> q2
        | true, false -> q3
        | false, false -> q4)
        += 1);
  string_of_int (!q1 * !q2 * !q3 * !q4)

(* The tree occurs on the first frame where no bots overlap *)
let part2 input =
  let bots = Util.lines input |> List.to_seq |> Seq.map parse |> Array.of_seq in
  let found = ref false in
  let time = ref 0 in
  let seen = Grid.make (w, h) false in
  while not !found do
    Grid.fill seen false;
    let check bot =
      let x, y = simulate !time bot in
      let duplicate = Grid.get seen { x; y } in
      if not duplicate then Grid.set seen { x; y } true;
      duplicate
    in
    let duplicate = Array.to_seq bots |> Seq.map check |> Seq.exists Fun.id in
    if duplicate then time += 1 else found := true
  done;
  string_of_int !time
