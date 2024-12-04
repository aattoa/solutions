open Alcotest
open Oaoc

let case name = test_case name `Quick

let range =
  let check = check (list int) "int list equal" in
  let range lo hi = Util.range lo hi |> List.of_seq in
  [
    case "empty" (fun () -> check [] (range 1 1));
    case "increasing" (fun () -> check [ 1; 2; 3 ] (range 1 4));
    case "decreasing" (fun () -> check [] (range 4 1));
  ]

let remove_nth =
  let check = check (list int) "int list equal" in
  let remove n = Util.remove_nth n [ 10; 20; 30 ] in
  [
    case "0" (fun () -> check [ 20; 30 ] (remove 0));
    case "1" (fun () -> check [ 10; 30 ] (remove 1));
    case "2" (fun () -> check [ 10; 20 ] (remove 2));
  ]

let any =
  let check = check bool "bool equal" in
  let any bs = List.to_seq bs |> Util.any in
  [
    case "empty" (fun () -> check false (any []));
    case "one false" (fun () -> check true (any [ true; true; true; false ]));
    case "one true" (fun () -> check true (any [ false; false; false; true ]));
  ]

let all =
  let check = check bool "bool equal" in
  let all bs = List.to_seq bs |> Util.all in
  [
    case "empty" (fun () -> check true (all []));
    case "one false" (fun () -> check false (all [ true; true; false ]));
    case "one true" (fun () -> check false (all [ false; false; true ]));
    case "all false" (fun () -> check false (all [ false; false; false ]));
    case "all true" (fun () -> check true (all [ true; true; true ]));
  ]

let is_some_and =
  let check = check bool "bool equal" in
  let is_some_and = Util.is_some_and Util.id in
  [
    case "none" (fun () -> check false (is_some_and None));
    case "some false" (fun () -> check false (is_some_and (Some false)));
    case "some true" (fun () -> check true (is_some_and (Some true)));
  ]

let is_none_or =
  let check = check bool "bool equal" in
  let is_none_or = Util.is_none_or Util.id in
  [
    case "none" (fun () -> check true (is_none_or None));
    case "some false" (fun () -> check false (is_none_or (Some false)));
    case "some true" (fun () -> check true (is_none_or (Some true)));
  ]

let () =
  run "Util"
    [
      ("range", range);
      ("remove_nth", remove_nth);
      ("any", any);
      ("all", all);
      ("is_some_and", is_some_and);
      ("is_none_or", is_none_or);
    ]
