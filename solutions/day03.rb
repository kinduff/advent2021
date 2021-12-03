# frozen_string_literal: true

require_relative '../lib/utils'

input = IO.readlines('day03.txt', chomp: true)

test_input = %w(00100 11110 10110 10111 10101 01111 00111 11100 10000 11001 00010 01010)

# --- Part One ---

def solve_1(input)
  gama = []
  epsilon = []
  input.first.size.times do |i|
    column = input.map { |line| line[i] }
    values = { 0 => column.count('0'), 1 => column.count('1') }.sort_by { |_k, v| v }
    epsilon << values[0][0]
    gama << values[1][0]
  end

  gama_rate = gama.join('').to_i(2)
  epsilon_rate = epsilon.join('').to_i(2)

  [gama_rate, epsilon_rate].inject(:*)
end

assert_equal solve_1(test_input), 198
psol '1', solve_1(input)

# --- Part Two ---

def solve_2(input)
  calculate = -> (input, i, inv = false) do
    column = input.map { |line| line[i] }
    values = { 0 => column.count('0'), 1 => column.count('1') }.sort_by { |_k, v| v }

    values.reverse! if inv

    result = input.select { |line| line[i] == values[1][0].to_s }
    return result.first if result.size == 1

    calculate.call(result, i + 1, inv)
  end

  oxygen = calculate.call(input, 0).to_i(2)
  co2 = calculate.call(input, 0, true).to_i(2)

  [oxygen, co2].inject(:*)
end

assert_equal solve_2(test_input), 230
psol '2', solve_2(input)
