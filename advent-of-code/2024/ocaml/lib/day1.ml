open Array

let input lines =
  let len = length lines in
  let left, right = (make len 0, make len 0) in
  for i = 0 to len - 1 do
    Scanf.sscanf lines.(i) "%i   %i" (fun l r ->
        set left i l;
        set right i r)
  done;
  sort compare left;
  sort compare right;
  (left, right)

let occurrences x = fold_left (fun acc y -> acc + if x = y then 1 else 0) 0

let solve f lines =
  let left, right = input lines in
  let sum = ref 0 in
  for i = 0 to length lines - 1 do
    sum := !sum + f i left right
  done;
  string_of_int !sum

let p1 i left right = abs (left.(i) - right.(i))

let p2 i left right =
  let n = get left i in
  n * occurrences n right

let part1 = solve p1
let part2 = solve p2
