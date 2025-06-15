package p9

import "../util"
import "core:fmt"
import "core:math"

main :: proc() {
  triplets: [dynamic]triplet
  for a in 1 ..= 998 {
    for b in 1 ..= 998 {
      c_squared := a * a + b * b
      if is_square_number(c_squared) {
        c := cast(int)math.round(math.sqrt(cast(f64)c_squared))
        append(&triplets, triplet{a, b, c})
      }
    }
  }

  for t in triplets {
    sum := t.a + t.b + t.c
    if sum == 1000 {
      util.answer(t.a * t.b * t.c)
      break
    }
  }
}

triplet :: struct {
  a: int,
  b: int,
  c: int,
}

is_square_number :: proc(n: int) -> bool {
  root := math.round(math.sqrt(cast(f64)n))
  return n == cast(int)(root * root)
}
