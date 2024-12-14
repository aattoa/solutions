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

val array_nth : 'a array -> int -> 'a option

val remove_nth : int -> 'a list -> 'a list

val add_to_list : ('a, 'b list) Hashtbl.t -> 'a -> 'b -> unit
val tbl_contains : ('a, 'b) Hashtbl.t -> 'a -> bool

val str_drop_last : int -> string -> string

val digits : int -> int

val lines : string -> string list

val read_file : string -> string

val todo : string -> 'a
