package p6

import "../util"
import "core:fmt"

main :: proc() {
  start :: 1
  end :: 100

  util.answer(square_of_sum(start, end) - sum_of_squares(start, end))
}

sum_of_squares :: proc(start, end: int) -> int {
  sum := 0
  for i in start ..= end {
    sum += i * i
  }
  return sum
}

square_of_sum :: proc(start, end: int) -> int {
  sum := 0
  for i in start ..= end {
    sum += i
  }
  return sum * sum
}
