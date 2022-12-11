# Create an object-oriented number guessing class for numbers in the range 1 to 100, with a limit of 7 guesses per game. The game should play like this:

class GuessingGame
  MAX_GUESSES = 7
  RANGE = 1..100

  def initialize
    @guesses_remaining = nil
    @number = nil
    @current_guess = nil
  end

  def play
    reset
    play_game
    display_result
  end

  private

  def reset
    @guesses_remaining = MAX_GUESSES
    @number = rand(RANGE)
  end

  def play_game
    loop do
      obtain_guess
      check_guess
      break if winner?
      @guesses_remaining -= 1
      break if @guesses_remaining == 0
    end
  end

  def obtain_guess
    puts "You have #{@guesses_remaining} guesses remaining."
    @current_guess = valid_guess
  end

  def valid_guess
    guess = nil

    loop do
      print "Enter a number between #{RANGE.first} and #{RANGE.last}: "
      guess = gets.chomp
      break if /^\d+$/.match(guess) && RANGE.cover?(guess) #  guess.to_i >= RANGE.first && guess.to_i <= RANGE.last
      print "Invalid guess. "
    end

    guess.to_i
  end

  def check_guess
    if @current_guess > @number
      puts "Your guess is too high."
    elsif @current_guess < @number
      puts "Your guess is too low."
    end
  end

  def display_result
    winner? ? win : lost
  end

  def winner?
    @current_guess == @number
  end

  def win
    puts "You won!"
  end

  def lost
    puts "You have no more guesses. You lost!"
  end
end

game = GuessingGame.new
game.play

# You have 7 guesses remaining.
# Enter a number between 1 and 100: 104
# Invalid guess. Enter a number between 1 and 100: 50
# Your guess is too low.

# You have 6 guesses remaining.
# Enter a number between 1 and 100: 75
# Your guess is too low.

# You have 5 guesses remaining.
# Enter a number between 1 and 100: 85
# Your guess is too high.

# You have 4 guesses remaining.
# Enter a number between 1 and 100: 0
# Invalid guess. Enter a number between 1 and 100: 80

# You have 3 guesses remaining.
# Enter a number between 1 and 100: 81
# That's the number!

# You won!

# game.play

# You have 7 guesses remaining.
# Enter a number between 1 and 100: 50
# Your guess is too high.

# You have 6 guesses remaining.
# Enter a number between 1 and 100: 25
# Your guess is too low.

# You have 5 guesses remaining.
# Enter a number between 1 and 100: 37
# Your guess is too high.

# You have 4 guesses remaining.
# Enter a number between 1 and 100: 31
# Your guess is too low.

# You have 3 guesses remaining.
# Enter a number between 1 and 100: 34
# Your guess is too high.

# You have 2 guesses remaining.
# Enter a number between 1 and 100: 32
# Your guess is too low.

# You have 1 guess remaining.
# Enter a number between 1 and 100: 32
# Your guess is too low.

# You have no more guesses. You lost!

# Note that a game object should start a new game with a new number to guess with each call to #play.



# Most classes need an #initialize method to initialize its internal state. That isn't necessary here since we don't need to choose a secret number until play begins. It's good practice, though, to always initialize your instance variables in the #initialize method, even if you don't have to. It provides a single location where you can see all your instance variables.

