let int_of_bool bool = if bool then 1 else 0

let rec range lo hi =
  if lo < hi then Seq.cons lo (range (lo + 1) hi) else Seq.empty

let rec remove_nth n xs =
  match xs with
  | x :: xs -> if n = 0 then xs else x :: remove_nth (n - 1) xs
  | [] -> invalid_arg "remove_nth: Index out of bounds"

let rec any bs =
  match Seq.uncons bs with Some (b, bs) -> b || any bs | None -> false

let rec all bs =
  match Seq.uncons bs with Some (b, bs) -> b && all bs | None -> true
