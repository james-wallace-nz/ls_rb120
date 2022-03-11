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
  attr_reader :name

  def initialize(name)
    super()
    @name = name
  end
end

class Dealer
  def deal_card; end
end

class Deck
  def initialize; end
end

class Card
  def initialize; end
end

class Game
  def initialize
    @player = Player.new(enter_player_name)
    @dealer = Dealer.new
  end

  def start
    clear_screen
    display_welcome_message

    loop do
      game_loop
      break unless play_again?

      clear_screen
      display_play_again_message
    end

    clear_screen
    display_goodbye_message
  end

  private

  def enter_player_name
    name = nil
    loop do
      puts "What's your name?"
      name = gets.chomp
      break unless name == ''

      clear_screen
      puts 'Invalid name. Please enter at least one character'
    end

    name
  end

  def clear_screen
    system 'clear'
  end

  def display_welcome_message
    puts "Hi #{@player.name}! Welcome to Twenty One."
  end

  def game_loop
    deal_cards
    display_initial_cards
    player_turn
    dealer_turn
    display_game_result
  end

  def deal_cards; end

  def display_initial_cards; end

  def display_player_cards; end

  def display_dealer_card; end

  def player_turn
    loop do
      display_participant_cards
      move = choose_move
      break if move == 'stay' || move == 's'
      deal_card
    end
  end

  def display_participant_cards; end

  def choose_move
    move = nil
    loop do
      puts "What do you want to do? ('Hit' or 'h' / 'Stay' or 's'):"
      move = gets.chomp.downcase
      break if %w(hit h stay s).include? move

      clear_screen
      puts "Invalid move. Enter 'Hit' or 'h' / 'Stay' or 's'"
    end
    move
  end

  def deal_card; end

  def dealer_turn; end

  def display_game_result; end

  def play_again?
    answer = nil
    clear_screen
    loop do
      puts "Do you want to play again? ('Yes' or 'y' / 'No' of 'n'):"
      answer = gets.chomp.downcase
      break if %w(yes y no n).include?(answer)
      clear_screen
      puts "Invalid answer. Enter 'Yes' or 'y' / 'No' of 'n'"
    end

    answer == 'yes'
  end

  def display_play_again_message
    puts "Let's play another round!"
  end

  def display_goodbye_message
    puts "Thanks for playing Twenty One, #{@player.name}!"
  end
end

Game.new.start
