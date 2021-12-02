# frozen_string_literal: true

require_relative '../lib/utils'

input = IO.readlines('day01.txt', chomp: true).map(&:to_i)

test_input = [199, 200, 208, 210, 200, 207, 240, 269, 260, 263]

# --- Part One ---

def solve_1(input)
  sum = 0
  input.each_with_index do |m, i|
    sum += 1 if m > input[i - 1]
  end
  sum
end

assert_equal solve_1(test_input), 7
psol '1', solve_1(input)

# --- Part Two ---

def solve_2(input)
  sum = 0
  input.each_with_index do |m, i|
    next if input[i + 3] == nil
    window_a = [m, input[i + 1], input[i + 2]].inject(:+)
    window_b = [input[i + 1], input[i + 2], input[i + 3]].inject(:+)
    sum += 1 if window_b > window_a
  end
  sum
end

assert_equal solve_2(test_input), 5
psol '2', solve_2(input)
