# Keep track of a history of moves

# As long as the user doesn't quit, keep track of a history of moves by both the human and computer.
# What data structure will you reach for?
# Will you use a new class, or an existing class?
# What will the display output look like?

# History is a state that a player has, so it is a nwe array instance variable for a player

class Move
  attr_reader :value

  VALUES = ['rock', 'paper', 'scissors', 'lizard', 'spock']
  def initialize(value)
    @value = value
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

  def scissors?
    @value == 'scissors'
  end

  def lizard?
    @value == 'lizard'
  end

  def spock?
    @value == 'spock'
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
    @value
  end
end

class Player
  attr_accessor :name, :move, :score, :history

  def initialize
    @score = 0
    set_name
    @history = []
  end

  def choose(choice)
    self.move = Move.new(choice)
    history << choice
  end

  def display_move
    puts "#{name} choose #{move}."
    puts "#{name} history: #{history}"
  end

  def display_score
    puts "#{name} has a score of #{score}."
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
      choice = gets.chomp.downcase
      break if Move::VALUES.include? choice
      puts 'Sorry, invalid choice.'
    end
    super(choice)
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose
    choice = Move::VALUES.sample
    super(choice)
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
    human.display_move
    computer.display_move
  end

  def reset_scores
    human.score = 0
    computer.score = 0
  end

  def display_scores
    human.display_score
    computer.display_score
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
