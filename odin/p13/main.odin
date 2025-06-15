package p13

import "../util"
import "core:fmt"
import "core:os"
import "core:strconv"
import "core:strings"

DATA_PATH :: "data/p13.txt"

full_numbers: [dynamic]string

/*
  there are 100 x 50 digit numbers
  we only want the most significant 10 digits of the sum
  => we only need to add the most significant 12 digits of these numbers, the less significant digits can't contribute to the digits we care about
*/

main :: proc() {
  read_input()

  result := 0
  for number in full_numbers {
    i, ok := strconv.parse_int(number[0:12])
    if !ok {panic("failed to parse int from string")}
    result += i
  }

  for result > 10_000_000_000 {
    result /= 10
  }
  util.answer(result)
}

read_input :: proc() {
  data, ok := os.read_entire_file(DATA_PATH)
  if !ok {panic("failed to read input from file")}

  it := string(data)
  for line in strings.split_lines_iterator(&it) {
    append(&full_numbers, line)
  }
}
