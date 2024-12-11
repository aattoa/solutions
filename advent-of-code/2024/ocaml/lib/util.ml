let int_of_bool bool = if bool then 1 else 0

let is_some_and f opt = match opt with Some x -> f x | None -> false
let is_none_or f opt = match opt with Some x -> f x | None -> true
let get_or_else f opt = match opt with Some x -> x | None -> f ()

let sum f = Seq.fold_left (fun acc x -> acc + f x) 0

let array_nth arr n =
  if 0 <= n && n < Array.length arr then Some (Array.unsafe_get arr n) else None

let rec remove_nth n xs =
  match xs with
  | x :: xs -> if n = 0 then xs else x :: remove_nth (n - 1) xs
  | [] -> invalid_arg "remove_nth: Index out of bounds"

let add_to_list tbl key value =
  match Hashtbl.find_opt tbl key with
  | Some list -> Hashtbl.replace tbl key (value :: list)
  | None -> Hashtbl.add tbl key [ value ]

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
