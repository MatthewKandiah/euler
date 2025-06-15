package p19

import "../util"
import "core:fmt"

main :: proc() {
  date := init()
  count := 0
  for date.year < 2001 {
    if (is_twentieth_century(date.year) && date.day_of_the_week == .Sun && date.day == 1) {
      count += 1
    }
    date = next_day(date)
  }
  util.answer(count)
}

Date :: struct {
  day:             uint,
  month:           uint,
  year:            uint,
  day_of_the_week: DayOfTheWeek,
}

DayOfTheWeek :: enum {
  Mon,
  Tue,
  Wed,
  Thu,
  Fri,
  Sat,
  Sun,
}

init :: proc() -> Date {
  return {day = 1, month = 1, year = 1900, day_of_the_week = .Mon}
}

is_twentieth_century :: proc(year: uint) -> bool {
  return year >= 1901 && year <= 2000
}

next_day :: proc(using date: Date) -> Date {
  next_day_of_the_week := get_next_day_of_the_week(day_of_the_week)
  next_day, next_month, next_year := get_next_day_month_year(day, month, year)
  return {day = next_day, month = next_month, year = next_year, day_of_the_week = next_day_of_the_week}
}

get_next_day_month_year :: proc(day, month, year: uint) -> (next_day, next_month, next_year: uint) {
  next_day = day + 1
  next_month = month
  next_year = year
  is_leap_year := year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)
  if month_overflows(next_day, month, is_leap_year) {
    next_day = 1
    next_month += 1
  }
  if year_overflows(next_month) {
    next_month = 1
    next_year += 1
  }
  return
}

year_overflows :: proc(month: uint) -> bool {
  return month > 12
}

month_overflows :: proc(day, month: uint, is_leap_year: bool) -> bool {
  switch month {
  case 2:
    return day > (29 if is_leap_year else 28)
  case 9, 4, 6, 11:
    // Sep, Apr, Jun, Nov
    return day > 30
  case 1, 3, 5, 7, 8, 10, 12:
    return day > 31
  }
  unreachable()
}

get_next_day_of_the_week :: proc(day: DayOfTheWeek) -> DayOfTheWeek {
  switch day {
  case .Mon:
    return .Tue
  case .Tue:
    return .Wed
  case .Wed:
    return .Thu
  case .Thu:
    return .Fri
  case .Fri:
    return .Sat
  case .Sat:
    return .Sun
  case .Sun:
    return .Mon
  }
  unreachable()
}
