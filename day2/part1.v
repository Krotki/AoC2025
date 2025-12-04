module main

import os

struct Range {
	start u64
	end   u64
}

fn main() {
	input := os.get_line().split(',').map(Range{
		start: it.split('-')[0].u64()
		end: it.split('-')[1].u64()
	})

	mut result := u64(0)

	for r in input {
		for n in r.start .. r.end+1 {
			s := n.str()
			if s.len % 2 == 0 && s[..s.len / 2] == s[s.len / 2..] {
				println(n)
				result += n
			}
		}
	}

	println(result)
}
