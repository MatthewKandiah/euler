package p12

TARGET :: 500

import "../util"
import "core:fmt"

main :: proc() {
	max_divisor_count := 0

	triangle_num := 1
	add_next := 2
	divisor_count := get_divisor_count(triangle_num)
	for divisor_count <= TARGET {
		maybe_max_devisor_count := max(max_divisor_count, divisor_count)
		if maybe_max_devisor_count != max_divisor_count {
			fmt.println(maybe_max_devisor_count)
		}
		max_divisor_count = maybe_max_devisor_count
		triangle_num += add_next
		add_next += 1
		divisor_count = get_divisor_count(triangle_num)
	}

	util.answer(triangle_num)
}

get_divisor_count :: proc(n: int) -> int {
	count := 2 // 1 and n - will get the wrong answer for 1, but we don't care for this problem
	for i in 1 ..< n / 2 {
		if n % i == 0 {count += 1}
	}
	return count
}
