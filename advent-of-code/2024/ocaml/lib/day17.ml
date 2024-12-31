let print out str = out := !out ^ if Util.str_empty !out then str else "," ^ str

open Util.Ops

let part1 input =
  Scanf.sscanf input
    "Register A: %i\nRegister B: %i\nRegister C: %i\n\nProgram: %s"
    (fun a b c program ->
      let a, b, c = (ref a, ref b, ref c) in
      let pointer = ref 0 in
      let output = ref String.empty in
      try
        while true do
          let instruction = program.[!pointer * 2] in
          let operand = program.[(!pointer + 1) * 2] in

          let combo () =
            match operand with
            | '0' .. '3' -> Util.int_of_digit operand
            | '4' -> !a
            | '5' -> !b
            | '6' -> !c
            | _ -> failwith "bad operand"
          in
          let literal () = Util.int_of_digit operand in

          let division () =
            let num = float_of_int !a in
            let denom = combo () |> float_of_int |> Float.pow 2. in
            int_of_float (num /. denom)
          in

          pointer += 2;
          match instruction with
          | '0' -> a := division ()
          | '1' -> b := !b lxor literal ()
          | '2' -> b := combo () mod 8
          | '3' -> if !a != 0 then pointer := literal ()
          | '4' -> b := !b lxor !c
          | '5' -> print output (combo () mod 8 |> string_of_int)
          | '6' -> b := division ()
          | '7' -> c := division ()
          | _ -> failwith "bad opcode"
        done
      with Invalid_argument _ -> !output)

(* TODO *)
let part2 _ = "p2"
