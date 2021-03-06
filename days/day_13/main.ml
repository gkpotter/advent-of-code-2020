open Core

let file = "input.txt"

let part_one start bus_ids =
	let rec check time = 
		match
			List.find bus_ids ~f:(fun (bus_id,_) -> (time mod bus_id = 0))
		with
		| Some bus_id -> (bus_id, time)
		| None -> check (time + 1)
	in
	let (earliest,_), time = check start in
	earliest * (time - start)
;;

(* solve x + a = 0 (mod m) by sieving*)
let crt equations = 
	let rec crt equations x step =
		match equations with
		| (m, a) :: rest ->
			if (x+a) mod m = 0 
			then crt rest x (step*m)
			else crt equations (x+step) step
		| [] -> x
	in
	crt equations 0 1

let part_two bus_ids = crt bus_ids 

let () = 
	let start_time = Unix.gettimeofday () in
	let input = In_channel.create file in
	let start = int_of_string (Option.value_exn (In_channel.input_line input)) in
	let bus_ids = 
		input
		|> In_channel.input_line
		|> Option.value_exn 
		|> String.split ~on:','
		|> List.foldi ~init:[] ~f:(fun i acc bus_id -> 
				if String.(=) bus_id "x" then acc
				else (acc @ [((int_of_string bus_id),i)])
			)
		|> List.sort ~compare:(fun (a,_) (b,_) -> b - a)
	in
	let part_one_ans = part_one start bus_ids in
	let part_two_ans = part_two bus_ids in
	printf "Day 13 (%.3fs)\n" ((Unix.gettimeofday ()) -. start_time);
	printf "  Part 1: %d\n" part_one_ans;
	printf "  Part 2: %d\n" part_two_ans
;;
