class Board
  attr_reader :board

  def initialize(width)
    @board = create_board(width)
  end

  def create_board(width)
    board = []
    width.times do |idx|
      board.push([])

      width.times do |_|
        board[idx].push(Square.new)
      end
    end
    board
  end

  def display_board
    horizontal = "\n---+---+---\n"
    grid = []

    board.each do |row|
      grid << row.join('|')
    end
    puts grid.join(horizontal)
  end
end

class Square
  def initialize
    @status = '-'
  end

  def to_s
    " #{@status} "
  end
end

class Player
  def initialize
    # Player symbol, name?
  end

  def play; end

  def mark; end
end

class TTTGame
  def play
    board = Board.new(3)
    # display_welcome_message
    loop do
      board.display_board
      # first_player_moves
      # break if someone_won || board_full?

      # second_player_moves
      # break if someone_won || board_full?
      break
    end
    # display_result
    # display_goodbye_message
  end
end

game = TTTGame.new
game.play
