module Hand
  def total_hand_value; end
end

class Participant
  include Hand
  attr_reader :name

  def initialize(name)
    @hand = []
    @name = name
  end

  def display_hand
    @hand.each do |card|
      puts card.to_s
    end
  end

  def display_hand_value
    puts "#{@name} has a hand value of [number]."
  end

  def busted?
    false
  end
end

class Player < Participant; end

class Dealer < Participant
  def initialize
    super('Dealer')
  end

  def deal_card(participant); end

  def display_first_card
    first_card = @hand.first
    puts "#{@name} has #{first_card}"
  end
end

class Deck
  SUITS = ['Diamonds', 'Hearts', 'Spades', 'Clubs']
  FACE_VALUES = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Ace']
  CARD_VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 11] # [1, 10]]

  attr_accessor :deck

  def initialize
    @deck = create_new_deck
  end

  def to_s
    deck.each do |card|
      puts card
    end
  end

  def shuffle_deck!
    @deck.shuffle!
  end

  private

  def create_new_deck
    temp_deck = []

    SUITS.each do |suit|
      FACE_VALUES.each_with_index do |face_value, index|
        card_value = CARD_VALUES[index]
        new_card = Card.new(suit, face_value, card_value)
        temp_deck.push(new_card)
      end
    end
    temp_deck
  end
end

class Card
  attr_reader :suit, :face_value, :card_value

  def initialize(suit, face_value, card_value)
    @suit = suit
    @face_value = face_value
    @card_value = card_value
  end

  def to_s
    "#{face_value} of #{suit}"
  end
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
    create_shuffled_deck
    deal_initial_cards
    display_hands_for_player
    player_turn
    dealer_turn
    display_game_result
  end

  def create_shuffled_deck
    @deck = Deck.new
    @deck.shuffle_deck!
  end

  def deal_initial_cards
    2.times do
      @dealer.deal_card(@player)
      @dealer.deal_card(@dealer)
    end
  end

  def display_hands_for_player
    @dealer.display_first_card
    @dealer.display_hand_value
    @player.display_hand
    @player.display_hand_value
  end

  def player_turn
    loop do
      move = choose_move
      break if move == 'stay' || move == 's'
      @dealer.deal_card(@player)
      break if @player.busted?
      display_hands_for_player
    end
  end

  def display_participant_cards
    @dealer.display_hand
    @dealer.display_hand_value
    @player.display_hand
    @player.display_hand_value
  end

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

  def dealer_turn
    display_participant_cards
    loop do
      move = 'stay' # dealer_move_logic
      puts "#{@dealer.name} #{move}."
      display_participant_cards
      break if move == 'stay'
      @dealer.deal_card(@dealer)
      break if @dealer.busted?
    end
  end

  def display_game_result
    # determine winner or tie
    # display winner or tie
    puts 'You win!'
  end

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
