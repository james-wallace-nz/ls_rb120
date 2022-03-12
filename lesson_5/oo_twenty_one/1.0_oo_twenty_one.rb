module Hand
  def total_hand_value; end
end

class Participant
  include Hand
  attr_reader :name, :hand

  def initialize(name)
    @hand = []
    @name = name
  end

  def display_hand
    puts "#{@name} has:"
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

  def > other_participant
    true
  end

  def == other_participant
    true
  end

  private

  def clear_screen
    system 'clear'
  end
end

class Player < Participant
  def initialize
    super(enter_player_name)
  end

  def enter_player_name
    name = nil
    clear_screen
    loop do
      puts "What's your name?"
      name = gets.chomp
      break unless name == ''

      clear_screen
      puts 'Invalid name. Please enter at least one character'
    end

    name
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
end

class Dealer < Participant
  def initialize
    super('Dealer')
  end

  def display_first_card
    first_card = @hand.first
    puts "#{@name} has #{first_card} and an unknown card."
  end

  def choose_move
    'stay'
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

  def deal_card(participant)
    participant.hand.push(deck.shift)
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
    @player = Player.new
    @dealer = Dealer.new
  end

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

  def clear_screen
    system 'clear'
  end

  def display_welcome_message
    clear_screen
    puts "Hi #{@player.name}!"
    puts 'Welcome to Twenty One.'
    puts ''
  end

  def game_loop
    create_shuffled_deck
    deal_initial_cards
    display_hands_for_player
    player_turn
    puts "#{@player.name} chose to stay..."
    dealer_turn
    puts "#{@dealer.name} chose to stay..."
    display_participant_cards
    display_game_result
  end

  def create_shuffled_deck
    @deck = Deck.new
    @deck.shuffle_deck!
  end

  def deal_initial_cards
    2.times do
      @deck.deal_card(@player)
      @deck.deal_card(@dealer)
    end
    puts "Cards have been dealt..."
  end

  def display_hands_for_player
    puts ''
    @dealer.display_first_card
    puts ''
    @player.display_hand
    puts ''
    @player.display_hand_value
    puts ''
  end

  def player_turn
    loop do
      move = @player.choose_move
      clear_screen
      break if %w(stay s).include?(move)
      puts "#{@player.name} choose to hit..."
      @deck.deal_card(@player)
      break if @player.busted?
      display_hands_for_player
    end
  end

  def dealer_turn
    display_participant_cards
    loop do
      move = @dealer.choose_move
      clear_screen
      break if %w(stay).include?(move)
      puts "#{@dealer.name} chose to hit..."
      @deck.deal_card(@dealer)
      break if @dealer.busted?
      display_participant_cards
    end
  end

  def display_participant_cards
    puts ''
    @dealer.display_hand
    @dealer.display_hand_value
    puts ''
    @player.display_hand
    @player.display_hand_value
    puts ''
  end

  def display_game_result
    winner = determine_winner
    if winner == 'tie'
      puts "It's a tie!"
    else
      puts "#{winner} wins the round!"
    end
  end

  def determine_winner
    if @player > @dealer
      @player.name
    elsif @player == @dealer
      'tie'
    else
      @dealer.name
    end
  end

  def play_again?
    answer = nil
    loop do
      puts ''
      puts "Do you want to play again? ('Yes' or 'y' / 'No' of 'n'):"
      answer = gets.chomp.downcase
      break if %w(yes y no n).include?(answer)
      clear_screen
      puts "Invalid answer. Enter 'Yes' or 'y' / 'No' of 'n'"
    end

    %w(yes y).include?(answer)
  end

  def display_play_again_message
    clear_screen
    puts "Let's play another round!"
    puts ''
  end

  def display_goodbye_message
    clear_screen
    puts "Thanks for playing Twenty One, #{@player.name}!"
  end
end

Game.new.start
