package p23

import "core:fmt"

MAX_ABUNDANT_NUMBER :: 28123

main :: proc() {
  abundant_numbers: [dynamic]u64
  for i in 0 ..= MAX_ABUNDANT_NUMBER {
    if is_abundant_number(cast(u64)i) {
      append(&abundant_numbers, cast(u64)i)
    }
  }

  numbers_that_are_sum_of_two_abundant_numbers: [dynamic]u64
  for i in 0 ..< len(abundant_numbers) {
    for j in 0 ..< len(abundant_numbers) {
      abundant_n1 := abundant_numbers[i]
      abundant_n2 := abundant_numbers[j]
      append(&numbers_that_are_sum_of_two_abundant_numbers, abundant_n1 + abundant_n2)
    }
  }
  fmt.println(len(numbers_that_are_sum_of_two_abundant_numbers))

  sum_of_numbers_that_cannot_be_written_as_sum_of_two_abundant_numbers: u64
  for i in 0 ..= 28123 {
    if !contains(cast(u64)i, numbers_that_are_sum_of_two_abundant_numbers[:]) {
      sum_of_numbers_that_cannot_be_written_as_sum_of_two_abundant_numbers += cast(u64)i
    }
  }

  fmt.println("Answer: ", sum_of_numbers_that_cannot_be_written_as_sum_of_two_abundant_numbers)
}

proper_divisors :: proc(n: u64) -> (res: [dynamic]u64) {
  for i in 1 ..< n {
    if n % i == 0 {
      append(&res, i)
    }
  }
  return
}

sum :: proc(ns: []u64) -> (res: u64) {
  for n in ns {
    res += n
  }
  return
}

is_abundant_number :: proc(n: u64) -> bool {
  divisors := proper_divisors(n)
  defer delete(divisors)
  sum_of_divisors := sum(divisors[:])
  return sum_of_divisors > n
}

contains :: proc(n: u64, list: []u64) -> bool {
  for el in list {
    if el == n {
      return true
    }
  }
  return false
}
