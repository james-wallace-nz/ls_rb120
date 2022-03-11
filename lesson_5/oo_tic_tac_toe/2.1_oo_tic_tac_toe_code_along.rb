class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +   # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +   # cols
                  [[1, 5, 9], [3, 5, 7]]                # diagonals

  def initialize
    # @squares = {
    #   1 => Square.new(' '),
    #   2 => Square.new(' '),
    #   3 => Square.new(' '),
    #   4 => Square.new(' '),
    #   5 => Square.new(' '),
    #   6 => Square.new(' '),
    #   7 => Square.new(' '),
    #   8 => Square.new(' '),
    #   9 => Square.new(' ')
    # }
    @squares = {}
    (1..9).each { |key| @squares[key] = Square.new }
    # p @squares
  end

  def get_square_at(key)
    @squares.fetch(key)
  end

  def set_square_at(key, marker)
    # retrieving the square at the key and calling the setter method marker=
    # we dont' have to create a new square object. We could or we could reassign the existing marker for that square
    @squares[key].marker = marker
  end

  # Board represents the state of the game so should be aware of which squares are empty
  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  # ask another method that will return the winning marker
  def someone_won?
    # relying on truthiness of returning an object which will evaluate to true. !! will turn to boolean true or false
    !!detect_winner
  end

  # returning winning marker or nil
  # iterate through the winning lines array, which will yield three cells at a time
  # check if the squares hash contains squares of the same marker - human or computer
  def detect_winner
    WINNING_LINES.each do |line|
      if @squares[line[0]].marker == TTTGame::HUMAN_MARKER &&
         @squares[line[1]].marker == TTTGame::HUMAN_MARKER &&
         @squares[line[2]].marker == TTTGame::HUMAN_MARKER
        return TTTGame::HUMAN_MARKER
      elsif @squares[line[0]].marker == TTTGame::COMPUTER_MARKER &&
         @squares[line[1]].marker == TTTGame::COMPUTER_MARKER &&
         @squares[line[2]].marker == TTTGame::COMPUTER_MARKER
        return TTTGame::COMPUTER_MARKER
      end
    end
    nil
  end
end

class Square
  # seems to be square related rather than board related
  INITIAL_MARKER = ' '

  attr_accessor :marker

  def initialize(marker = INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    @marker == INITIAL_MARKER
  end
end

class Player
  attr_reader :marker

  def initialize(marker)
    # Player symbol, name?

    # Player class is encapsulating the state for the particular player - the marker for the player
    @marker = marker
  end

  def play; end

  # Since marking the board using board.set_square_at we no longer need this method
  # def mark; end
end

class TTTGame
  HUMAN_MARKER = 'X'
  COMPUTER_MARKER = 'O'

  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
  end

  def display_welcome_message
    puts 'Welcome to Tic Tac Toe!/n'
  end

  def display_goodbye_message
    puts 'Thanks for playing Tic Tac Toe! Goodbye!'
  end

  def display_board
    system 'clear'
    puts "You're a #{human.marker}. Computer is a #{computer.marker}."
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

  def human_moves
    puts "Choose a square (#{board.unmarked_keys.join(', ')})"
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)

      puts "Sorry, that's not a valid option."
    end

    # Two valid choices for setting square
    # The state of the human marker should be in the human object
    board.set_square_at(square, human.marker)
    # @human.mark(square)
  end

  def computer_moves
    board.set_square_at(board.unmarked_keys.sample, computer.marker)
  end

  def display_result
    display_board
    case board.detect_winner
    when human.marker
      puts 'You won!'
    when computer.marker
      puts 'Computer won!'
    else
      puts "It's a tie!"
    end
  end

  def play
    display_welcome_message
    display_board

    loop do
      human_moves
      # Board can determine if someone has won. Board knows who won, just care someone won.
      # Can use display result to determine who
      break if board.someone_won? || board.full?

      computer_moves
      break if board.someone_won? || board.full?

      display_board
    end
    display_result
    display_goodbye_message
  end
end

game = TTTGame.new
game.play
