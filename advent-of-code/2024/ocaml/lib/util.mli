module Ops : sig
  val ( <. ) : ('b -> 'c) -> ('a -> 'b) -> 'a -> 'c
  val ( >. ) : ('a -> 'b) -> ('b -> 'c) -> 'a -> 'c
  val ( += ) : int ref -> int -> unit
  val ( -= ) : int ref -> int -> unit
end

val int_of_bool : bool -> int
val int_of_digit : char -> int

val is_some_and : ('a -> bool) -> 'a option -> bool
val is_none_or : ('a -> bool) -> 'a option -> bool
val get_or_else : (unit -> 'a) -> 'a option -> 'a

val sum : ('a -> int) -> 'a Seq.t -> int

val seq_nth : int -> 'a Seq.t -> 'a option
val arr_nth : int -> 'a array -> 'a option
val arr_swap : 'a array -> int -> int -> unit

val list_remove_nth : int -> 'a list -> 'a list
val list_split_by : ('a -> bool) -> 'a list -> 'a list * 'a list

val add_to_list : ('a, 'b list) Hashtbl.t -> 'a -> 'b -> unit
val tbl_contains : ('a, 'b) Hashtbl.t -> 'a -> bool

val str_empty : string -> bool
val str_drop_last : int -> string -> string

val digits : int -> int

val lines : string -> string list

val read_file : string -> string

val todo : string -> 'a
