module main

import os

fn main() {
	input := os.get_raw_lines()

	mut sum := u64(0)

	for line in input {

		print('fir: ')
		mut max := line[0]
		mut maxi := 0
		for i in 1..(line.len - 2) {
			if line[i] > max {
				max = line[i]
				maxi = i
				print('$i ')
			}
		}
		print(' sec: ')
		mut sec := line[maxi+1]
		for j in (maxi+1)..line.len {
			if line[j] > sec {
				sec = line[j]
				print('$j ')
			}
		}
		joltage := '${max.ascii_str()}${sec.ascii_str()}'.u64()
		println('\nj: $joltage $maxi')
		sum += joltage
	}

	println(sum)
}
