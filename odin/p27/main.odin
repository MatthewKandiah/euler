package p27

import "../util"
import "core:fmt"

A_LIMIT :: 999
B_LIMIT :: 1000

main :: proc() {
    max_primes_found := -1
    product := -1
    for a in -A_LIMIT ..= A_LIMIT {
        for b in -B_LIMIT ..= B_LIMIT {
            n := 0
            for {
                result := cast(i64)quadratic(n, a, b)
                if util.primes_is_prime(result) {
                    n += 1
                } else {
                    new_max_primes_found := max(max_primes_found, n)
		    if new_max_primes_found != max_primes_found {
			product = a * b
			max_primes_found = new_max_primes_found
		    }
		    break
                }
            }
        }
    }

    fmt.println("Result:", product)
}

quadratic :: proc(n, a, b: int) -> int {
    return (n * n) + (a * n) + b
}
