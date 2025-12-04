module main

import net.http
import os
import cli
import net.html
import time
import toml

fn main() {

	config := toml.parse_file('aoc.toml')!
	year := config.value('year').int()

	mut app := cli.Command{
		name:        'aoc.vsh'
		description: 'Advent of Code'
		execute:     fn (cmd cli.Command) ! {
			println(cmd.help_message())
			return
		}
		commands:    [
			cli.Command{
				name:    'day'
				execute: fn [config, year] (cmd cli.Command) ! {
					day := get_current_day(cmd, year)
					setup_day(config, day)!
					return
				}
			},
			cli.Command{
				name:    'test'
				execute: fn (cmd cli.Command) ! {

					return
				}
			},
			// cli.Command{
			// 	name:    'submit'
			// 	execute: fn (cmd cli.Command) ! {
			// 		day := get_current_day(cmd)
			// 		submit(day, 1, ans)
			// 		return
			// 	}
			// },
		]
	}
	app.setup()
	app.parse(os.args)
}

fn setup_day(config toml.Doc, day int) ! {

	year := (config.value_opt('year') or {toml.Any(time.now().year)}).int()

	path := './day${day}'
	cookies := {
		'session': config.value('session').string()
	}

	os.mkdir_all(path) or {
		eprintln('ERROR: Could not create (${path}) directory due to:\n${err}')
		exit(1)
	}

	http.download_file_with_cookies('https://adventofcode.com/${year}/day/${day}/input',
		'${path}/input.txt', cookies) or {
		eprintln('ERROR: Could not download your puzzle input due to:\n${err}')
		exit(2)
	}

	response := http.get('https://adventofcode.com/${year}/day/${day}') or {
		eprintln(err)
		exit(1)
	}
	if response.status_code != 200 {
		eprintln('During solution upload AoC returned ${response.status_code} status code. Expected 200!')
		exit(4)
	}
	doc := html.parse(response.body)
	code_tags := doc.get_tags(name: 'code').filter(it.parent.name == 'pre')
	if code_tags.len > 0 {
		for i, tag in code_tags {
			os.write_file('${path}/example${i+1}.txt', tag.text()) or {
				eprintln('ERROR: writing ${path}/example${i+1}.txt failed:\n${err}')
			}
		}
	} else {
		eprintln('No examples found in puzzle description!')
	}

	template := "
	module main

	import os

	fn main() {
		input := os.get_raw_lines()



		println(input)
	}
	".trim_indent()
	os.write_file('${path}/part1.v', template)!
	os.write_file('${path}/part2.v', template)!
}

fn get_current_day(cmd cli.Command, year int) int {
	ct := time.now()
	return if ct.year == year && ct.month == 12 {
		ct.day
	} else if cmd.args.len == 0 {
		eprintln('It is not a December of ${year}! Please specify day number as a next argument! ex. 1..25')
		exit(1)
	} else {
		if cmd.args[0].is_int() {
			cmd.args[0].int()
		} else {
			eprintln('Expected day number ex. 2, got ${cmd.args[0]}')
			exit(1)
		}
	}
}

// fn sumbit(day int, puzzle int) {
// 	response := http.post_form_with_cookies('https://adventofcode.com/${year}/day/${day}/answer',
// 		{
// 		'level':  '1'
// 		'answer': '123'
// 	}, cookies) or {
// 		eprintln('ERROR: Could not upload your puzzle output due to:\n${err}')
// 		exit(3)
// 	}
// 	if response.status_code != 200 {
// 		eprintln('During solution upload AoC returned ${response.status_code} status code. Expected 200!')
// 		exit(4)
// 	}
// 	doc := html.parse(response.body)
// 	doc.get_tags(name: 'code')
// }
