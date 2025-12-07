module main

import os
import datatypes

fn main() {
	input := os.get_raw_lines()

	mut splits := 0
	mut beams := datatypes.Set[u8]{}

	// find first beam
	beams.add(u8(input[0].index('S')?))

	for line in input {
		mut nbeams := datatypes.Set[u8]{}
		for beam in beams.array() {
			if line[beam] == `^` {
				splits++
				nbeams.add(beam - 1)
				nbeams.add(beam + 1)
			} else {
				nbeams.add(beam)
			}
		}
		beams = nbeams
	}

	println(splits)
}
