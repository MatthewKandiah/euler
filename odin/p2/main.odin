package p2

import "../util"
import "core:fmt"

TARGET :: 4_000_000

main :: proc() {
  a := 1
  b := 1

  sum := 0
  for {
    next := a + b
    if next > TARGET {break}
    if next % 2 == 0 {
      sum += next
    }
    a = b
    b = next
  }

  util.answer(sum)
}
