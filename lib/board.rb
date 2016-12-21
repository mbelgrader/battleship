require 'byebug'

class Board
  SHIPS = 2
  DISPLAY_MARKS = {:s => " ", nil => " ", :x => 'x' }

  attr_reader :grid

  def self.default_grid
    Array.new(4) { Array.new(4) }
  end

  def initialize(grid = Board.default_grid)
    @grid = grid
  end

  def [](pos)
    row, col = pos
    grid[row][col]
  end

  def []=(pos, mark)
    row, col = pos
    grid[row][col] = mark
  end

  def display
    # system('clear')
    header
    grid.each_with_index do |row, i|
      marks = row.map { |m| DISPLAY_MARKS[m] }.join('  ')
      puts "#{i} #{marks}"
    end
  end

  def header
    puts "  " + (0...grid.size).to_a.join('  ')
  end

  def count
    grid.flatten.count(:s)
  end

  def place_ship(coords, ship_size)
    row, col = coords
    ship_size.times do
      @grid[row][col] = :s
      col += 1
    end
  end

  # Place random ships ------------------
  def populate_grid
    SHIPS.times do
      place_random_ship
    end
  end

  def place_random_ship
    raise if self.full?

    # refactor
    until count == SHIPS
      row, col = random, random
      @grid[row][col] = :s if @grid[row][col] == nil
    end
  end

  # refactor to re-use for comp player class
  def random
    (0...grid.length).to_a.sample
  end
  #-------------------------------------

  # def in_range?(pos)
  # end

  def empty?(pos = nil)
    x, y = pos
    return false if pos == nil && count > 0
    return true if pos == nil && count == 0
    grid[x][y] == nil
  end

  def full?
    grid.flatten.size == count
  end

  def won?
    self.empty?
  end

end
