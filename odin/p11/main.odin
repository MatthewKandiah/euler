package p11

import "../util"
import "core:fmt"
import "core:os"

stride :: 20
numbers := [stride * stride]int{}
buf := [4]int{}

main :: proc() {
	{ 	// read in numbers from file
		data_path :: "data/p11.txt"
		data, ok := os.read_entire_file(data_path)
		if !ok {panic("Failed to read in data from file")}

		numbers_idx := 0
		digit1: int = -1
		digit2: int = -1
		for byte in data {
			if byte == ' ' || byte == '\n' {
				assert(digit1 >= 0)
				assert(digit1 < 10)
				assert(digit2 >= 0)
				assert(digit2 < 10)
				numbers[numbers_idx] = 10 * digit1 + digit2
				numbers_idx += 1
				digit1 = -1
				digit2 = -1
			} else {
				val := cast(int)(byte - '0')
				if digit1 < 0 {digit1 = val} else if digit2 < 0 {digit2 = val} else {unreachable()}
			}
		}
	}

	max_prod := 0
	{ 	// check horizontal
		for j in 0 ..< stride {
			for i in 0 ..< stride - 4 {
				buf[0] = get_number(i + 0, j)
				buf[1] = get_number(i + 1, j)
				buf[2] = get_number(i + 2, j)
				buf[3] = get_number(i + 3, j)
				max_prod = max(max_prod, get_buf_prod())
			}
		}
	}
	{ 	// check vertical
		for j in 0 ..< stride - 4 {
			for i in 0 ..< stride {
				buf[0] = get_number(i, j + 0)
				buf[1] = get_number(i, j + 1)
				buf[2] = get_number(i, j + 2)
				buf[3] = get_number(i, j + 3)
				max_prod = max(max_prod, get_buf_prod())
			}
		}
	}
	{ 	// check diagonal - top left to bottom right
		for j in 0 ..< stride - 4 {
			for i in 0 ..< stride - 4 {
				buf[0] = get_number(i + 0, j + 0)
				buf[1] = get_number(i + 1, j + 1)
				buf[2] = get_number(i + 2, j + 2)
				buf[3] = get_number(i + 3, j + 3)
				max_prod = max(max_prod, get_buf_prod())
			}
		}
	}
	{ 	//check diagonal - top right to bottom left
		for j in 0 ..< stride - 4 {
			for i in 0 ..< stride - 4 {
				buf[0] = get_number(i + 3, j + 0)
				buf[1] = get_number(i + 2, j + 1)
				buf[2] = get_number(i + 1, j + 2)
				buf[3] = get_number(i + 0, j + 3)
				max_prod = max(max_prod, get_buf_prod())
			}
		}
	}

	util.answer(max_prod)
}

get_number :: proc(x, y: int) -> int {
	return numbers[y * stride + x]
}

get_buf_prod :: proc() -> int {
	return buf[0] * buf[1] * buf[2] * buf[3]
}
