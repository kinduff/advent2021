# frozen_string_literal: true

require_relative '../lib/utils'

input = IO.readlines('day08.txt', chomp: true)

test_input = [
  'be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe',
  'edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc',
  'fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg',
  'fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb',
  'aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea',
  'fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb',
  'dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe',
  'bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef',
  'egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb',
  'gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce'
]

# --- Part One ---

def solve_1(input)
  appearances = Hash.new(0)
  input.each do |line|
    output = line.split(' | ').last
    output.split(' ').each do |word|
      next unless [2, 3, 4, 7].include?(word.size)
      appearances[word.size] += 1
    end
  end
  appearances.values.inject(:+)
end

assert_equal solve_1(test_input), 26
psol '1', solve_1(input)

# --- Part Two ---

def solve_2(input)
end

assert_equal solve_2(test_input), 61229
psol '2', solve_2(input)
