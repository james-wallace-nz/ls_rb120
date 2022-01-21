# nouns: player, move, rule
# verbs: choose, compare

# differentiate between human and computer player by setting some kind of state in each Player object
# - determined when we instantiate a Player object

# the :human and :computer symbol will be used internally by the Player class.
# It could be 1 and 0, string 'human' and 'computer'. Just needs to be consistent.

class Player
  attr_accessor :name, :move

  def initialize(player_type = :human)
    # generally not a good idea to have a lot of logic in the initialize method
    @player_type = player_type
    @move = nil # then need to set to one of the move strings
    set_name
  end

  def set_name
    if human?
      n = ''
      loop do
        puts "What's your name?"
        # local variable not setter. Setter needs self.name
        n = gets.chomp
        break unless n.empty?
        puts "Sorry, must be a value."
      end
      self.name = n
    else
      self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
    end
  end

  # this implementation means the `choose` method will return a string.
  # in `play` where' not saving the return value of `choose` for `human.choose`.
  # way we are calling the `choose` method shows some other state is being modified
  # `display_winner` knows how to access that modified state
  # `choose` method should modify some state in the human object
  # this implies that our Player has to keep a record of the move or choice

  # calling `choose` will modify the `move` instance variable and we're not concerned with its return value
  def choose
    if human? # return true/false depending on player_type state
      choice = nil # initialize to `nil` so it is within scope in the loop
      loop do
        puts "Please choose rock, paper, or scissors:"
        choice = gets.chomp
        break if ['rock', 'paper', 'scissors'].include? choice
        puts 'Sorry, invalid choice.'
      end
      self.move = choice
    else
      # randomly assign for computer
      self.move = ['rock', 'paper', 'scissors'].sample # call setter method to set @move to one of the three values
    end
  end

  def human?
    @player_type == :human
    # Will work if anything other than :human is passed into Player.new
    # can have a guard clause in initialize that you must specify exactly whether it is a human or computer
  end
end

# class Move
#   def initialize; end
# end

# class Rule
#   def initialize; end
# end

# def compare(move_one, move_two); end

class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Player.new
    @computer = Player.new(:computer)
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

  # procedural / imperative code
  def play
    display_welcome_message

    loop do
      # ask user for some input
      human.choose # choice saved into a state / instance variable in the object
      # computer randomly choose from array of options
      computer.choose
      display_winner
      break unless play_again?
    end
    display_goodbye_message
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors!"
  end

  # we don't have to pass anything into this method
  # being an instance method in the RPSGame class it has access to the instance variables `human` and `computer`
  # these instance variables have access to the move that the Player made
   # we can access that move by calling the getter method on the player object
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
