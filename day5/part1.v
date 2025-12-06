module main

import os

struct Range {
	start u64
	stop  u64
}

fn (r Range) contains(n u64) bool {
	return r.start <= n && r.stop >= n
}

fn main() {
	input := os.get_trimmed_lines()

	mut count := 0

	mut ranges := []Range{}

	mut i := 0
	for {
		if input[i] == '' {
			break
		}

		split := input[i].split('-')
		ranges << Range{
			start: split[0].u64()
			stop: split[1].u64()
		}

		i++
	}

	for j in (i + 1) .. input.len {
		if ranges.any(it.contains(input[j].u64())) {
			count++
		}
	}

	println(count)
}
