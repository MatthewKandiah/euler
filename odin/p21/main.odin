package p21

import "../util"
import "core:fmt"

main :: proc() {
  result := 0
  for a in 1 ..< 10000 {
    b := sum_of_proper_divisors(a)
    a_prime := sum_of_proper_divisors(b)
    if a == a_prime && a != b {
      result += a
    }
  }
  util.answer(result)
}

sum_of_proper_divisors :: proc(n: int) -> (sum: int) {
  for a in 1 ..< n {
    if n % a == 0 {
      sum += a
    }
  }
  return
}
