module main

import os
import arrays

fn main() {
	input := os.get_raw_lines()

	mut beams := []u64{len: input[0].len}

	// find first beam
	beams[input[0].index('S')?] = 1

	for line in input {
		for i, c in line {
			if c == `^` {
				beams[i - 1] += beams[i]
				beams[i + 1] += beams[i]
				beams[i] = 0
			}
		}
	}

	dump(beams)

	res := arrays.sum(beams)!

	println(res)
}
