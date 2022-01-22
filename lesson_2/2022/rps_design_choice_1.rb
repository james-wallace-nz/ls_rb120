# all Player class responsible for now is setting up the getters and setters for move and name and then calling set_name
class Player
  attr_accessor :name, :move

  def initialize
    # don't need below as will be initialized to nil by default anyway
    # @move = nil
    set_name
  end
end

# the refactoring pushes all the logic down to the sub-classes
# when we instantiate Player objects we're actually intantiating specific instances of sub-classes

# still has access to the getter name and move methods from the Player class
class Human < Player
  def set_name
    n = ''
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, must be a value."
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, or scissors:"
      choice = gets.chomp
      break if ['rock', 'paper', 'scissors'].include? choice
      puts 'Sorry, invalid choice.'
    end
    self.move = choice
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose
    self.move = ['rock', 'paper', 'scissors'].sample
  end
end

class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp!.downcase
      break if ['y', 'n'].include? answer
      puts "Sorry, must be 'y' or 'n'."
    end
    answer == 'y'
  end

  def play
    display_welcome_message

    loop do
      # actually calling Human class and Computer class choose instance methods
      human.choose
      computer.choose
      display_winner
      break unless play_again?
    end
    display_goodbye_message
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors!"
  end

  def display_winner
    puts "#{human.name} choose #{human.move}."
    puts "#{computer.name} choose #{computer.move}."

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

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors. Good Bye!"
  end
end

RPSGame.new.play


# Compare this design with the one in the previous assignment:

# is this design, with Human and Computer sub-classes, better? Why, or why not?

  # This design is better. Human and Computer are logical sub-classes of the Player class. While both players with the same states, they will have different behaviours. A human will manually choose a name and move while a computer has the name and move selected randomly. Creating logic for both Human and Computer in the Player class creates too much complexity in those instance methods. Each time the player_type must be checked to determine the approriate action.


# what is the primary improvement of this new design?

  # This design abstracts Human and Computer logic into sub-classes of Player. It makes Human and Computer more logical and easier to understand compared to combining the logic in the Player class.

# what is the primary drawback of this new design?

  # It would take more work to change the Computer to a Human player as we cannot just change the way the second Player object is intantiated (by having no player_type passed in). Therefore, we would have to rename computer local variable everywhere and instantiate a Human object rather than computer object.
