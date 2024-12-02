type case = { day : int; input : string list; part1 : string; part2 : string }

let cases : case list =
  [
    {
      day = 1;
      part1 = "11";
      part2 = "31";
      input = [ "3   4"; "4   3"; "2   5"; "1   3"; "3   9"; "3   3" ];
    };
    {
      day = 2;
      part1 = "2";
      part2 = "4";
      input =
        [
          "7 6 4 2 1";
          "1 2 7 8 9";
          "9 7 6 2 1";
          "1 3 2 4 5";
          "8 6 4 4 1";
          "1 3 6 7 9";
        ];
    };
  ]

let test case =
  let module Day = (val Oaoc.Days.day case.day) in
  let check_eq = Alcotest.(check string) "equal" in
  ( Printf.sprintf "Day %i" case.day,
    [
      Alcotest.test_case "Part 1" `Quick (fun () ->
          check_eq case.part1 (Day.part1 (Array.of_list case.input)));
      Alcotest.test_case "Part 2" `Quick (fun () ->
          check_eq case.part2 (Day.part2 (Array.of_list case.input)));
    ] )

let () = Alcotest.run "Days" (List.map test cases)
