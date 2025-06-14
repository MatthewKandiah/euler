package p59

import "../util"
import "core:fmt"
import "core:os"
import "core:strconv"
import "core:strings"

INPUT :: "data/p59.txt"
COMMON_ENGLISH_WORDS := []string{"the", "and", "to", "have", "that"}

main :: proc() {
	input := read_input()
	decrypt_buf := make([]u8, len(input))
	key_buf: [3]u8

	count := 0

	outer: for a in 'a' ..= 'z' {
		key_buf[0] = cast(u8)a
		for b in 'a' ..= 'z' {
			key_buf[1] = cast(u8)b
			for c in 'a' ..= 'z' {
				key_buf[2] = cast(u8)c
				bytewise_cyclical_xor(input, decrypt_buf, key_buf[:])
				if contains_common_words(decrypt_buf) {
          break outer
				}
			}
		}
	}

  sum := 0
  for b in decrypt_buf {
    sum += cast(int)b
  }
  util.answer(sum)
}

contains_common_words :: proc(ascii_buf: []u8) -> bool {
	for word in COMMON_ENGLISH_WORDS {
		if !contains_word(ascii_buf, word) {
			return false
		}
	}
	return true
}

contains_word :: proc(ascii_buf: []u8, word: string) -> bool {
	for i in 0 ..< len(ascii_buf) - len(word) {
		all_match := true
		for j in 0 ..< len(word) {
			if ascii_buf[i + j] != word[j] {
				all_match = false
				break
			}
		}
		if all_match {return true}
	}
	return false
}

bytewise_cyclical_xor :: proc(input: []u8, output: []u8, password: []u8) {
	assert(len(input) == len(output))
	password_idx := 0
	for i in 0 ..< len(input) {
		output[i] = input[i] ~ password[password_idx]
		password_idx = (password_idx + 1) % len(password)
	}
}

read_input :: proc() -> []u8 {
	data, ok := os.read_entire_file(INPUT)
	if !ok {panic("failed to read input from file")}

	ascii_data_strings := strings.split(string(data), ",")
	// we get a \n on the last value
	// this is the only input we need to handle, feels simplest to just handle as special case
	ascii_data_strings[len(ascii_data_strings) - 1] = "94"
	ascii_data := make([]u8, len(ascii_data_strings))
	for str, i in ascii_data_strings {
		value, ok := strconv.parse_uint(str)
		if !ok {panic("failed to parse int from string")}
		ascii_data[i] = cast(u8)value
	}

	return ascii_data
}
