package p30

import "core:fmt"

main :: proc() {
    fmt.println("Test: expecting 19316")
    fmt.println(sum_of_numbers_who_meet_condition(4))

    fmt.println("Answer:")
    fmt.println(sum_of_numbers_who_meet_condition(5))
}

sum_of_numbers_who_meet_condition :: proc(exponent: int) -> int {
    sum := 0
    upper_limit := pow(10, exponent + 2) // haven't thought very hard about this value, just found that it works for exponent == 6
    for i in 2 ..< upper_limit {
        s := sum_of_digits_to_power(i, exponent)
        if s == i {
            fmt.println("Meets condition: ", s)
            sum += s
        }
    }
    return sum
}

sum_of_digits_to_power :: proc(x: int, exponent: int) -> int {
    x := x
    sum := 0
    for x > 0 {
        digit := x % 10
        sum += pow(digit, exponent)
        x /= 10
    }

    return sum
}

pow :: proc(x, pow: int) -> int {
    res := 1
    for _ in 0 ..< pow {
        res *= x
    }
    return res
}
