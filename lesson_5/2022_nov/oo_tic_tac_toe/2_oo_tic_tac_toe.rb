# Spike:

class Board
  INITIAL_MARKER = ' '

  def initialize
    # - model 3x3 grid - squares?
    # - what data structure?
      # - array/hash of Square objects?
      # - array/hash of Strings or Integers?
    # need to initialize board state to present a default value
    @squares = {}
    # @squares[key] = value
    (1..9).each { |key| @squares[key] = Square.new(INITIAL_MARKER) }
      # 1 => Square.new(' '),
      # 2 => Square.new(' '),
      # 3 => Square.new(' '),
      # 4 => Square.new(' '),
      # 5 => Square.new(' '),
      # 6 => Square.new(' '),
      # 7 => Square.new(' '),
      # 8 => Square.new(' '),
      # 9 => Square.new(' ')
    # }
  end

  def get_square_at(key)
    @squares.fetch(key)
  end
end

class Square
  def initialize(marker)
    # - maybe a 'status' to track square's marker?
    @marker = marker
  end

  def to_s
    @marker
  end
end

class Player
  def initialize
    # maybe a 'market' to track player's symbol ('X' or 'O')
  end

  def mark
  end
end

# Orchestration Engine

class TTTGame
  attr_reader :board

  def initialize
    @board = Board.new
  end

  def play
    display_welcome_message
    loop do
      display_board
      break

      first_player_moves
      break if someone_won? || board_full?

      second_player_moves
      break if someone_won? || board_full?
    end
    # display_result
    display_goodbye_message
  end

  private

  def display_welcome_message
    puts 'Welcome to Tic Tac Toe'
  end

  def display_board
    puts ''
    puts '     |     |'
    puts "  #{board.get_square_at(1)}  |  #{board.get_square_at(2)}  |  #{board.get_square_at(3)}"
    puts '     |     |'
    puts '-----+-----+-----'
    puts '     |     |'
    puts "  #{board.get_square_at(4)}  |  #{board.get_square_at(5)}  |  #{board.get_square_at(6)}"
    puts '     |     |'
    puts '-----+-----+-----'
    puts '     |     |'
    puts "  #{board.get_square_at(7)}  |  #{board.get_square_at(8)}  |  #{board.get_square_at(9)}"
    puts '     |     |'
    puts ''
  end

  def display_goodbye_message
    puts 'Thanks for playing Tic Tac Toe! Goodbye!'
  end
end

game = TTTGame.new
game.play
