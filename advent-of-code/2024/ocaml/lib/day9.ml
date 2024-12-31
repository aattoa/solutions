open Util.Ops

let make_disk input =
  String.to_seqi input
  |> Seq.flat_map @@ fun (id, char) ->
     let x = if id mod 2 = 0 then id / 2 else -1 in
     Seq.init (Util.int_of_digit char) (Fun.const x)

let checksum disk =
  let check (id, x) = if x = -1 then 0 else id * x in
  Util.sum check (Seq.zip (Seq.ints 0) disk)

let solve compact input =
  let disk = Array.of_seq (make_disk input) in
  compact disk;
  Array.to_seq disk |> checksum |> string_of_int

let p1 disk =
  let start, stop = (ref 0, ref (Array.length disk - 1)) in
  while !start < !stop do
    if disk.(!start) = -1 then (
      while !start < !stop && disk.(!stop) = -1 do
        stop -= 1
      done;
      disk.(!start) <- disk.(!stop);
      disk.(!stop) <- -1;
      stop -= 1);
    start += 1
  done

(* TODO *)
let p2 _ = ()

let part1 = solve p1
let part2 = solve p2
