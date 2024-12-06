open Alcotest
open Oaoc

let case name = test_case name `Quick

let remove_nth =
  let check = check (list int) "int list equal" in
  let remove n = Util.remove_nth n [ 10; 20; 30 ] in
  [
    case "0" (fun () -> check [ 20; 30 ] (remove 0));
    case "1" (fun () -> check [ 10; 30 ] (remove 1));
    case "2" (fun () -> check [ 10; 20 ] (remove 2));
  ]

let is_some_and =
  let check = check bool "bool equal" in
  let is_some_and = Util.is_some_and Fun.id in
  [
    case "none" (fun () -> check false (is_some_and None));
    case "some false" (fun () -> check false (is_some_and (Some false)));
    case "some true" (fun () -> check true (is_some_and (Some true)));
  ]

let is_none_or =
  let check = check bool "bool equal" in
  let is_none_or = Util.is_none_or Fun.id in
  [
    case "none" (fun () -> check true (is_none_or None));
    case "some false" (fun () -> check false (is_none_or (Some false)));
    case "some true" (fun () -> check true (is_none_or (Some true)));
  ]

let () =
  run "Util"
    [
      ("remove_nth", remove_nth);
      ("is_some_and", is_some_and);
      ("is_none_or", is_none_or);
    ]
