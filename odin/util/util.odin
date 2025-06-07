package util

import "core:fmt"
import "core:math"

answer :: proc(x: int) {
  fmt.println("Answer:", x)
}

primes: [dynamic]i64

primes_init :: proc() {
	if len(primes) == 0 {
		append(&primes, 2)
		append(&primes, 3)
	}
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

primes_get_to_at_least :: proc(n: i64) {
  if len(primes) == 0 { primes_init() }
  for primes[len(primes) - 1] < n {
    primes_get_next()
  }
}
