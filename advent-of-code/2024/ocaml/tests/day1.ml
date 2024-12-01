let input =
  Array.of_list [ "3   4"; "4   3"; "2   5"; "1   3"; "3   9"; "3   3" ]

let test_example expected part =
  Alcotest.test_case "Example input" `Quick (fun () ->
      Alcotest.(check string) "equal" expected (part input))

let () =
  Alcotest.run "Day 1"
    [
      ("Part 1", [ test_example "11" Oaoc.Day1.part1 ]);
      ("Part 2", [ test_example "31" Oaoc.Day1.part2 ]);
    ]
