module main

import os

fn main() {
	input := os.get_raw_lines()

	mut c := 50
	mut pw := 0

	for line in input {
		mut n := line[1..].int()
		if line[0] == `L` {
			n = -n
		}
		c += n

		for c >= 100 {
			c -= 100
		}
		for c < 0 {
			c += 100
		}

		if c == 0 {
			pw++
		}
	}

	println(pw)
}
