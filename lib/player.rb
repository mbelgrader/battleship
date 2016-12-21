class HumanPlayer

  SHIP_TYPES = { :battleship => 4, :submarine => 3}
  attr_reader :name
  attr_accessor :board, :unused_ships

  def initialize(name, board = Board.new)
    @name = name
    @board = board
    @unused_ships = SHIP_TYPES.keys
  end

  def setup
    until unused_ships.empty?
      ship = get_ship
      coords = get_coords

      ship_size = SHIP_TYPES[ship]
      board.place_ship(coords, ship_size)
      remove_ship(ship)
    end
  end

  def get_ship
    puts "\nShip name:"
    gets.chomp.to_sym
  end

  def get_coords
    puts "\nEnter placement:"
    gets.chomp.split(",").map(&:to_i)
  end

  def remove_ship(ship)
    @unused_ships.delete(ship)
  end

  def get_play
    gets.chomp.split(",").map(&:to_i)
  end

end
