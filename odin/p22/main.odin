package p22

import "../util"
import "core:fmt"
import "core:strings"

DATA_PATH :: "data/p22.txt"

main :: proc() {
  data := util.read_lines_from_file(DATA_PATH)[0]
  values: [dynamic][]u8
  for name_with_quotes in strings.split_iterator(&data, ",") {
    name := name_with_quotes[1:len(name_with_quotes) - 1]
    ascii_values := transmute([]u8)name
    alphabet_values := ascii_to_alphabet_values(ascii_values)
    append(&values, alphabet_values)
  }
  sort(values)

  sum: u64 = 0
  for value, idx in values {
    pos := cast(u64)idx + 1
    word_sum: u64 = 0
    for c in value {
      word_sum += cast(u64)c
    }
    sum += pos * word_sum
  }

  fmt.println("Answer: ", sum)
}

ascii_to_alphabet_values :: proc(ascii_values: []u8) -> []u8 {
  values := make([]u8, len(ascii_values))
  for value, idx in ascii_values {
    values[idx] = value - 'A' + 1
  }
  return values
}

sort :: proc(ascii_values: [dynamic][]u8) {
  start_point := len(ascii_values) - 2
  for start_point >= 0 {
    test_point := start_point
    for test_point < len(ascii_values) - 1 {
      left := ascii_values[test_point]
      right := ascii_values[test_point + 1]
      if comes_before(left, right) {
        break
      }
      temp := right
      ascii_values[test_point + 1] = left
      ascii_values[test_point] = temp
      test_point += 1
    }
    start_point -= 1
  }
}

// assuming a string prefix "comes before" the longer string
comes_before :: proc(value, cmp: []u8) -> bool {
  for c, idx in value {
    if idx < len(cmp) {
      c_cmp := cmp[idx]
      if c < c_cmp {return true}
      if c > c_cmp {return false}
    } else {
      return false
    }
  }
  return true
}
