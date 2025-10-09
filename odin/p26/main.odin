package p26
import "core:fmt"

main :: proc() {
  result := 0
  result_cycle_len := 0
  for i in 2 ..< 1000 {
    cycle_len := get_reciprocal_cycle_len(i)
    if cycle_len > result_cycle_len {
      result = i
      result_cycle_len = cycle_len
    }
  }
  fmt.println("Result: ", result, "\nLongest cycle len: ", result_cycle_len)
}

Record :: struct {
  digit: int,
  carry: int,
  index: int,
}

get_reciprocal_cycle_len :: proc(denominator: int) -> int {
  carry := 1
  index := 0
  records := make([dynamic]Record)
  for {
    numerator := carry * 10
    digit := numerator / denominator
    carry = numerator % denominator
    if carry == 0 {
      return -1
    }
    new_record := Record {
      digit = digit,
      carry = carry,
      index = index,
    }
    for record in records {
      if record.digit == new_record.digit && record.carry == new_record.carry {
        return new_record.index - record.index
      }
    }
    append(&records, new_record)
    index += 1
  }
}
