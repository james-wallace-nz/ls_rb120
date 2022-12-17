require 'pry'
require 'pry-byebug'

# Spike:

class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columns
                  [[1, 5, 9], [3, 5, 7]]              # diagonals

  def initialize
    @squares = {}
    reset
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
  def draw
    puts '     |     |'
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts '     |     |'
    puts '-----+-----+-----'
    puts '     |     |'
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts '     |     |'
    puts '-----+-----+-----'
    puts '     |     |'
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts '     |     |'
  end
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

  def [](key)
    @squares[key]
  end

  def []=(key, marker)
    @squares[key].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def joiner(array, delimiter=', ', last_join='or')
    case array.size
    when 0 then ''
    when 1 then array.first.to_s
    when 2 then array.join(" #{last_join} ")
    else
      array[-1] = "#{last_join} #{array[-1]}"
      array.join(delimiter)
    end
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      return squares.first.marker if three_identical_markers?(squares)
    end
    nil
  end

  def find_third_empty_square(marker)
    WINNING_LINES.each do |line|
      line_markers = @squares.values_at(*line).map(&:marker)
      if line_markers.count(marker) == 2 &&
         line_markers.count(Square::INITIAL_MARKER) == 1
        empty_index = line_markers.index(Square::INITIAL_MARKER)
        return line[empty_index]
      end
    end
    nil
  end

  private

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).map(&:marker)
    return false if markers.size != 3
    markers.min == markers.max
  end
end

class Square
  INITIAL_MARKER = ' '.freeze

  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def marked?
    !unmarked?
  end
end

class Player
  attr_reader :marker, :score

  def initialize(marker)
    @marker = marker
    @score = 0
  end

  def increment_score
    @score += 1
  end

  def >(other_player)
    score > other_player.score
  end

  def <(other_player)
    score < other_player.score
  end
end

class Human < Player
  def initialize
    super(set_marker)
  end

  def set_marker
    char = nil
    loop do
      puts "Enter one character as your marker (not 'O')"
      char = gets.chomp
      break if char.size == 1 && char != 'O'

      puts "Sorry, enter just one character and not 'O'"
    end
    char
  end
end

# Orchestration Engine

class TTTGame
  # human.marker = 'X'.freeze
  COMPUTER_MARKER = 'O'.freeze
  # FIRST_TO_MOVE = human.marker
  MAX_SCORE = 2

  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Human.new
    @computer = Player.new(COMPUTER_MARKER)
    @current_marker = human.marker
  end

  # orchestration method should only contain other method invocations
  def play
    clear
    display_welcome_message
    main_game
    display_game_winner
    display_goodbye_message
  end

  private

  def clear
    system 'clear'
  end

  def display_welcome_message
    puts 'Welcome to Tic Tac Toe'
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def display_board
    puts "You're a #{human.marker}. Computer is a #{computer.marker}."
    puts ''
    board.draw
    puts ''
  end

  def main_game
    loop do
      display_board
      player_move
      display_result
      break if max_score_reached?
      break unless play_again?

      reset
      display_play_again_message
    end
  end

  def player_move
    loop do
      current_player_moves
      break if board.someone_won? || board.full?

      clear_screen_and_display_board if human_turn?
    end
  end

  def current_player_moves
    if human_turn?
      human_moves
      @current_marker = COMPUTER_MARKER
    else
      computer_moves
      @current_marker = human.marker
    end
  end

  def human_turn?
    @current_marker == human.marker
  end

  def human_moves
    puts "Choose a square (#{board.joiner(board.unmarked_keys)}): "
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)

      puts "Sorry, that's not a valid choice."
    end

    board[square] = human.marker
  end

  def computer_moves
    move = nil

    move = board.find_third_empty_square(COMPUTER_MARKER)

    unless move
      move = board.find_third_empty_square(human.marker)
    end

    move ||= 5 if board[5].unmarked?
    move ||= board.unmarked_keys.sample

    board[move] = computer.marker
  end

  def max_score_reached?
    human.score == MAX_SCORE || computer.score == MAX_SCORE
  end

  def display_result
    clear_screen_and_display_board
    case board.winning_marker
    when human.marker
      human.increment_score
      puts 'You won!'
    when COMPUTER_MARKER
      computer.increment_score
      puts 'Computer won!'
    else
      human.increment_score
      computer.increment_score
      puts "It's a tie!"
    end
    display_scores
  end

  def display_scores
    puts "You have a score of #{human.score}."
    puts "Computer has a score of #{computer.score}."
  end

  def display_game_winner
    puts ''
    if human.score > computer.score
      puts 'You win the game'
    elsif human.score < computer.score
      puts 'Computer wins the game'
    else
      puts 'Game is tied'
    end
  end

  def play_again?
    choice = nil
    loop do
      puts 'Would you like to play again? (y/n)'
      choice = gets.chomp.downcase
      break if %w(y n).include? choice

      puts 'Sorry, must be y or n'
    end

    choice == 'y'
  end

  def reset
    @current_marker = human.marker
    board.reset
    clear
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ''
  end

  def display_goodbye_message
    puts 'Thanks for playing Tic Tac Toe! Goodbye!'
  end
end

game = TTTGame.new
game.play
