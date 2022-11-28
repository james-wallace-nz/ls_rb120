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
  attr_accessor :move, :name

  def initialize(player_type = :human)
    # name and move?
    @player_type = player_type
    # could add guard clause to ensure only human or computer entered
    @move = nil
    set_name
  end

  def set_name
    if human?
      n = nil
      loop do
        puts "What's your name?"
        n = gets.chomp
        break unless n.empty?
        puts "Sorry, must enter a value."
      end
      self.name = n
    else
      self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
    end
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

# class Move
#   def initialize
#     # track choice? - move object is rock, paper, scissors?
#   end
# end

# class Rule
#   def initialize

#   end
# end

# def compare(move1, move2)

# end

# Engine to orchestrate the game:

class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Player.new
    @computer = Player.new(:computer)
  end

  def play
    display_welcome_message
    loop do
      human.choose
      computer.choose
      display_winner
      break unless play_again?
    end
    display_goodbye_message
  end

  private

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors!"
  end

  def display_winner
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."

    case human.move
    when 'rock'
      puts "It's a tie" if computer.move == 'rock'
      puts "#{human.name} won!" if computer.move == 'scissors'
      puts "#{computer.name} won!" if computer.move == 'paper'
    when 'paper'
      puts "It's a tie" if computer.move == 'paper'
      puts "#{human.name} won!" if computer.move == 'rock'
      puts "#{computer.name} won!" if computer.move == 'scissors'
    when 'scissors'
      puts "It's a tie" if computer.move == 'scissors'
      puts "#{human.name} won!" if computer.move == 'paper'
      puts "#{computer.name} won!" if computer.move == 'rock'
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if ['y', 'n'].include?(answer)
      puts "Sorry, invalid entry"
    end
    answer == 'y'
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors. Goodbye!"
  end
end

RPSGame.new.play
