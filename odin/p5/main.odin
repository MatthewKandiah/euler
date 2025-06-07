package p5

import "../util"
import "core:fmt"

main :: proc() {
	target :: 20
	test := target + 1
	for {
    done := true
		for divisor in 1 ..= target {
      if test % divisor != 0 {
        test += 1
        done = false
        break
      }
    }

    if done {break}
	}

  util.answer(test)
}
