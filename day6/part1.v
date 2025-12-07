module main

import os

fn main() {
	input := os.get_raw_lines().map(it.split_by_space())

	mut sum := u64(0)

	for col in 0 .. input[0].len {
		op := input.last()[col]
		mut result := u64(0)
		for row in 0 .. input.len - 1 {
			match op {
				'+' {
					result += input[row][col].u64()
				}
				'*' {
					if row == 0 {
						result = 1
					}
					result *= input[row][col].u64()
				}
				else {
					panic('unknown operation: ${op}')
				}
			}
			input[row][col].u64()
		}
		sum += result
	}

	println(sum)
}
