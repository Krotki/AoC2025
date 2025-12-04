module main

import os

fn main() {
	input := os.get_raw_lines()

	mut sum := u64(0)

	for line in input {
		mut joltage := []u8{len: 12}
		mut ws := 0

		for n in 0 .. 12 {
			mut maxi := ws
			for i in ws .. (line.len - (12 - n)) {
				// println('n=${n} i=${i} line[i]=${line[i]} joltage[n]=${joltage[n]}')
				if line[i] > joltage[n] {
					joltage[n] = line[i]
					maxi = i + 1
					// println('ws: ${maxi:2} ')
				}
			}
			ws = maxi
		}

		println('j: ${joltage.bytestr():12}')
		sum += joltage.bytestr().u64()
	}

	println(sum)
}
