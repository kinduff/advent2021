# frozen_string_literal: true

require_relative '../lib/utils'

input = File.open('day06.txt', &:readline).split(',').map(&:to_i)

test_input = [3, 4, 3, 1, 2]

# --- Part One ---

def solve_1(input, days)
  input = input.dup

  step = -> (input) do
    input.dup.each_with_index do |n, i|
      if n == 0
        input[i] = 6
        input.push(8)
      else
        input[i] -= 1
      end
    end
  end

  days.times { |i| step.call(input) }
  input.count
end

assert_equal solve_1(test_input, 18), 26
assert_equal solve_1(test_input, 80), 5934
psol '1', solve_1(input, 80)

# --- Part Two ---

def solve_2(input, days)
  dic = Hash.new(0).tap { |h| input.each { |i| h[i] += 1 } }

  days.times do |day|
    tdic = Hash.new(0)

    tdic[0] = 0
    tdic[6] = dic[0]
    tdic[8] = dic[0]

    (0..7).each do |i|
      tdic[i] += dic[i + 1]
    end

    dic = tdic
  end

  dic.values.inject(:+)
end

assert_equal solve_2(test_input, 256), 26984457539
psol '2', solve_2(input, 256)
