package p4

import "../util"
import "core:fmt"

main :: proc() {
	max_found := 0
	for i in 1 ..< 1000 {
		for j in 1 ..< 1000 {
			if i * j > max_found && is_palindrome(cast(i64)(i * j)) {
				max_found = i * j
			}
		}
	}
  util.answer(max_found)
}

is_palindrome :: proc(n: i64) -> bool {
	remainders: [dynamic]i64
	var := n
	for var > 0 {
		append(&remainders, var % 10)
		var /= 10
	}

	for i in 0 ..< len(remainders) {
		if remainders[i] != remainders[len(remainders) - 1 - i] {return false}
	}
	return true
}
