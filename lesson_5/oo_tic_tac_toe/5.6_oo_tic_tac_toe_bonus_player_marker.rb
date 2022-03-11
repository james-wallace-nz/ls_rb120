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

  def empty?(square)
    @squares[square].marker == Square::INITIAL_MARKER
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      return squares.first.marker if three_identical_markers?(squares)
    end
    nil
  end

  # rubocop:disable Metrics/MethodLength
  def third_square_available(marker)
    squares_under_threat = []

    # iterate through board winning lines
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      # two squares of winning line are human marker and third is empty
      if two_taken_one_empty?(squares, marker)
        # empty square instance
        empty_square = empty_square(squares)

        # index of empty square instance
        empty_square_index = squares.index(empty_square)

        # empty square key
        square = line[empty_square_index]

        # add to array
        squares_under_threat.push(square)
      end
    end

    # return array
    squares_under_threat
  end
  # rubocop:enable Metrics/MethodLength

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

  def two_taken_one_empty?(squares, marker)
    squares.count { |square| square.marker == marker } == 2 &&
      squares.count { |square| square.marker == Square::INITIAL_MARKER } == 1
  end

  def empty_square(squares)
    squares.select(&:unmarked?).first
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
  COMPUTER_MARKER = 'O'
  FIRST_MOVERS = ['player', 'ai']
  SCORE_THRESHOLD = 5

  attr_reader :board, :human, :computer, :scores
  attr_accessor :current_player, :first_to_move

  def initialize
    @board = Board.new
    set_human_marker
    @human = Player.new(@human_marker)
    @computer = Player.new(COMPUTER_MARKER)
    @scores = {
      @human_marker => 0,
      COMPUTER_MARKER => 0
    }
  end

  # rubocop:disable Metrics/MethodLength
  def play
    clear_screen
    display_welcome_message
    set_first_mover
    loop do
      main_game
      display_match_result
      break unless play_again?

      reset_match
      display_play_again_message
    end
    display_goodbye_message
  end
  # rubocop:enable Metrics/MethodLength

  private

  def clear_screen
    system 'clear' unless @first_to_move == COMPUTER_MARKER
  end

  def set_human_marker
    marker = nil
    loop do
      puts "Choose your one character marker (not empty or 'O'):"
      marker = gets.chomp.upcase[0]
      break unless marker == Square::INITIAL_MARKER || marker == COMPUTER_MARKER

      puts "Invalid entry. Type anything but ' ' and 'O'"
    end
    @human_marker = marker
  end

  def display_welcome_message
    puts 'Welcome to Tic Tac Toe!'
  end

  def set_first_mover
    first_mover = nil
    loop do
      puts 'Choose the first mover (Player/AI):'
      first_mover = gets.chomp.downcase
      break if FIRST_MOVERS.include?(first_mover)

      puts "Invalid entry. Type in Player' or 'AI'"
    end
    @first_to_move = first_mover == FIRST_MOVERS[0] ? @human_marker : COMPUTER_MARKER
    @current_player = @first_to_move
  end

  def main_game
    loop do
      display_match_scores
      display_board
      player_move
      increment_scores
      display_game_result
      break if player_won_match?

      reset_game
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
    self.current_player = human_turn? ? COMPUTER_MARKER : @human_marker
  end

  def human_turn?
    current_player == @human_marker
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
    when 2 then array.join(" #{final_separator} ")
    else
      "#{array[0..-2].join(delimiter)}#{delimiter}#{final_separator} #{array[-1]}"
    end
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def computer_moves
    # determine if two squares of winning lines are human / computer and third is empty
    opportunity_squares = board.third_square_available(computer.marker)
    threatened_squares = board.third_square_available(human.marker)
    chosen_square = nil
    # rubocop:disable Style/ConditionalAssignment
    if board.empty?(5)
      chosen_square = 5
    elsif !opportunity_squares.empty?
      chosen_square = opportunity_squares.sample
    elsif !threatened_squares.empty?
      chosen_square = threatened_squares.sample
    else
      chosen_square = board.unmarked_keys.sample
    end
    # rubocop:enable Style/ConditionalAssignment
    board[chosen_square] = computer.marker
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  def clear_screen_and_display_board
    clear_screen
    display_board
  end

  def increment_scores
    case board.winning_marker
    when human.marker
      update_score(@human_marker)
    when computer.marker
      update_score(COMPUTER_MARKER)
    else
      update_score(@human_marker)
      update_score(COMPUTER_MARKER)
    end
  end

  def update_score(player_marker)
    scores[player_marker] += 1
  end

  def display_game_result
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

  def display_match_scores
    puts  "You have #{scores[@human_marker]} and the computer has #{scores[COMPUTER_MARKER]}. " \
          "It's first to #{SCORE_THRESHOLD}."
  end

  def reset_game
    board.reset
    self.current_player = @first_to_move
  end

  def player_won_match?
    !match_winners.empty?
  end

  def match_winners
    scores.select { |_, score| score == SCORE_THRESHOLD }.keys
  end

  def display_match_result
    human_score = scores[@human_marker]
    computer_score = scores[COMPUTER_MARKER]
    winners = match_winners
    if winners.size == 2
      puts "It's a tie! #{SCORE_THRESHOLD} each."
    elsif winners.first == @human_marker
      puts "You won! #{human_score} to #{computer_score}."
    elsif winners.first == COMPUTER_MARKER
      puts "Computer won! #{computer_score} to #{human_score}."
    end
  end

  def play_again?
    answer = nil
    loop do
      puts 'Would you like to play another match? (y/n)'
      answer = gets.chomp.downcase
      break if %w(y n).include? answer

      puts 'Sorry, must be y or n'
    end

    answer == 'y'
  end

  def reset_match
    self.scores = {
      @human_marker => 0,
      COMPUTER_MARKER => 0
    }
    reset_game
    clear_screen
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ''
  end
end

game = TTTGame.new
game.play
