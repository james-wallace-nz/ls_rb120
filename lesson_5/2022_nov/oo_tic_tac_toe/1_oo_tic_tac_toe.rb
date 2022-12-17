# Description

# first Player Places Piece on Board Square
# second Player Places Piece on Board Square
# first Player to get three Pieces in a Line wins

# Nouns:
# - Board (3x3 grid)
# - Square
# - Player (2)
# - Piece

# Verbs:
# - Play
# - Turn
# - Place / Mark
# - Wins

# Organized:
# - Board
# - Square
# - Player
#   - mark
#   - play

# Spike:

class Board
  def initialize
    # - model 3x3 grid - squares?
    # - what data structure?
      # - array/hash of Square objects?
      # - array/hash of Strings or Integers?
  end
end

class Square
  def initialize
    # - maybe a 'status' to track square's marker?
  end
end

class Player
  def initialize
    # maybe a 'market' to track player's symbol ('X' or 'O')
  end

  def mark
  end

  # def play - removed as in TTTGame
  # end
end

# Orchestration Engine

class TTTGame
  def play
    display_welcome_message
    loop do
      display_board
      first_player_moves
      break if someone_won? || board_full?

      second_player_moves
      break if someone_won? || board_full?
    end
    display_board
    display_goodbye_message
  end
end

game = TTTGame.new
game.play
