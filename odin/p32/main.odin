package p32

import "core:fmt"

main :: proc() {
    // use hashmap as set
    pandigital_products := make(map[int]struct{})
    a := 1
    // digit count limits values that can be pandigital
    for a < 100_000_000 {
        b := 1
        for digit_count(a) + digit_count(b) < 9 {
            p := a * b
            if is_pandigital_triplet(a, b, p) {
                fmt.println(a, b, p)
                pandigital_products[p] = {}
            }
            b += 1
        }
        a += 1
    }

    sum := 0
    for k, v in pandigital_products {
        sum += k
    }
    fmt.println("Result:", sum)
}

digit_count :: proc(n: int) -> int {
    n := n
    count := 0
    for n > 0 {
        count += 1
        n /= 10
    }
    return count
}

is_pandigital_triplet :: proc(a, b, c: int) -> bool {
    DigitSet :: bit_set[1 ..= 9]
    seen_digits := DigitSet{}
    inputs := [3]int{a, b, c}
    for &input in inputs {
        for input > 0 {
            digit := input % 10
            input /= 10

            if digit == 0 {return false}
            if digit in seen_digits {
                return false
            } else {
                seen_digits += {digit}
            }
        }
    }
    for i in 1 ..= 9 {
        if !(i in seen_digits) {return false}
    }
    return true
}
