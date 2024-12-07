val int_of_bool : bool -> int

val is_some_and : ('a -> bool) -> 'a option -> bool
val is_none_or : ('a -> bool) -> 'a option -> bool

val sum : ('a -> int) -> 'a Seq.t -> int

val array_nth : 'a array -> int -> 'a option

val remove_nth : int -> 'a list -> 'a list

val add_to_list : ('a, 'b list) Hashtbl.t -> 'a -> 'b -> unit

val str_drop_last : int -> string -> string

val lines : string -> string list

val read_file : string -> string

val todo : string -> 'a
