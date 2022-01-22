class Move
  # only possible values will be captured in this constant
  VALUES = ['rock', 'paper', 'scissors']
  #  we want to pass in a choice when we initialize a move object
  def initialize(value)
    # We could add a guard clause to throw an error if value passed into initialize method does not match any of the VALUES
    # then can't instantiate a move object that is not R, P or S
    @value = value
  end

  def scissors?
    @value == 'scissors'
  end

  def paper?
    @value == 'paper'
  end

  def rock?
    @value == 'rock'
  end

  def >(other_move)
    # error here. case statement is expecting a comparison of @value with rock?
    # @value is a string and rock, etc. are boolean
    # so we can get rid of the case statement
    # case @value
    if rock? # instance method so don't need self (already in instance) although can have
      # comparing myself with other move object passed in
      # as writing comparison, thinking about the interface we would like
      # using instance methods here help ensure we can't make a typo - will complain this method not found
      return true if other_move.scissors?
      return false
    elsif paper?
      return true if other_move.rock?
      return false
    elsif scissors?
      return true if other_move.paper?
      return false
    end
  end

  def <(other_move)
    # case @value
    if rock?
      return true if other_move.paper?
      return false
    elsif paper?
      return true if other_move.scissors?
      return false
    elsif scissors?
      return true if other_move.rock?
      return false
    end
  end

  def to_s
    @value
  end
end

class Player
  attr_accessor :name, :move

  def initialize
    set_name
  end
end

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
      choice = gets.chomp.downcase
      break if Move::VALUES.include? choice
      puts 'Sorry, invalid choice.'
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose
    # can't set move to a string. Move has to point to an actual move object
    self.move = Move.new(Move::VALUES.sample)
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
    # calling human.move returns an object now not a string
    # can call to_s on it although string interpolation automatically calls to_s on it
    # could write a getter method for the 'value` but
    # easier to just write a to_s method on the move class and expose the value that way
    puts "#{human.name} choose #{human.move}."
    puts "#{computer.name} choose #{computer.move}."

    # in a case statement because the move instance variable in human and computer are strings 'rock', etc.
    # no way to compare strings and know which is greater

    # if we wrote it like this:
    # if human > computer
    #   puts "Human won!"
    # elsif human < computer
    #   puts "Computer won!"
    # else
    #   puts "It's a tie!"
    # end

    # It would mean just moving the case statement to the Human or Computer class - just moving same code around
    # trying to move away from the nested if clause withn a case clause

    # Would like to write it this way:
      # undefined method > for Move object. This is Ruby syntax for > instance method (a method call) human.move.>(computer.move)
      # can write a > method in Move class and pass in another object. That method returns true or false
    if human.move > computer.move
      puts "#{human.name} won!"
    elsif human.move < computer.move
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
    end
    # the `move` instance variable itself is a custom object / an object of a custom class rather than a string
    # we can then tell that custom object how to compare against itself returning a true or false value

    # we need another class called Move
    # a `move` object will be a collaborator for Human or Computer objects
    # insteading of setting `move` to a string it must be a `move` object
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors. Good Bye!"
  end
end

RPSGame.new.play

# Compare this design with the one in the previous assignment:

# what is the primary improvement of this new design?

  # The game logic for deciding the winner has been abstracted into the Move class. It is not only cleaner and easier to understand, but it also reduces the chance of error. Strings for each move are still being compared but an error will be thrown if an incorrect string is entered by the human player.

# what is the primary drawback of this new design?

  # There is now another class with multiple instance methods. These could be refactored somewhat too.
