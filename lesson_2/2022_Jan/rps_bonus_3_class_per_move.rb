# Add a class for each move

# What would happen if we went even further and introduced 5 more classes, one for each move:
# Rock, Paper, Scissors, Lizard, and Spock.
# How would the code change? Can you make it work?
# After you're done, can you talk about whether this was a good design decision? What are the pros/cons?

# this is a poor design decision
# the moves are really just strings so abstracting each move to a class is another layer of complexity
# having a class for each move creates more code and makes it harder to understand what our code is doing
# each move class is the same except for the value of the string for that move 'rock', 'paper'

class Move
  attr_reader :value
  VALUES = ['Rock', 'Paper', 'Scissors', 'Lizard', 'Spock']
  # VALUES = [Rock::VALUE, Paper::VALUE, Scissors::VALUE, Lizard::VALUE, Spock::VALUE]

  def initialize(value)
    @value = value
  end

  def rock?
    @value.value == Rock::VALUE
  end

  def paper?
    @value.value == Paper::VALUE
  end

  def scissors?
    @value.value == Scissors::VALUE
  end

  def lizard?
    @value.value == Lizard::VALUE
  end

  def spock?
    @value.value == Spock::VALUE
  end

  def >(other_move)
    (rock? && (other_move.scissors? || other_move.lizard?)) ||
      (paper? && (other_move.rock? || other_move.spock?)) ||
      (scissors? && (other_move.paper? || other_move.lizard?)) ||
      (lizard? && (other_move.paper? || other_move.spock?)) ||
      (spock? && (other_move.scissors? || other_move.rock?))
  end

  def <(other_move)
    (rock? && (other_move.paper? || other_move.spock?)) ||
      (paper? && (other_move.scissors? || other_move.lizard?)) ||
      (scissors? && (other_move.rock? || other_move.spock?)) ||
      (lizard? && (other_move.rock? || other_move.scissors?)) ||
      (spock? && (other_move.paper? || other_move.lizard?))
  end

  def to_s
    @value.to_s
  end
end

class Rock
  attr_reader :value

  VALUE = 'Rock'

  def initialize
    @value = VALUE
  end

  def to_s
    @value
  end
end

class Paper
  attr_reader :value

  VALUE = 'Paper'

  def initialize
    @value = VALUE
  end

  def to_s
    @value
  end
end

class Scissors
  attr_reader :value

  VALUE = 'Scissors'

  def initialize
    @value = VALUE
  end

  def to_s
    @value
  end
end

class Lizard
  attr_reader :value

  VALUE = 'Lizard'

  def initialize
    @value = VALUE
  end

  def to_s
    @value
  end
end

class Spock
  attr_reader :value

  VALUE = 'Spock'

  def initialize
    @value = VALUE
  end

  def to_s
    @value
  end
end

class Player
  attr_accessor :name, :move, :score

  def initialize
    @score = 0
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
      puts
      puts "Please choose rock, paper, scissors, lizard or spock:"
      choice = gets.chomp.capitalize
      break if Move::VALUES.include? choice
      puts 'Sorry, invalid choice.'
    end

    case choice
    when Rock::VALUE
      self.move = Move.new(Rock.new)
    when Paper::VALUE
      self.move = Move.new(Paper.new)
    when Scissors::VALUE
      self.move = Move.new(Scissors.new)
    when Lizard::VALUE
      self.move = Move.new(Lizard.new)
    when Spock::VALUE
      self.move = Move.new(Spock.new)
    end
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose
    choice = Move::VALUES.sample

    case choice
    when Rock::VALUE
      self.move = Move.new(Rock.new)
    when Paper::VALUE
      self.move = Move.new(Paper.new)
    when Scissors::VALUE
      self.move = Move.new(Scissors.new)
    when Lizard::VALUE
      self.move = Move.new(Lizard.new)
    when Spock::VALUE
      self.move = Move.new(Spock.new)
    end
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

  def score_reached?
    human.score >= 10 || computer.score >= 10
  end

  # rubocop:disable Metrics/MethodLength
  def play
    puts Rock::VALUE
    # puts Move::VALUES
    display_welcome_message
    loop do
      reset_scores
      loop do
        game_logic
        break if score_reached?
      end
      display_game_winner
      break unless play_again?
    end
    display_goodbye_message
  end
  # rubocop:enable Metrics/MethodLength

  def game_logic
    human.choose
    computer.choose
    display_moves
    display_round_winner
    display_scores
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors, Lizard, Spock!"
  end

  def display_moves
    puts "#{human.name} choose #{human.move}."
    puts "#{computer.name} choose #{computer.move}."
  end

  def reset_scores
    human.score = 0
    computer.score = 0
  end

  def display_scores
    puts "#{human.name} has a score of #{human.score}."
    puts "#{computer.name} has a score of #{computer.score}."
  end

  def display_game_winner
    puts human.score >= 10 ? "#{human.name} beat #{computer.name}!" : "#{computer.name} beat #{human.name}!"
  end

  def increment_scores(score_one, score_two)
    human.score += score_one
    computer.score += score_two
  end

  def print_winner(player)
    puts "#{player.name} won that round!"
  end

  def display_round_winner
    if human.move > computer.move
      increment_scores(1, 0)
      print_winner(human)
    elsif human.move < computer.move
      increment_scores(0, 1)
      print_winner(computer)
    else
      increment_scores(1, 1)
      puts "It's a tie for this round!"
    end
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors, Lizard or Spock. Good Bye!"
  end
end

RPSGame.new.play
