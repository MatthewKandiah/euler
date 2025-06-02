package p3

import "../util"
import "core:fmt"
import "core:math"

primes: [dynamic]i64

TARGET :: 600_851_475_143

main :: proc() {
	primes_init()
	for cast(f64)primes[len(primes) - 1] < math.sqrt(cast(f64)TARGET) {
		primes_get_next()
	}
	prime_factors: [dynamic]i64
	for p in primes {
		if TARGET % p == 0 {
			append(&prime_factors, p)
		}
	}
	res := prime_factors[len(prime_factors) - 1]
	util.answer(cast(int)res)
}

primes_init :: proc() {
	append(&primes, 2)
	append(&primes, 3)
}

primes_get_next :: proc() {
	candidate := primes[len(primes) - 1] + 2
	prime_found := false

	for !prime_found {
		max_possible_divisor := cast(i64)math.ceil(math.sqrt(cast(f64)candidate))
		divisor_found := false
		for prime in primes {
			if prime > max_possible_divisor {break}
			if candidate % prime == 0 {
				divisor_found = true
			}
		}
		if divisor_found {
			candidate += 2
		} else {
			prime_found = true
		}
	}

	append(&primes, candidate)
}
