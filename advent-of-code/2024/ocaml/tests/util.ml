open Alcotest
open Oaoc

let case name = test_case name `Quick

let list_remove_nth =
  let check = check (list int) "int list equal" in
  let remove n = Util.list_remove_nth n [ 10; 20; 30 ] in
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

let int_of_digit =
  let check = check int "int equal" in
  [
    (case "0" @@ fun () -> check 0 (Util.int_of_digit '0'));
    (case "5" @@ fun () -> check 5 (Util.int_of_digit '5'));
    (case "9" @@ fun () -> check 9 (Util.int_of_digit '9'));
  ]

let () =
  run "Util"
    [
      ("list_remove_nth", list_remove_nth);
      ("is_some_and", is_some_and);
      ("is_none_or", is_none_or);
      ("int_of_digit", int_of_digit);
    ]
