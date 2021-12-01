# frozen_string_literal: true

require './utils'

input = IO.readlines('1.txt', chomp: true).map(&:to_i)

test_input = []

# --- Part One ---

def solve_1(input)
end

assert_equal solve_1(test_input), 7
psol '1', solve_1(input)

# --- Part Two ---

def solve_2(input)
end

assert_equal solve_2(test_input), 5
psol '2', solve_2(input)
