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

  def draw
    puts '     |     |'
    puts "  #{get_square_at(1)}  |  #{get_square_at(2)}  |  #{get_square_at(3)}"
    puts '     |     |'
    puts '-----+-----+-----'
    puts '     |     |'
    puts "  #{get_square_at(4)}  |  #{get_square_at(5)}  |  #{get_square_at(6)}"
    puts '     |     |'
    puts '-----+-----+-----'
    puts '     |     |'
    puts "  #{get_square_at(7)}  |  #{get_square_at(8)}  |  #{get_square_at(9)}"
    puts '     |     |'
  end

  def get_square_at(key)
    @squares.fetch(key)
  end

  def set_square_at(key, marker)
    @squares[key].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def winning_marker
    WINNING_LINES.each do |line|
      if count_human_marker(@squares.values_at(*line)) == 3
        return TTTGame::HUMAN_MARKER
      elsif count_computer_marker(@squares.values_at(*line)) == 3
        return TTTGame::COMPUTER_MARKER
      end
    end
    nil
  end

  def count_human_marker(squares)
    squares.map(&:marker).count(TTTGame::HUMAN_MARKER)
  end

  def count_computer_marker(squares)
    squares.map(&:marker).count(TTTGame::COMPUTER_MARKER)
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
end

class Player
  attr_reader :marker

  def initialize(marker)
    @marker = marker
  end
end

# Orchestration Engine

class TTTGame
  HUMAN_MARKER = 'X'.freeze
  COMPUTER_MARKER = 'O'.freeze

  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
  end

  def play
    clear
    display_welcome_message

    loop do
      display_board

      loop do
        human_moves
        break if board.someone_won? || board.full?

        computer_moves
        break if board.someone_won? || board.full?

        clear_screen_and_display_board
      end
      display_result
      break unless play_again?

      reset
      display_play_again_message
    end
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

  def human_moves
    puts "Choose a square (#{board.unmarked_keys.join(', ')}): "
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)

      puts "Sorry, that's not a valid choice."
    end

    board.set_square_at(square, human.marker)
  end

  def computer_moves
    board.set_square_at(board.unmarked_keys.sample, computer.marker)
  end

  def display_result
    clear_screen_and_display_board
    case board.winning_marker
    when HUMAN_MARKER
      puts 'You won!'
    when COMPUTER_MARKER
      puts 'Computer won!'
    else
      puts "It's a tie!"
    end
  end

  def play_again?
    choice = nil
    loop do
      puts 'Would you like to play again? (y/n)'
      choice = gets.chomp.downcase
      break if %w[y n].include? choice

      puts 'Sorry, must be y or n'
    end

    choice == 'y'
  end

  def reset
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
