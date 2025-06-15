package p14

import "../util"

main :: proc() {
  max_len_found := 0
  result := 0
  for i in 1 ..< 1_000_000 {
    len := get_collatz_chain_length(i)
    if len > max_len_found {
      result = i
      max_len_found = len
    }
  }
  util.answer(result)
}

get_collatz_chain_length :: proc(start: int) -> int {
  n := start
  count := 1

  for n != 1 {
    count += 1
    if n % 2 == 0 {
      n = n / 2
    } else {
      n = 3 * n + 1
    }
  }

  return count
}
