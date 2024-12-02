open Alcotest
open Oaoc

let case name body = test_case name `Quick (fun () -> body)

let range =
  let check = check (list int) "int list equal" in
  let range lo hi = Util.range lo hi |> List.of_seq in
  [
    case "empty" (check [] (range 1 1));
    case "increasing" (check [ 1; 2; 3 ] (range 1 4));
    case "decreasing" (check [] (range 4 1));
  ]

let remove_nth =
  let check = check (list int) "int list equal" in
  let remove n = Util.remove_nth n [ 10; 20; 30 ] in
  [
    case "0" (check [ 20; 30 ] (remove 0));
    case "1" (check [ 10; 30 ] (remove 1));
    case "2" (check [ 10; 20 ] (remove 2));
  ]

let any =
  let check = check bool "bool equal" in
  let any bs = List.to_seq bs |> Util.any in
  [
    case "empty" (check false (any []));
    case "one false" (check true (any [ true; true; true; false ]));
    case "one true" (check true (any [ false; false; false; true ]));
  ]

let all =
  let check = check bool "bool equal" in
  let all bs = List.to_seq bs |> Util.all in
  [
    case "empty" (check true (all []));
    case "one false" (check false (all [ true; true; true; false ]));
    case "one true" (check false (all [ false; false; false; true ]));
    case "all false" (check false (all [ false; false; false; false ]));
    case "all true" (check true (all [ true; true; true; true ]));
  ]

let () =
  Alcotest.run "Util"
    [ ("range", range); ("remove_nth", remove_nth); ("any", any); ("all", all) ]
