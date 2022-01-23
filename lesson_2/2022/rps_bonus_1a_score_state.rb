# Keeping score - STATE

# Right now, the game doesn't have very much dramatic flair.
# It'll be more interesting if we were playing up to, say, 10 points. Whoever reaches 10 points first wins.
# Can you build this functionality? We have a new noun -- a score.
# Is that a new class, or a **state** of an existing class?
# You can explore both options and see which one works better.

class Move
  VALUES = ['rock', 'paper', 'scissors']
  def initialize(value)
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
    (rock? && other_move.scissors?) ||
      (paper? && other_move.rock?) ||
      (scissors? && other_move.paper?)
  end

  def <(other_move)
    (rock? && other_move.paper?) ||
      (paper? && other_move.scissors?) ||
      (scissors? && other_move.rock?)
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
    puts "Welcome to Rock, Paper, Scissors!"
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
    puts "Thanks for playing Rock, Paper, Scissors. Good Bye!"
  end
end

RPSGame.new.play
