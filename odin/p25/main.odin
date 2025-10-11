package p25

import "core:fmt"
import "core:math/big"

TARGET :: 1000

main :: proc() {
    small_fib := big.Int{}
    big_fib := big.Int{}
    sum := big.Int{}

    big.one(&small_fib)
    big.one(&big_fib)
    index := 2

    for (count_big_int_decimal_digits(&big_fib) < TARGET) {
	index += 1
	big.int_add(&sum, &small_fib, &big_fib)
	big.int_copy(&small_fib, &big_fib)
	big.int_copy(&big_fib, &sum)
    }

    fmt.println("Answer: ", index)
}

count_big_int_decimal_digits :: proc(num: ^big.Int) -> int {
    x, _ := big.log(num, 10)
    return x + 1
}

