# Number Guesser Part 1

# Create an object-oriented number guessing class for numbers in the range 1 to 100, with a limit of 7 guesses per game. The game should play like this:

# class GuessingGame
#   MAX_GUESSES = 7
#   RANGE = (1..100).freeze

#   def initialize
#     @remaining_guesses = MAX_GUESSES
#     @number = rand(RANGE)
#   end

#   # invalid guess - doesn't change @remaining_guesses

#   def play
#     guess = nil
#     loop do
#       display_request

#       loop do
#         guess = gets.chomp
#         break if valid_guess?(guess)

#         print 'Invalid guess. Enter a number between 1 and 100: '
#       end

#       break if guess.to_i == @number

#       update_remaining_guesses(guess)
#       break if @remaining_guesses.zero?
#     end

#     display_result(guess)
#   end

#   private

#   def display_request
#     puts ''
#     puts "You have #{@remaining_guesses} guesses remaining."
#     print 'Enter a number between 1 and 100: '
#   end

#   def update_remaining_guesses(guess)
#     puts "Your guess is too #{range(guess)}."
#     @remaining_guesses -= 1
#   end

#   def range(guess)
#     guess.to_i > @number ? 'high' : 'low'
#   end

#   def valid_guess?(guess)
#     return false if guess.to_i.to_s != guess || guess.to_i > 100 || guess.to_i < 1

#     true
#   end

#   def display_result(guess)
#     if guess.to_i == @number
#       puts "That's the number!"
#       puts ''
#       puts 'You won!'
#     else
#       puts ''
#       puts 'You have no more guesses. You lost!'
#     end
#   end
# end

# SOLUTION

class GuessingGame
  MAX_GUESSES = 7
  RANGE = (1..100).freeze

  RESULT_OF_GUESS = {
    high: 'Your guess is too high',
    low: 'Your guess is too low',
    match: "That's the number!"
  }.freeze

  WIN_OR_LOSE = {
    high: :lose,
    low: :lose,
    match: :win
  }.freeze

  RESULT_OF_GAME = {
    win: 'You won!',
    lose: 'You have no more guesses. You lost!'
  }.freeze

  def initialize
    @secret_number = nil
  end

  def play
    reset
    game_result = play_game
    display_game_result(game_result)
  end

  private

  def reset
    @secret_number = rand(RANGE)
  end

  # return :win or :lose
  def play_game
    result = nil
    MAX_GUESSES.downto(1) do |remaining_guesses|
      display_guesses_remaining(remaining_guesses)
      result = check_guess(obtain_one_guess)
      display_guess_result(result)
      break if result == :match
    end
    WIN_OR_LOSE[result]
  end

  def display_guesses_remaining(remaining_guesses)
    puts
    if remaining_guesses == 1
      puts 'You have one guess remaining'
    else
      puts "You have #{remaining_guesses} guesses remaining"
    end
  end

  def obtain_one_guess
    loop do
      print 'Enter a number between 1 and 100: '
      guess = gets.chomp.to_i
      return guess if RANGE.cover?(guess)

      print 'Invalid guess. '
    end
  end

  def check_guess(guess)
    if guess > @secret_number
      :high
    elsif guess < @secret_number
      :low
    else
      :match
    end
  end

  def display_guess_result(result)
    puts RESULT_OF_GUESS[result]
  end

  def display_game_result(game_result)
    puts ''
    puts RESULT_OF_GAME[game_result]
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

# You have 1 guesses remaining.
# Enter a number between 1 and 100: 32
# Your guess is too low.

# You have no more guesses. You lost!

# Note that a game object should start a new game with a new number to guess with each call to `#play`.


# Further Exploration

# We took a straightforward approach here and implemented a single class. Do you think it's a good idea to have a Player class? What methods and data should be part of it? How many Player objects do you need? Should you use inheritance, a mix-in module, or a collaborative object?


# If using Player classes, could have two player objects - one chooser object and one guesser

# Player parent class
  # obtain_number

# - chooser sub-class
  #  @secret_number
  #  check_guess

# - guesser sub-class
  #  validate_guess
