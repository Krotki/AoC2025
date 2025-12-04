module main

import os
import math

fn main() {
	input := os.get_raw_lines()

	mut c := 50
	mut pw := 0

	for line in input {
		mut n := line[1..].int()
		mut s := 1
		if line[0] == `L` {
			n = -n
			s = -1
		}

		print('${c:2} ${n:4} ')

		mut rot := 0
		for i in 1 .. math.abs(n) + 1 {
			if math.modulo_euclid(c + i * s, 100) == 0 {
				rot++
			}
		}

		pw += rot
		c = math.modulo_euclid(c + n, 100)

		println('r ${rot:-6} pw ${pw:-6}')
	}

	println(pw)
}
