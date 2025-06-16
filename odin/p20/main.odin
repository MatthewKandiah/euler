package p20

import "../util"
import "core:fmt"
import "core:math/big"

TARGET :: 100

main :: proc() {
  fac := factorial(TARGET)

  fac_digits, ok := big.int_to_string(&fac)
  if ok != .Okay {panic("failed to write big.Int to string")}

  sum := 0
  for digit in fac_digits {
    ascii := cast(int)digit
    digit_value := ascii - '0'
    sum += digit_value
  }

  util.answer(sum)
}

factorial :: proc(n: u64) -> big.Int {
  prod := big.Int{}
  big.int_set_from_integer(&prod, 1)
  for i in 1 ..= n {
    big.int_mul_digit(&prod, &prod, big.DIGIT(i))
  }
  return prod
}
