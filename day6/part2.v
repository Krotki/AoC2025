module main

import os
import arrays

fn main() {
	input := os.get_raw_lines()

	mut sum := u64(0)
	mut op := u8(`+`)
	mut buf := []u64{cap: 5}

	for col in 0 .. input[0].len {
		if input.all(it[col] == ` ` || it[col] == `\n`) {
			match op {
				`+` { sum += arrays.sum(buf)! }
				`*` { sum += arrays.reduce(buf, |a, e| a * e)! }
				else {}
			}
			buf.clear()
			continue
		}
		if input.last()[col] != ` ` {
			op = input.last()[col]
		}
		mut str := ''
		for i in input#[..-1] {
			str += i[col].ascii_str()
		}
		buf << str.trim_space().u64()
	}

	println(sum)
}
