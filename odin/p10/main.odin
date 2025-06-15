package p10

import "../util"
import "core:fmt"

main :: proc() {
  target :: 2_000_000
  util.primes_get_to_at_least(target)

  sum: i64 = 0
  for p in util.primes {
    if p >= target {break}
    sum += p
  }

  util.answer(cast(int)sum)
}
