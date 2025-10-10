package p24

import "core:fmt"

main :: proc() {
    list := []int{0, 1, 2, 3, 4, 5, 6, 7, 8, 9}
    for _ in 1..<1_000_000 {
	mutate_to_next_permutation(list)
    }
    fmt.println(list)
}

mutate_to_next_permutation :: proc(list: []int) {
    for i := len(list) - 2; i >= 0; i -= 1 {
        if list[i] < list[i + 1] {
            swap_index := i + 1 + smallest_element_index_larger_than(list[i + 1:], list[i])
            tmp := list[swap_index]
            list[swap_index] = list[i]
            list[i] = tmp
            reverse_elements(list[i + 1:])
            return
        }
    }
}

smallest_element_index_larger_than :: proc(list: []int, value: int) -> int {
    min_value := max(int)
    min_value_index := -1
    for i in 0 ..< len(list) {
        if list[i] < min_value && list[i] > value {
            min_value = list[i]
            min_value_index = i
        }
    }
    if min_value_index < 0 {panic("expected to find at least one element in the list less than value")}
    return min_value_index
}

reverse_elements :: proc(list: []int) {
    copy_list := make([]int, len(list))
    defer delete(copy_list)
    for el, i in list {
        copy_list[i] = el
    }
    for i in 0 ..< len(list) {
        list[i] = copy_list[len(list) - 1 - i]
    }
}
