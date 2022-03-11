module Hand
  def total_hand_value; end
end

class Participant
  include Hand

  def initialize; end

  def hit; end

  def stay; end

  def busted?; end
end

class Player
  def initialize(name)
    super
    @name = name
  end
end

class Dealer
  def deal; end
end

class Deck
  def initialize; end
end

class Card
  def initialize; end
end

class Game
  def initialize; end

  def start
    display_welcome_message

    loop do
      game_loop
      break unless play_again?

      display_play_again_message
    end

    display_goodbye_message
  end

  private

  def display_welcome_message
    puts 'Welcome to Twenty One!'
  end

  def game_loop
    deal_cards
    show_initial_cards
    player turn
    dealer turn
    display_game_result
  end

  def deal_cards; end

  def show_initial_cards; end

  def show_player_cards; end

  def show_dealer_card; end

  def player_turn; end

  def dealer_turn; end

  def display_game_result; end

  def play_again?
    answer = nil
    loop do
      puts "Do you want to play again? (Y/N):"
      answer = gets.chomp.downcase

      break if %w(y n).include?(answer)

      puts "Invalid answer. Enter 'Y', or 'N'"
    end

    answer == 'y'
  end

  def display_play_again_message
    puts "Let's play another round!"
  end

  def display_goodbye_message
    puts 'Thanks for playing Twenty One!'
  end
end

Game.new.start
