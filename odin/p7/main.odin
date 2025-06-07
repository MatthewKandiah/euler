package p7

import "../util"
import "core:fmt"

main :: proc() {
	target :: 10001

	util.primes_init()

	for len(util.primes) < target {
		util.primes_get_next()
	}

	util.answer(cast(int)util.primes[target - 1])
}
