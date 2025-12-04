module main

import os

fn main() {
	mut input := os.get_raw_lines().map(it.bytes())

	mut count := 0

	for {
		mut lcount := 0
		mut ninput := input.clone()
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
						lcount++
						ninput[y][x] = `.`
					}
				}
			}
		}
		if lcount == 0 {
			break
		}
		input = unsafe { ninput }
	}

	println(count)
}
