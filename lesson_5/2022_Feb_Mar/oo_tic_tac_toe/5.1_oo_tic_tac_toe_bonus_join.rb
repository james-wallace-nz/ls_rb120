class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +   # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +   # cols
                  [[1, 5, 9], [3, 5, 7]]                # diagonals

  def initialize
    @squares = {}
    reset
  end

  def []=(key, marker)
    @squares[key].marker = marker
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
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
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

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
      squares = @squares.values_at(*line)
      return squares.first.marker if three_identical_markers?(squares)
    end
    nil
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  private

  def three_identical_markers?(squares)
    # returns an array of square objects that are marked. Then returns array of markers
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3

    # return true if lowest and highest marker are the same
    markers.min == markers.max
  end
end

class Square
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

  def marked?
    marker != INITIAL_MARKER
  end
end

class Player
  attr_reader :marker

  def initialize(marker)
    @marker = marker
  end
end

class TTTGame
  HUMAN_MARKER = 'X'
  COMPUTER_MARKER = 'O'
  FIRST_TO_MOVE = HUMAN_MARKER

  attr_reader :board, :human, :computer
  attr_accessor :current_player

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
    @current_player = FIRST_TO_MOVE
  end

  def play
    clear_screen
    display_welcome_message
    main_game
    display_goodbye_message
  end

  private

  def clear_screen
    system 'clear'
  end

  def display_welcome_message
    puts 'Welcome to Tic Tac Toe!/n'
  end

  def main_game
    loop do
      display_board
      player_move
      display_result
      break unless play_again?

      reset
      display_play_again_message
    end
  end

  def display_goodbye_message
    puts 'Thanks for playing Tic Tac Toe! Goodbye!'
  end

  def display_board
    puts "You're a #{human.marker}. Computer is a #{computer.marker}."
    puts ''
    board.draw
    puts ''
  end

  def player_move
    loop do
      current_player_moves
      break if board.someone_won? || board.full?

      clear_screen_and_display_board if human_turn?
    end
  end

  def current_player_moves
    human_turn? ? human_moves : computer_moves
    self.current_player = human_turn? ? COMPUTER_MARKER : HUMAN_MARKER
  end

  def human_turn?
    current_player == HUMAN_MARKER
  end

  def human_moves
    unmarked_keys = board.unmarked_keys

    puts "Choose a square (#{joiner(unmarked_keys, ', ')})"
    square = nil
    loop do
      square = gets.chomp.to_i
      break if unmarked_keys.include?(square)

      puts "Sorry, that's not a valid option."
    end

    board[square] = human.marker
  end

  def joiner(array, delimiter = ', ', final_separator = 'or')
    case array.length
    when 0 then ''
    when 1 then array.first
    when 2 then array.join(' #{final_separator} ')
    else
      "#{array[0..-2].join(delimiter)}#{delimiter}#{final_separator} #{array[-1]}"
      # below functional programming solutoin doesn't work because it mutates the unmarked keys
      # therefore, 9 doesn't work as an input
      # array[-1] = "#{final_separator} #{array[-1]}"
      # array.join(delimiter)
    end
  end

  def computer_moves
    board[board.unmarked_keys.sample] = computer.marker
  end

  def clear_screen_and_display_board
    clear_screen
    display_board
  end

  def display_result
    clear_screen_and_display_board
    case board.winning_marker
    when human.marker
      puts 'You won!'
    when computer.marker
      puts 'Computer won!'
    else
      puts "It's a tie!"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts 'Would you like to play again? (y/n)'
      answer = gets.chomp.downcase
      break if %w(y n).include? answer

      puts 'Sorry, must be y or n'
    end

    answer == 'y'
  end

  def reset
    board.reset
    self.current_player = FIRST_TO_MOVE
    clear_screen
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ''
  end
end

game = TTTGame.new
game.play
