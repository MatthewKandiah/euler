package p33

import "core:fmt"

Fraction :: struct {
    num, den: int,
}

main :: proc() {
    digit_cancelling_fractions := [4]Fraction{}
    found_count := 0
    for num in 11 ..= 99 {
        for den in num + 1 ..= 99 {
            if is_trivial(num, den) {continue}
            if is_digit_cancelling_fraction(num, den) {
                digit_cancelling_fractions[found_count] = Fraction {
                    num = num,
                    den = den,
                }
                found_count += 1
            }
        }
    }
    result := fraction_simplify(fraction_multiply_many(digit_cancelling_fractions[:]))
    fmt.println("Result:", result)
}

gcd :: proc(n1, n2: int) -> int {
    a := n1
    b := n2
    for b != 0 {
        t := b
        b = a % b
        a = t
    }
    return a
}

fraction_simplify :: proc(f: Fraction) -> Fraction {
    d := gcd(f.num, f.den)
    return Fraction{num = f.num / d, den = f.den / d}
}

fraction_multiply :: proc(f1, f2: Fraction) -> Fraction {
    return Fraction{num = f1.num * f2.num, den = f1.den * f2.den}
}

fraction_multiply_many :: proc(fs: []Fraction) -> Fraction {
    result := Fraction {
        num = 1,
        den = 1,
    }
    for f in fs {
        result = fraction_multiply(result, f)
    }
    return result
}

fraction_equal :: proc(f1, f2: Fraction) -> bool {
    sf1 := fraction_simplify(f1)
    sf2 := fraction_simplify(f2)

    return sf1.num == sf2.num && sf1.den == sf2.den
}

is_digit_cancelling_fraction :: proc(num, den: int) -> bool {
    num_digit_1 := num / 10
    num_digit_2 := num % 10
    den_digit_1 := den / 10
    den_digit_2 := den % 10
    if num_digit_1 != den_digit_1 &&
       num_digit_1 != den_digit_2 &&
       num_digit_2 != den_digit_1 &&
       num_digit_2 != den_digit_2 {return false}

    cancelled_num, cancelled_den: int
    if num_digit_1 == den_digit_1 {
        cancelled_num = num_digit_2
        cancelled_den = den_digit_2
    } else if num_digit_1 == den_digit_2 {
        cancelled_num = num_digit_2
        cancelled_den = den_digit_1
    } else if num_digit_2 == den_digit_1 {
        cancelled_num = num_digit_1
        cancelled_den = den_digit_2
    } else if num_digit_2 == den_digit_2 {
        cancelled_num = num_digit_1
        cancelled_den = den_digit_1
    } else {
        unreachable()
    }

    original := Fraction{num = num, den = den}
    cancelled := Fraction{num = cancelled_num, den = cancelled_den}
    return fraction_equal(original, cancelled)
}

is_trivial :: proc(num, den: int) -> bool {
    if num % 10 == 0 || den % 10 == 0 {
        return true
    }
    return false
}
