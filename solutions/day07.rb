# frozen_string_literal: true

require_relative '../lib/utils'

input = IO.readlines('day07.txt', chomp: true).first.split(',').map(&:to_i)

test_input = [16, 1, 2, 0, 4, 2, 7, 1, 2, 14]

# --- Part One ---

def solve_1(input)
  min, max = input.min, input.max
  (min..max).map do |i|
    input.map { |n| (n - i).abs }.inject(:+)
  end.min
end

assert_equal solve_1(test_input), 37
psol '1', solve_1(input)

# --- Part Two ---

def solve_2(input)
  min, max = input.min, input.max
  (min..max).map do |i|
    input.map do |n|
      m = (n - i).abs
      m * (m + 1) / 2
    end.inject(:+)
  end.min
end

assert_equal solve_2(test_input), 168
psol '2', solve_2(input)
