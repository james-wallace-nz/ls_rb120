require 'pry'
require 'pry-byebug'

module Hand
  MAX_HAND_VALUE = 21
  OPTIMAL_HIT_VALUE = 17

  def hit(new_card)
    puts "#{name} choose to hit"
    puts ''
    puts "#{name} dealt #{new_card}..."
    add_card(new_card)
    puts ''
    puts "#{name}'s cards are:"
    display_hand
    display_hand_value
  end

  def stay
    puts "#{name} chose to stay."
    puts ''
    puts "#{name}'s cards are:"
    display_hand
    display_hand_value
  end

  def busted?
    hand_value > MAX_HAND_VALUE
  end

  def add_card(card)
    @hand.push(card)
  end

  def display_hand
    @hand.each do |card|
      puts " - #{card}"
    end
  end

  def hand_value
    value = 0
    @hand.each do |card|
      value += card.face == 'Ace' ? card.value.last : card.value
    end

    @hand.select { |card| card.face == 'Ace' }.each do |_|
      if value > MAX_HAND_VALUE
        value -= 10
      end
    end

    value
  end

  def display_hand_value
    puts "#{name} has a hand value of #{hand_value}"
  end

  def reset_hand
    @hand = []
  end
end

class Participant
  include Hand
  include Comparable

  attr_reader :name

  def initialize(name)
    @name = name
    @hand = []
  end

  def <=>(other_player)
    hand_value <=> other_player.hand_value
  end
end

class Player < Participant
end

class Dealer < Participant
  def display_first_card
    puts " - #{@hand.first}"
  end

  def display_first_card_value
    card = @hand.first
    value = if card.face == 'Ace'
              card.value.last
            else
              card.value
            end
    puts "#{name} has a hand value of #{value}"
  end
end

class Deck
  SUITS = ['Hearts', 'Diamonds', 'Clubs', 'Spades']
  FACES = {
    '2' => 2,
    '3' => 3,
    '4' => 4,
    '5' => 5,
    '6' => 6,
    '7' => 7,
    '8' => 8,
    '9' => 9,
    '10' => 9,
    'Jack' => 10,
    'Queen' => 10,
    'King' => 10,
    'Ace' => [1, 11]
  }

  def initialize
    @deck = create_deck
  end

  def create_deck
    temp_deck = []
    SUITS.each do |suit|
      FACES.each do |face, value|
        card = Card.new(suit, face, value)
        temp_deck.push(card)
      end
    end

    temp_deck
  end

  def deal
    card = @deck.sample
    @deck.delete(card)
  end
end

class Card
  attr_reader :suit, :face, :value

  def initialize(suit, face, value)
    @suit = suit
    @face = face
    @value = value
  end

  def to_s
    "#{face} of #{suit}"
  end
end

# Orchestration engine

class TwentyOneGame
  def initialize
    @player = Player.new('Player')
    @dealer = Dealer.new('Dealer')
    reset_deck
  end

  def start
    display_welcome_message
    main_game
    display_goodbye_message
  end

  private

  def display_welcome_message
    clear_screen
    puts "Welcome to Twenty One!"
    puts ''
  end

  def reset_deck
    @deck = Deck.new
  end

  def main_game
    loop do
      deal_initial_cards
      show_initial_cards
      player_move
      dealer_move unless @player.busted?
      display_result
      break unless play_again?

      reset_game
      display_play_again_message
    end
  end

  def deal_initial_cards
    puts "First two cards being dealt..."
    puts ''
    2.times do
      @player.add_card(@deck.deal)
      @dealer.add_card(@deck.deal)
    end
  end

  def show_initial_cards
    puts "Dealer's cards include:"
    @dealer.display_first_card
    @dealer.display_first_card_value
    puts ''
    puts "Player's cards are:"
    @player.display_hand
    @player.display_hand_value
  end

  def player_move
    loop do
      action = player_action
      clear_screen
      if action == 'h'
        @player.hit(@deck.deal)
        break if @player.busted?
      else
        @player.stay
        break
      end
    end
  end

  def player_action
    action = nil
    loop do
      puts ''
      puts "Do you want to hit or stay? (h/s)"
      action = gets.chomp.downcase
      break if %w(h s).include? action

      clear_screen
      puts "Invalid answer. Enter 'h' or 's'"
      @player.display_hand_value
    end
    action
  end

  def dealer_move
    puts ''
    loop do
      if @dealer.hand_value < Dealer::OPTIMAL_HIT_VALUE
        @dealer.hit(@deck.deal)
        break if @dealer.busted?
      else
        @dealer.stay
        break
      end
    end
  end

  def display_result
    puts ''
    if @player.busted? || (@player < @dealer && !@dealer.busted?)
      puts "Dealer wins"
    elsif @dealer.busted? || @player > @dealer
      puts "Player wins!"
    else
      puts "It's a tie"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts ''
      puts "Do you want to play again? (y/n)"
      answer = gets.chomp.downcase
      clear_screen
      break if %w(y n).include? answer

      puts "Invalid answer. Enter 'y' or 'n'"
    end
    answer == 'y'
  end

  def reset_game
    reset_deck
    reset_player_hands
  end

  def reset_player_hands
    @player.reset_hand
    @dealer.reset_hand
  end

  def clear_screen
    system 'clear'
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ''
  end

  def display_goodbye_message
    puts ''
    puts "Thanks for playing Twenty One. Goodbye!"
  end
end

game = TwentyOneGame.new
game.start
