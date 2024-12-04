open Oaoc
open Alcotest

let case name = test_case name `Quick
let check_int = check int "int equal"
let check_chars = check (array char) "char array equal"

let get =
  let list = [ 10; 20; 30; 40; 50; 60; 70; 80; 90 ] in
  let grid : int Grid.t = { arr = Array.of_list list; w = 3; h = 3 } in
  let get expected x y =
    let name = Printf.sprintf "x:%i, y:%i" x y in
    case name (fun () -> check_int expected (Grid.get grid { x; y }))
  in
  [
    get 10 0 0;
    get 20 1 0;
    get 30 2 0;
    get 40 0 1;
    get 50 1 1;
    get 60 2 1;
    get 70 0 2;
    get 80 1 2;
    get 90 2 2;
  ]

let of_string_lines =
  let grid = Grid.of_string_lines "abc\ndef\nghi" in
  [
    case "array" (fun () ->
        check_chars ("abcdefghi" |> String.to_seq |> Array.of_seq) grid.arr);
    case "width 3" (fun () -> check_int 3 grid.w);
    case "height 3" (fun () -> check_int 3 grid.h);
  ]

let () = run "Grid" [ ("get", get); ("of_string_lines", of_string_lines) ]
