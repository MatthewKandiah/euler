package p42

import "core:fmt"
import "core:os"
import "core:strings"

input_path :: "words.txt"

main :: proc() {
    data, ok := os.read_entire_file(input_path)
    if !ok {
	fmt.eprintln("Failed to read data from", input_path)
	os.exit(1)
    }

    result := 0
    words := strings.split(string(data), ",")
    for word in words {
	value := word_value(word)
	if is_triangle_num(value) {
	    result += 1
	}
    }

    fmt.println("Result", result)
}

word_value :: proc(word: string) -> (sum: int) {
    for c in word {
	c_value := cast(u8)c
	if c_value == '"' {continue}
	sum += cast(int)(c_value - 'A' + 1)
    }
    return sum
}

triangle_num :: proc(n:int) -> int {
    return (n * (n+1)) / 2
}

is_triangle_num :: proc(n: int) -> bool {
    test_idx := 1
    for {
	t := triangle_num(test_idx)
	if t == n {return true}
	if t > n {return false}
	test_idx += 1
    }
}
