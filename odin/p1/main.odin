package p1

import "../util"
import "core:fmt"

/*
  Find the sum of all the multiples of 3 or 5 below 1000.
*/
TARGET :: 1000
main :: proc() {
  res := 0
  for i in 0 ..< TARGET {
    if i % 3 == 0 || i % 5 == 0 {
      res += i
    }
  }
  util.answer(res)
}
