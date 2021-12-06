# frozen_string_literal: true

require_relative '../lib/utils'

input = IO.readlines('day05.txt', chomp: true)

test_input = [
  '0,9 -> 5,9',
  '8,0 -> 0,8',
  '9,4 -> 3,4',
  '2,2 -> 2,1',
  '7,0 -> 7,4',
  '6,4 -> 2,0',
  '0,9 -> 2,9',
  '3,4 -> 1,4',
  '0,0 -> 8,8',
  '5,5 -> 8,2',
]

# --- Shared ---

class Integer
  def midto(other, &block)
    return self.downto(other, &block) if self > other
    self.upto(other, &block)
  end
end

class Grid
  def initialize
    @grid = []
  end

  def draw_line(x1, y1, x2, y2)
    x1.midto(x2) do |x|
      y1.midto(y2) do |y|
        @grid[y] ||= []
        if @grid[y][x].nil?
          @grid[y][x] = 1
        else
          @grid[y][x] += 1
        end
      end
    end
  end

  def draw_diagonal(x1, y1, x2, y2)
    xs = x1.midto(x2).to_a
    ys = y1.midto(y2).to_a

    xs.zip(ys).each do |x, y|
      @grid[y] ||= []
      if @grid[y][x].nil?
        @grid[y][x] = 1
      else
        @grid[y][x] += 1
      end
    end
  end

  def count
    @grid.flatten.compact.count { |x| x >= 2 }
  end
end

# --- Part One ---

def solve_1(input)
  grid = Grid.new
  input.each do |line|
    from, to = line.split(' -> ')
    x1, y1 = from.split(',').map(&:to_i)
    x2, y2 = to.split(',').map(&:to_i)

    next unless x1 == x2 || y1 == y2

    grid.draw_line(x1, y1, x2, y2)
  end

  grid.count
end

assert_equal solve_1(test_input), 5
psol '1', solve_1(input)

# --- Part Two ---

def solve_2(input)
  grid = Grid.new
  input.each do |line|
    from, to = line.split(' -> ')
    x1, y1 = from.split(',').map(&:to_i)
    x2, y2 = to.split(',').map(&:to_i)

    if x1 == x2 || y1 == y2
      grid.draw_line(x1, y1, x2, y2)
    else
      grid.draw_diagonal(x1, y1, x2, y2)
    end
  end

  grid.count
end

assert_equal solve_2(test_input), 12
psol '2', solve_2(input)
