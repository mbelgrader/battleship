require_relative "board"
require_relative "player"
require_relative "computer_player"
require 'colorize'

class BattleshipGame

  attr_reader :player1, :player2, :current_player
  attr_accessor :board

  def initialize(player1, player2)
    @player1, @player2 = player1, player2
    @board = board
    @current_player = player1
  end

  def play
    player_setup

    until game_over?
      display_status
      play_turn
      switch_players!
    end

  end

  def player_setup
    system('clear')
    puts "\nLet's setup #{player1.name}\'s board...".green
    player1.setup

    system('clear')
    puts "\nAwesome!\n".green
    puts "Now let's setup #{player2.name}\'s board...".green
    player2.setup
    puts "\nAll setup! Now let's play!\n".green
  end

  def play_turn
    puts "\n#{current_player.name}: Enter the coordinates of your target ( Ex. [0,1] )".green
    guess = current_player.get_play
    attack(guess)
  end

  def attack(pos)
    x, y = pos
    if other_player.board.grid[x][y] == :s
      other_player.board.grid[x][y] = :x
    else
      other_player.board.grid[x][y] = :x
    end
  end

  # def count
  #   self.board.count
  # end

  def display_status
    system('clear')

    puts "#{player1.name}\'s board:".green
    player1.board.display

    puts "\n\n#{player2.name}\'s board:".green
    player2.board.display

    if player1.board.count == 1
      puts "\n\n#{player1.name} has #{player1.board.count} ship remaining"
    else
      puts "\n\n#{player1.name} has #{player1.board.count} ships remaining"
    end

    if player2.board.count == 1
      puts "#{player2.name} has #{player2.board.count} ship remaining"
    else
      puts "#{player2.name} has #{player2.board.count} ships remaining"
    end
  end

  def switch_players!
    @current_player = current_player == player1 ? player2 : player1
  end

  def other_player
    current_player == player1 ? player2 : player1
  end

  def game_over?
    if player1.board.won?
      puts "\n#{player2.name} wins!"
      return true
    elsif player2.board.won?
      puts "\n#{player1.name} wins!"
      return true
    end
    false
  end

end


# if __FILE__ == $PROGRAM_NAME
#   puts "Enter your name:"
#   name = gets.chomp
#   player = HumanPlayer.new(name)
#   new_game = BattleshipGame.new(player)
#   new_game.play
# end

# 2-player

# if __FILE__ == $PROGRAM_NAME
#   puts "Player 1: Enter name:"
#   name1 = gets.chomp
#   player1 = HumanPlayer.new(name1)
#
#   puts "Player 2: Enter name:"
#   name2 = gets.chomp
#   player2 = HumanPlayer.new(name2)
#
#   new_game = BattleshipGame.new(player1, player2)
#   new_game.play
# end

# Human vs smart computer

if __FILE__ == $PROGRAM_NAME
  puts "Enter your name:"
  name = gets.chomp
  player1 = HumanPlayer.new(name)
  player2 = ComputerPlayer.new('Garry')
  new_game = BattleshipGame.new(player1, player2)
  new_game.play
end
