package p16

import "../util"
import "core:fmt"
import "core:math/big"
import "core:strconv"

TARGET :: 1000

main :: proc() {
  prod := big.Int{}
  big.int_set_from_integer(&prod, 1)
  for _ in 0 ..< TARGET {
    big.int_mul_digit(&prod, &prod, big.DIGIT(2))
  }

  prod_digits, ok := big.int_to_string(&prod)
  if ok != .Okay {panic("failed to write big.Int to string")}
  sum := 0
  for digit in prod_digits {
    ascii := cast(int)digit
    digit_value := ascii - '0'
    sum += digit_value
  }
  util.answer(sum)
}
