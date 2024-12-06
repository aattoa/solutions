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
    {
      day = 3;
      part1 = "161";
      part2 = "161";
      input =
        [
          "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))";
        ];
    };
    {
      day = 3;
      part1 = "161";
      part2 = "48";
      input =
        [
          "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))";
        ];
    };
    {
      day = 4;
      part1 = "18";
      part2 = "9";
      input =
        [
          "MMMSXXMASM";
          "MSAMXMSMSA";
          "AMXSXMAAMM";
          "MSAMASMSMX";
          "XMASAMXAMM";
          "XXAMMXXAMA";
          "SMSMSASXSS";
          "SAXAMASAAA";
          "MAMMMXMMMM";
          "MXMXAXMASX";
        ];
    };
    {
      day = 5;
      part1 = "143";
      part2 = "123";
      input =
        [
          "47|53";
          "97|13";
          "97|61";
          "97|47";
          "75|29";
          "61|13";
          "75|53";
          "29|13";
          "97|29";
          "53|29";
          "61|53";
          "97|53";
          "61|29";
          "47|13";
          "75|47";
          "97|75";
          "47|61";
          "75|61";
          "47|29";
          "75|13";
          "53|13";
          "";
          "75,47,61,53,29";
          "97,61,53,29,13";
          "75,29,13";
          "75,97,47,61,53";
          "61,13,29";
          "97,13,75,29,47";
        ];
    };
    {
      day = 6;
      part1 = "41";
      part2 = "6";
      input =
        [
          "....#.....";
          ".........#";
          "..........";
          "..#.......";
          ".......#..";
          "..........";
          ".#..^.....";
          "........#.";
          "#.........";
          "......#...";
        ];
    };
  ]

let test idx case =
  let module Day = (val Oaoc.Days.day case.day) in
  let check_eq = Alcotest.(check string) "equal" in
  let input = String.concat "\n" case.input in
  ( Printf.sprintf "Test %i, Day %i" idx case.day,
    [
      Alcotest.test_case "Part 1" `Quick (fun () ->
          check_eq case.part1 (Day.part1 input));
      Alcotest.test_case "Part 2" `Quick (fun () ->
          check_eq case.part2 (Day.part2 input));
    ] )

let () = Alcotest.run "Days" (List.mapi test cases)
