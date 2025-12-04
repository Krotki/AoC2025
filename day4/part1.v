module main

import os

fn main() {
	input := os.get_raw_lines()

	mut count := 0

	for y in 0..input.len {
		for x in 0..input[0].len {
			if input[y][x] == `@` {
				mut adjacent := 0
				for dy in -1..2 {
					for dx in -1..2 {
						ny := y + dy
						nx := x + dx
						if ny >= 0 && ny < input.len && nx >= 0 && nx < input[0].len {
							if input[ny][nx] == `@` {
								adjacent++
							}
						}
					}
				}
				adjacent-- // subtract self
				if adjacent < 4 {
					count++
				}
			}
		}
	}

	println(count)
}
