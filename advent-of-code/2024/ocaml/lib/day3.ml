let reg_do = Str.regexp_string "do()"

let rec parse reg off str =
  try
    Str.search_forward reg str off |> ignore;
    if Str.matched_string str = "don't()" then
      let _ = Str.match_end () |> Str.search_forward reg_do str in
      parse reg (Str.match_end ()) str
    else
      let num n = Str.matched_group n str |> int_of_string in
      let product = num 1 * num 2 in
      product + parse reg (Str.match_end ()) str
  with Not_found -> 0

let mul = {|mul(\([0-9][0-9]?[0-9]?\),\([0-9][0-9]?[0-9]?\))|}
let solve reg input = input |> parse (Str.regexp reg) 0 |> string_of_int
let part1 = solve mul
let part2 = solve ("don't()\\|" ^ mul)
