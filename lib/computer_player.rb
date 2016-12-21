class ComputerPlayer

  SHIP_SIZES = [3, 4]
  attr_reader :name
  attr_accessor :board, :guesses, :ship_spots

  def initialize(name, board = Board.new)
    @name = name
    @board = board
    @guesses = []
    @ship_spots = []
  end

  def setup
    SHIP_SIZES.each do |size|
      ship_size = size
      coords = get_coords

      until !ship_spots.include?(coords) && in_range?(coords, size)
        coords = get_coords
      end

      board.place_ship(coords, ship_size)

      # Add all ship coords to @ship_spots
      row, col = coords
      ship_size.times do
        @ship_spots << [row, col]
        col += 1
      end
    end
  end

  def get_play
    coords = get_coords
    until !guesses.include?(coords)
      coords = get_coords
    end

    @guesses << coords
    coords
  end

  def get_coords
    [rand(board.grid.size), rand(board.grid.size)]
  end

  def in_range?(coords, size)
    row, col = coords
    col += (size - 1)
    col < board.grid.size
  end

end
