module main

import os
import strings

struct Range {
	start u64
	end   u64
}

fn main() {
	input := os.get_line().split(',').map(Range{
		start: it.split('-')[0].u64()
		end:   it.split('-')[1].u64()
	})

	mut result := u64(0)

	for r in input {
		for n in r.start .. r.end + 1 {
			s := n.str()
			for i in 1 .. (s.len / 2) + 1 {
				if s.len % i == 0 && strings.repeat_string(s[..i], s.len / i) == s {
					println(n)
					result += n
					break
				}
			}
		}
	}

	println(result)
}
