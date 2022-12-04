class Player
  attr_accessor :move, :name

  def initialize
    set_name
  end
end

class Human < Player
  def set_name
    n = nil
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, must enter a value."
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, or scissors:"
      choice = gets.chomp
      break if Move::VALUES.include? choice
      puts "Sorry, invalid choice."
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose
    # Move needs to point to an actual move object
    self.move = Move.new(Move::VALUES.sample)
  end
end

class Move
  VALUES = ['rock', 'paper', 'scissors']

  def initialize(value)
    @value = value          # can throw in a guard clause if `value` passed in doesn't match value in VALUES.
                            # can't instantiate a move object that isn't R, P, or S.
  end

  # Using these method is helpful as Ruby will complain if methods not found - avoids typos
  def rock?
    @value == 'rock'
  end

  def scissors?
    @value == 'scissors'
  end

  def paper?
    @value == 'paper'
  end

  def >(other_move)
    if rock?
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
    if rock?
      return true if other_move.paper?
      return false
    elsif paper?
      return true if other_move.scissors?
      return false
    elsif scissor?
      return true if other_move.rock?
      return false
    end
  end

  def to_s
    @value
  end
end

class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
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

    # Want to be able to do this:
    # if human.move > computer.move
    #   puts '...'
    # elsif human.move < computer.move
    #   puts '..'
    # else
    #   puts 'Tie'
    # end

    # The only way to do this is if move is an object of a custom class not a string
    # Then we can tell the custom object how to compare against itself returning boolean

    # The `move` object will then be a collaborator for Human and Computer object.
    # Have to set move to a move object rather than a string.

    # If we did
    # if human > computer

    # That just means moving the complex case statement into the Person class

    #   case human.move
    #   when 'rock'
    #     puts "It's a tie" if computer.move == 'rock'
    #     puts "#{human.name} won!" if computer.move == 'scissors'
    #     puts "#{computer.name} won!" if computer.move == 'paper'
    #   when 'paper'
    #     puts "It's a tie" if computer.move == 'paper'
    #     puts "#{human.name} won!" if computer.move == 'rock'
    #     puts "#{computer.name} won!" if computer.move == 'scissors'
    #   when 'scissors'
    #     puts "It's a tie" if computer.move == 'scissors'
    #     puts "#{human.name} won!" if computer.move == 'paper'
    #     puts "#{computer.name} won!" if computer.move == 'rock'
    #   end

    if human.move > computer.move
      puts "#{human.name} won!"
    elsif human.move < computer.move
      puts "#{computer.name} won!"
    else
      puts "It's a Tie"
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

# What is the primary improvement of this new design?
  # We can reduce the complexity of our move comparison by incorporating that as an instance method in the Move class

# What is the primary drawback of this new design?
  # There is an additional class that we must model and maintain
