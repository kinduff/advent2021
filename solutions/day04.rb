# frozen_string_literal: true

require_relative '../lib/utils'

input = IO.readlines('day04.txt', chomp: true).map { |n| n.split(' ') }.reject(&:empty?).flatten

test_input = %w[
7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

22 13 17 11  0
 8  2 23  4 24
21  9 14 16  7
 6 10  3 18  5
 1 12 20 15 19

 3 15  0  2 22
 9 18 13 17  5
19  8  7 25 23
20 11 10 24  4
14 21 16 12  6

14 21 17 24  4
10 16 15  9 19
18  8 23 26 20
22 11 13  6  5
 2  0 12  3  7
]

# --- Shared ---

def process_input(input)
  input = input.dup
  bingo_input = input.shift.split(',')
  bingo_boards = input.each_slice(25).map do |board|
    board.each_slice(5).to_a
  end

  [bingo_input, bingo_boards]
end

def check_for_bingo(board)
  board.each_with_index do |row, i|
    return true if row.uniq.length == 1
  end

  board.transpose.each_with_index do |col, i|
    return true if col.uniq.length == 1
  end

  false
end

# --- Part One ---

def solve_1(input)
  process_boards = -> (bingo_input, bingo_boards) do
    bingo_input.each do |number|
      bingo_boards.each do |board|
        board.each do |row|
          row.each do |cell|
            row[row.index(cell)] = 'X' if cell == number
          end
        end

        return [number, board] if check_for_bingo(board)
      end
    end
  end


  bingo_input, bingo_boards = process_input(input)
  number, board = process_boards.call(bingo_input, bingo_boards)

  board.flatten.reject { |cell| cell == 'X' }.map(&:to_i).inject(:+) * number.to_i
end

assert_equal solve_1(test_input), 4512
psol '1', solve_1(input)

# --- Part Two ---

def solve_2(input)
  process_boards = -> (bingo_input, bingo_boards) do
    winning_numbers = []
    winning_boards_index = []
    bingo_input.each do |number|
      bingo_boards.each_with_index do |board, i|
        board.each do |row|
          row.each do |cell|
            if cell == number && !winning_boards_index.include?(i)
              row[row.index(cell)] = 'X'
            end
          end
        end

        if check_for_bingo(board) && !winning_boards_index.include?(i)
          winning_numbers << number
          winning_boards_index << i
        end
      end
    end

    return [winning_numbers.last, winning_boards_index.last]
  end

  bingo_input, bingo_boards = process_input(input)
  winning_number, winning_board_index = process_boards.call(bingo_input, bingo_boards)
  board = bingo_boards[winning_board_index]

  board.flatten.reject { |cell| cell == 'X' }.map(&:to_i).inject(:+) * winning_number.to_i
end

assert_equal solve_2(test_input), 1924
psol '2', solve_2(input)
