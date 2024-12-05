let int_of_bool bool = if bool then 1 else 0

let is_some_and f opt = match opt with Some x -> f x | None -> false
let is_none_or f opt = match opt with Some x -> f x | None -> true

let array_nth arr n =
  if 0 <= n && n < Array.length arr then Some (Array.unsafe_get arr n) else None

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

let lines = String.split_on_char '\n'

let read_file path =
  (* TODO: In_channel.input_all causes weird behavior *)
  let channel = open_in path in
  let lines = In_channel.input_lines channel in
  In_channel.close channel;
  String.concat "\n" lines

let todo msg =
  Printf.eprintf "todo: %s\n" msg;
  exit 0
