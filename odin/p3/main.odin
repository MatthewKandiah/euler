package p3

import "../util"
import "core:fmt"
import "core:math"

target :: 600_851_475_143

main :: proc() {
	util.primes_init()
	for cast(f64)util.primes[len(util.primes) - 1] < math.sqrt(cast(f64)target) {
		util.primes_get_next()
	}
	prime_factors: [dynamic]i64
	for p in util.primes {
		if target % p == 0 {
			append(&prime_factors, p)
		}
	}
	res := prime_factors[len(prime_factors) - 1]
	util.answer(cast(int)res)
}
