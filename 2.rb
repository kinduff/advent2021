# frozen_string_literal: true

require './utils'

input = IO.readlines('2.txt', chomp: true)

test_input = [
  "forward 5",
  "down 5",
  "forward 8",
  "up 3",
  "down 8",
  "forward 2",
]

# --- Part One ---

def solve_1(input)
  x, y = 0, 0
  input.each do |line|
    direction, distance = line.split
    case direction
    when 'up'
      y -= distance.to_i
    when 'down'
      y += distance.to_i
    when 'forward'
      x += distance.to_i
    end
  end
  x * y
end

assert_equal solve_1(test_input), 150
psol '1', solve_1(input)

# --- Part Two ---

def solve_2(input)
  x, y, z = 0, 0, 0
  input.each do |line|
    direction, distance = line.split
    case direction
    when 'up'
      z -= distance.to_i
    when 'down'
      z += distance.to_i
    when 'forward'
      x += distance.to_i
      y += z * distance.to_i
    end
  end
  x * y
end

assert_equal solve_2(test_input), 900
psol '2', solve_2(input)
