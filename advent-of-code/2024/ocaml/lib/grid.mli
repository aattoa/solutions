type 'a t = { arr : 'a array; w : int; h : int }
type pos = { x : int; y : int }

module Pos : sig
  type t = pos
  val compare : t -> t -> int
  val advance : Direction.t -> t -> t
  val sub : t -> t -> t
  val add : t -> t -> t
end

val is_valid_pos : 'a t -> pos -> bool
val get_opt : 'a t -> pos -> 'a option
val get : 'a t -> pos -> 'a
val set : 'a t -> pos -> 'a -> unit

val positions : 'a t -> pos Seq.t
val find : ('a -> bool) -> 'a t -> pos option
val find_eq : 'a -> 'a t -> pos option

val of_string_lines : string -> char t
