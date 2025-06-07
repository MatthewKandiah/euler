package p8

import "../util"
import "core:fmt"
import "core:os"
import "core:strconv"
import "core:unicode/utf8"

data_path :: "data/p8.txt"

main :: proc() {
	digits: [dynamic]int
	{ 	// read in digits from file
		data, data_ok := os.read_entire_file(data_path)
		if !data_ok {
			panic("failed to read in data from file")
		}
		defer delete(data)

		data_view := data[:]
		for (len(data_view) > 0) {
			rune, byte_count := utf8.decode_rune_in_bytes(data_view)
			data_view = data_view[byte_count:]
			if (rune == '\n') {continue}
			digit, digit_ok := strconv.parse_int(utf8.runes_to_string({rune}))
			if !digit_ok {panic("unexpected non-digit character")}
			append(&digits, digit)
		}
	}

	max_prod := 1
	{ 	// check all windows to find maximum product of consecutive digits
		window_size :: 13
		for i in 0 ..< len(digits) - window_size {
			window := digits[i:i + window_size]
			prod := 1
			for d in window {
				prod *= d
			}
			max_prod = max(max_prod, prod)
		}
	}

	util.answer(max_prod)
}
