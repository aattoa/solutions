module Ops = struct
  let ( <. ) f g x = f (g x)
  let ( >. ) f g x = g (f x)
  let ( += ) l r = l := !l + r
  let ( -= ) l r = l := !l - r
end

let int_of_bool bool = if bool then 1 else 0
let int_of_digit char = int_of_char char - int_of_char '0'

let is_some_and f opt = match opt with Some x -> f x | None -> false
let is_none_or f opt = match opt with Some x -> f x | None -> true
let get_or_else f opt = match opt with Some x -> x | None -> f ()

let sum f = Seq.fold_left (fun acc x -> acc + f x) 0

let rec seq_nth n seq =
  let ( >>= ) = Option.bind in
  Seq.uncons seq >>= fun (x, xs) -> if n = 0 then Some x else seq_nth (n - 1) xs

let arr_nth n arr =
  if 0 <= n && n < Array.length arr then Some (Array.unsafe_get arr n) else None

let arr_swap arr a b =
  let tmp = arr.(a) in
  arr.(a) <- arr.(b);
  arr.(b) <- tmp

let rec list_remove_nth n xs =
  match xs with
  | x :: xs -> if n = 0 then xs else x :: list_remove_nth (n - 1) xs
  | [] -> invalid_arg "remove_nth: Index out of bounds"

let list_split_by f =
  let rec aux l r =
    match r with
    | x :: xs -> if f x then (l, xs) else aux (l @ [ x ]) xs
    | [] -> (l, [])
  in
  aux []

let add_to_list tbl key value =
  match Hashtbl.find_opt tbl key with
  | Some list -> Hashtbl.replace tbl key (value :: list)
  | None -> Hashtbl.add tbl key [ value ]

let tbl_contains tbl key = Hashtbl.find_opt tbl key |> Option.is_some

let str_empty s = String.length s = 0

let str_drop_last n s = String.sub s 0 (String.length s - n)

let digits n =
  if n = 0 then 1
  else
    let rec aux n = if n = 0 then 0 else 1 + aux (n / 10) in
    aux n

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
