type t = Left | Up | Right | Down

let turn_right d =
  match d with Left -> Up | Up -> Right | Right -> Down | Down -> Left

let turn_left d =
  match d with Left -> Down | Up -> Left | Right -> Up | Down -> Right

let offset d =
  match d with
  | Left -> (-1, 0)
  | Up -> (0, -1)
  | Right -> (1, 0)
  | Down -> (0, 1)

let of_char char =
  match char with
  | '^' -> Up
  | 'v' -> Down
  | '<' -> Left
  | '>' -> Right
  | _ -> invalid_arg "bad direction"

let is_horizontal dir = dir = Left || dir = Right
let is_vertical dir = dir = Up || dir = Down
