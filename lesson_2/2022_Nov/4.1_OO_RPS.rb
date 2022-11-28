# RPS is a two player game where the player chooses rock, paper or scissors then the computer chooses rock, paper or scissors. We compare the two choices and determine the winner based on:
# - rock beats scissors
# - scissors beats paper
# - paper beats rock
# Choosing the sam move is a tie

# Nouns:
  # player
  # computer
  # move (rock, paper, scissors are variations/states of move)
  # rule

# Verbs:
  # choose
  # compare

# Player
#   - choose
# Move
# Rule

# - compare

class Player
  def initialize
    # name and move?
  end

  def choose

  end
end

class Move
  def initialize
    # track choice? - move object is rock, paper, scissors?
  end
end

class Rule
  def initialize

  end
end

def compare(move1, move2)

end

# Engine to orchestrate the game:

class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Player.new
    @computer = Player.new
  end

  def play
    display_welcome_message
    # human_choose_move
    # computer_choose_move
    human.choose
    computer.choose
    display_winner
    display_goodbye_message
  end
end

RPSGame.new.play
