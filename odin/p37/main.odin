package p37

import "../util"
import "core:fmt"
import "core:strconv"

main :: proc() {
    truncatable_primes_found := 0
    result: i64 = 0
    test_value: i64 = 11
    for truncatable_primes_found < 11 {
        if is_truncatable_prime(test_value) {
	    fmt.println("Truncatable prime:", test_value)
            result += test_value
            truncatable_primes_found += 1
        }
	test_value += 2
    }
    fmt.println("Result:", result)
}

is_truncatable_prime :: proc(input: i64) -> bool {
    stripped_numbers := get_stripped_numbers(input)
    for n in stripped_numbers {
        if !util.primes_is_prime(n) {return false}
    }
    return true
}

get_stripped_numbers :: proc(input: i64) -> []i64 {
    output := [dynamic]i64{}
    input_copy := input
    input_digits := [dynamic]u8{}
    for input_copy > 0 {
        append(&input_digits, cast(u8)(input_copy % 10))
        input_copy /= 10
    }
    digit_count := len(input_digits)
    for i in 0 ..< digit_count - 1 {
        append(&output, num_from_digits(input_digits[0:i + 1]))
        append(&output, num_from_digits(input_digits[digit_count - 1 - i:digit_count]))
    }
    append(&output, input)
    return output[:]
}

num_from_digits :: proc(digits: []u8) -> (result: i64) {
    for i in 0 ..< len(digits) {
        result *= 10
        result += cast(i64)digits[len(digits) - 1 - i]
    }
    return result
}
