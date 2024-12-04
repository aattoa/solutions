type 'a t = { arr : 'a array; w : int; h : int }
type pos = { x : int; y : int }

val get_opt : 'a t -> pos -> 'a option
val get : 'a t -> pos -> 'a
val set : 'a t -> pos -> 'a -> unit
val of_string_lines : string -> char t
