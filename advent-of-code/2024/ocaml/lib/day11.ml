let split s =
  let n = String.length s / 2 in
  (String.sub s 0 n, String.sub s n n)

let rec explore mem budget n =
  if budget = 0 then 1
  else
    let compute () =
      let stones =
        let recurse = explore mem (budget - 1) in
        if n = 0 then recurse 1
        else if Util.digits n mod 2 = 0 then
          let a, b = split (string_of_int n) in
          recurse (int_of_string a) + recurse (int_of_string b)
        else recurse (n * 2024)
      in
      Hashtbl.add mem (budget, n) stones;
      stones
    in
    Hashtbl.find_opt mem (budget, n) |> Util.get_or_else compute

let solve budget input =
  String.split_on_char ' ' input
  |> List.to_seq |> Seq.map int_of_string
  |> Util.sum (explore (Hashtbl.create 100000) budget)
  |> string_of_int

let part1 = solve 25
let part2 = solve 75
