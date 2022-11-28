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
  attr_accessor :move

  def initialize(player_type = :human)
    # name and move?
    @player_type = player_type
    # could add guard clause to ensure only human or computer entered
    @move = nil
  end

  def choose
    if human?
      choice = nil
      loop do
        puts "Please choose rock, paper, or scissors:"
        choice = gets.chomp
        break if ['rock', 'paper', 'scissors'].include? choice
        puts "Sorry, invalid choice."
      end
      self.move = choice
    else
      self.move = ['rock', 'paper', 'scissors'].sample
    end
  end

  private

  def human?
    @player_type == :human
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
    @computer = Player.new(:computer)
  end

  def play
    display_welcome_message
    human.choose
    computer.choose
    display_winner
    display_goodbye_message
  end

  private

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors. Goodbye!"
  end
end

RPSGame.new.play
