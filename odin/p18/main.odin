package p18

// let's brute force on this one, and try to do something smarter in p67

import "../util"
import "core:fmt"

DATA_PATH :: "data/p18.txt"

main :: proc() {
  lines := util.read_lines_from_file(DATA_PATH)
  num_triangle: [dynamic][dynamic]int
  for line in lines {
    append(&num_triangle, util.split_line_to_ints(line))
  }

  res := path_sum(num_triangle, 0, 0)
  util.answer(res)
}

path_sum :: proc(num_triangle: [dynamic][dynamic]int, root_x: int, root_y: int) -> int {
  if root_y >= len(num_triangle) {return 0}
  left_sum := path_sum(num_triangle, root_x, root_y + 1)
  right_sum := path_sum(num_triangle, root_x + 1, root_y + 1)
  return num_triangle[root_y][root_x] + max(left_sum, right_sum)
}
