# Tic Tac Toe is a 2-player board game played on a 3x3 grid. Players take turns
# marking a square. The first player to mark 3 squares in a row wins.

# Nouns:
# player
# board
# square

# Verbs:
# turns
# mark
# win

# Orangised:
# board
# square
# player
# - play
# - mark

class Board
  def initialize
    # nested array of Square objects?
  end
end

class Square
  def initialize
    # status of Square object's mark
  end
end

class Player
  def initialize
    # Player symbol, name?
  end

  def play

  end

  def mark

  end
end

# Orchestration engine
class TTTGame
  def play
    display_welcome_message
    loop
      display_board
      player1.move
      break if win? or board_full?

      player2.move
      break if win? or board_full?
    end
    display_result
    display_goodbye_message
  end
end

# Start the game
game = TTTGame.new
game.play
