package p67

import "../util"
import "core:fmt"
import "core:slice"

DATA_PATH :: "data/p67.txt"

main :: proc() {
  lines := util.read_lines_from_file(DATA_PATH)
  num_triangle: [dynamic][dynamic]int
  for line in lines {
    append(&num_triangle, util.split_line_to_ints(line))
  }

  res := get_max_path(num_triangle)
  util.answer(res)
}

get_max_path :: proc(num_triangle: [dynamic][dynamic]int) -> int {
  num_triangle := num_triangle
  target := len(num_triangle) - 2
  for i := len(num_triangle) - 2; i >= 0; i -= 1 {
    reduce(i, &num_triangle)
  }
  return num_triangle[0][0]
}

reduce :: proc(target: int, num_triangle: ^[dynamic][dynamic]int) {
  for &num, idx in num_triangle[target] {
    left := num_triangle[target + 1][idx]
    right := num_triangle[target + 1][idx + 1]
    num += max(left, right)
  }
}
