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
    {
      day = 7;
      part1 = "3749";
      part2 = "11387";
      input =
        [
          "190: 10 19";
          "3267: 81 40 27";
          "83: 17 5";
          "156: 15 6";
          "7290: 6 8 6 15";
          "161011: 16 10 13";
          "192: 17 8 14";
          "21037: 9 7 18 13";
          "292: 11 6 16 20";
        ];
    };
    {
      day = 8;
      part1 = "14";
      part2 = "34";
      input =
        [
          "............";
          "........0...";
          ".....0......";
          ".......0....";
          "....0.......";
          "......A.....";
          "............";
          "............";
          "........A...";
          ".........A..";
          "............";
          "............";
        ];
    };
    {
      day = 10;
      part1 = "36";
      part2 = "81";
      input =
        [
          "89010123";
          "78121874";
          "87430965";
          "96549874";
          "45678903";
          "32019012";
          "01329801";
          "10456732";
        ];
    };
    {
      day = 11;
      part1 = "55312";
      part2 = "65601038650482";
      input = [ "125 17" ];
    };
    {
      day = 12;
      part1 = "1930";
      part2 = "p2";
      input =
        [
          "RRRRIICCFF";
          "RRRRIICCCF";
          "VVRRRCCFFF";
          "VVRCCCJFFF";
          "VVVVCJJCFE";
          "VVIVCCJJEE";
          "VVIIICJJEE";
          "MIIIIIJJEE";
          "MIIISIJEEE";
          "MMMISSJEEE";
        ];
    };
    {
      day = 15;
      part1 = "2028";
      part2 = "p2";
      input =
        [
          "########";
          "#..O.O.#";
          "##@.O..#";
          "#...O..#";
          "#.#.O..#";
          "#...O..#";
          "#......#";
          "########";
          "";
          "<^^>>>vv<v>>v<<";
        ];
    };
    {
      day = 15;
      part1 = "10092";
      part2 = "p2";
      input =
        [
          "##########";
          "#..O..O.O#";
          "#......O.#";
          "#.OO..O.O#";
          "#..O@..O.#";
          "#O#..O...#";
          "#O..O..O.#";
          "#.OO.O.OO#";
          "#....O...#";
          "##########";
          "";
          "<vv>^<v^>v>^vv^v>v<>v^v<v<^vv<<<^><<><>>v<vvv<>^v^>^<<<><<v<<<v^vv^v>^";
          "vvv<<^>^v^^><<>>><>^<<><^vv^^<>vvv<>><^^v>^>vv<>v<<<<v<^v>^<^^>>>^<v<v";
          "><>vv>v^v^<>><>>>><^^>vv>v<^^^>>v^v^<^^>v^^>v^<^v>v<>>v^v^<v>v^^<^^vv<";
          "<<v<^>>^^^^>>>v^<>vvv^><v<<<>^^^vv^<vvv>^>v<^^^^v<>^>vvvv><>>v^<<^^^^^";
          "^><^><>>><>^^<<^^v>>><^<v>^<vv>>v>>>^v><>^v><<<<v>>v<v<v>vvv>^<><<>^><";
          "^>><>^v<><^vvv<^^<><v<<<<<><^v<<<><<<^^<v<^^^><^>>^<v^><<<^>>^v<v^v<v^";
          ">^>>^v>vv>^<<^v<>><<><<v<<v><>v<^vv<<<>^^v^>^^>>><<^v>>v^v><^^>>^<>vv^";
          "<><^^>^^^<><vvvvv^v<v<<>^v<v>v<<^><<><<><<<^^<<<^<<>><<><^^^>^^<>^>v<>";
          "^^>vv<^v^v<vv>^<><v<^v>^^^>>>^^vvv^>vvv<>>>^<^>>>>>^<<^v>^vvv<>^<><<v>";
          "v^^>>><<^^<>>^v^<v^vv<>v^<<>^<^v^v><^<<<><<^<v><v<>vv>>v><v^<vv<>v^<<^";
        ];
    };
    {
      day = 17;
      part1 = "4,6,3,5,6,3,5,2,1,0";
      part2 = "p2";
      input =
        [
          "Register A: 729";
          "Register B: 0";
          "Register C: 0";
          "";
          "Program: 0,1,5,4,3,0";
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
