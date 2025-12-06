module main

import os
import math

struct Range {
	start u64
	stop  u64
}

fn (r Range) str() string {
	return '${r.start}-${r.stop}'
}

fn main() {
	input := os.get_trimmed_lines()

	mut count := u64(0)

	mut ranges := []Range{}

	mut i := 0
	for {
		if input[i] == '' {
			break
		}

		split := input[i].split('-')
		mut range := Range{
			start: split[0].u64()
			stop: split[1].u64()
		}

		mut indexes_to_remove := []int{}

		for j, r in ranges {
			if (range.start >= r.start && range.start <= r.stop) ||
			   (range.stop >= r.start && range.stop <= r.stop) ||
			   (range.start <= r.start && range.stop >= r.stop) {

				// println(ranges.str())
				// print('Merging ${range.str()} and ${r.str()}')

				range = Range{
					start: math.min(range.start, r.start)
					stop: math.max(range.stop, r.stop)
				}

				// println(' into ${range.str()}')

				indexes_to_remove << j
				// println('Indexes to remove: ${indexes_to_remove}')
			}

		}

		for j in indexes_to_remove.reverse() {
			ranges.delete(j)
		}

		ranges << range
		i++
	}

	ranges.sort(a.start < b.start)
	for r in 0..ranges.len-1 {
		if ranges[r].stop >= ranges[r+1].start {
			println('Ranges not merged properly: ${ranges[r].str()} and ${ranges[r+1].str()}')
		}
	}

	// println('Merged ranges (${ranges.len}):')
	// for r in ranges {
	// 	println(r.str())
	// }

	for r in ranges {
		count += r.stop - r.start + 1
	}

	println(count)
}
