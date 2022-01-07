# frozen_string_literal: true

require_relative '../lib/utils'

input = IO.readlines('day09.txt', chomp: true).map { |i| i.split('').map(&:to_i) }

test_input = [
  [2, 1, 9, 9, 9, 4, 3, 2, 1, 0],
  [3, 9, 8, 7, 8, 9, 4, 9, 2, 1],
  [9, 8, 5, 6, 7, 8, 9, 8, 9, 2],
  [8, 7, 6, 7, 8, 9, 6, 7, 8, 9],
  [9, 8, 9, 9, 9, 6, 5, 6, 7, 8],
]

# --- Shared ---
class Ary < Array
  # Modded from https://github.com/Invoca/ruby_dig/blob/master/lib/ruby_dig.rb
  # Allows to dig an array and avoid negative values for index
  def dig(key, *rest)
    return nil if key < 0 rescue nil
    value = self[key]
    if value.nil? || rest.empty?
      value
    elsif value.respond_to?(:dig)
      value.dig(*rest)
    end
  end
end

# --- Part One ---

def solve_1(input)
  data = Ary.new(input.map { |i| Ary.new(i) })
  row_size, col_size = input.size, input[0].size
  low_points = []

  row_size.times do |i|
    col_size.times do |j|
      n = data[i][j]
      adjacents = [
        data.dig(i - 1, j), # up
        data.dig(i + 1, j), # down
        data.dig(i, j - 1), # left
        data.dig(i, j + 1)  # right
      ].compact
      low_points << n + 1 if adjacents.reject { |a| n < a }.size == 0
    end
  end

  low_points.inject(:+)
end

assert_equal solve_1(test_input), 15
psol '1', solve_1(input)

# --- Part Two ---

def solve_2(input)
end

assert_equal solve_2(test_input), 1134
psol '2', solve_2(input)
