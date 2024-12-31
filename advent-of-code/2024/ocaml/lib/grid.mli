type 'a t = { arr : 'a array; w : int; h : int }
type pos = { x : int; y : int }

module Pos : sig
  type t = pos
  val compare : t -> t -> int
  val advance : ?step:int -> Direction.t -> t -> t
  val sub : t -> t -> t
  val add : t -> t -> t
end

val is_valid_pos : 'a t -> pos -> bool
val get_opt : 'a t -> pos -> 'a option
val get : 'a t -> pos -> 'a
val set : 'a t -> pos -> 'a -> unit
val swap : 'a t -> pos -> pos -> unit

val positions : 'a t -> pos Seq.t
val find : ('a -> bool) -> 'a t -> pos option
val find_eq : 'a -> 'a t -> pos option

val fill : 'a t -> 'a -> unit
val make : int * int -> 'a -> 'a t
val of_lines : string list -> char t
val of_lines_map : (char -> 'a) -> string list -> 'a t
val of_string_lines : string -> char t
val of_string_lines_map : (char -> 'a) -> string -> 'a t
