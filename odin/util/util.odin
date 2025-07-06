package util

import "core:fmt"
import "core:math"
import "core:os"
import "core:strconv"
import "core:strings"

answer :: proc(x: int) {
  fmt.println("Answer:", x)
}

primes: [dynamic]i64

primes_init :: proc() {
  if len(primes) == 0 {
    append(&primes, 2)
    append(&primes, 3)
  }
}

primes_get_next :: proc() {
  candidate := primes[len(primes) - 1] + 2
  prime_found := false

  for !prime_found {
    max_possible_divisor := cast(i64)math.ceil(math.sqrt(cast(f64)candidate))
    divisor_found := false
    for prime in primes {
      if prime > max_possible_divisor {break}
      if candidate % prime == 0 {
        divisor_found = true
      }
    }
    if divisor_found {
      candidate += 2
    } else {
      prime_found = true
    }
  }

  append(&primes, candidate)
}

primes_get_to_at_least :: proc(n: i64) {
  if len(primes) == 0 {primes_init()}
  for primes[len(primes) - 1] < n {
    primes_get_next()
  }
}

read_lines_from_file :: proc(path: string) -> (out: [dynamic]string) {
  data, ok := os.read_entire_file(path)
  if !ok {panic("failed to read input from file")}

  it := string(data)
  for line in strings.split_lines_iterator(&it) {
    append(&out, line)
  }

  return
}

split_line_to_ints :: proc(line: string) -> (out: [dynamic]int) {
  line := line
  for x in strings.split_iterator(&line, " ") {
    n := strconv.atoi(x)
    append(&out, n)
  }
  return
}
