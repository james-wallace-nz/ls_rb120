class Participant
  attr_reader :name, :hand, :hand_values

  def initialize(name)
    new_hand
    @name = name
    @hand_values = []
  end

  def display_hand
    puts "#{@name} has:"
    @hand.each do |card|
      puts card.to_s
    end
  end

  def display_hand_values
    if hand_values.length == 1
      puts "#{@name} has a hand value of #{hand_values.first}."
    else
      puts "#{@name} has potential hand values of:"
      hand_values.each do |hand_value|
        puts hand_values if hand_value <= Game::TWENTY_ONE_THRESHOLD
      end
    end
  end

  def new_hand
    @hand = []
    @hand_values = determine_hand_values
  end

  def receive_card(card)
    @hand.push(card)
    @hand_values = determine_hand_values
  end

  def display_card(card, display)
    if @hand.length == 1 || display
      puts "#{name} dealt a #{card}"
    else
      puts "#{name} dealt an unknown card"
    end
  end

  def busted?
    min_hand_value > Game::TWENTY_ONE_THRESHOLD
  end

  def >(other_participant)
    max_hand_value > other_participant.max_hand_value
  end

  def ==(other_participant)
    max_hand_value == other_participant.max_hand_value
  end

  private

  def clear_screen
    system 'clear'
  end

  def determine_hand_values
    [hand.reduce(0) { |sum, card| sum + card.card_value }]
  end

  def min_hand_value
    minimum = hand_values.min
    minimum.nil? ? 0 : minimum
  end

  protected

  def max_hand_value
    maximum = hand_values.max
    maximum.nil? ? 0 : maximum
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
      move = normalize(move)
      break if %w(hit stay).include? move

      clear_screen
      puts "Invalid move. Enter 'Hit' or 'h' / 'Stay' or 's'"
    end
    move
  end

  private

  def normalize(move)
    case move
    when 's' then 'stay'
    when 'h' then 'hit'
    end
  end
end

class Dealer < Participant
  HIT_THRESHOLD = 17

  def initialize
    super('Dealer')
  end

  def display_first_card
    first_card = @hand.first
    puts "#{@name} has #{first_card} and an unknown card."
  end

  def choose_move
    max_hand_value >= HIT_THRESHOLD ? 'stay' : 'hit'
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

  def deal_card(participant, display = true)
    card = deck.shift
    participant.receive_card(card)
    participant.display_card(card, display)
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
  TWENTY_ONE_THRESHOLD = 21

  def initialize
    @player = Player.new
    @dealer = Dealer.new
  end

  def start
    display_welcome_message

    loop do
      game_loop
      display_participant_cards
      participant_busted? ? display_busted : display_winner
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
    clear_participant_hands
    deal_initial_cards
    display_hands_for_player
    player_turn
    return if @player.busted?
    dealer_turn
  end

  def create_shuffled_deck
    @deck = Deck.new
    @deck.shuffle_deck!
  end

  def clear_participant_hands
    @player.new_hand
    @dealer.new_hand
  end

  def deal_initial_cards
    2.times do
      @deck.deal_card(@player)
      @deck.deal_card(@dealer, false)
    end
    puts "Cards have been dealt..."
  end

  def display_hands_for_player
    puts ''
    @dealer.display_first_card
    puts ''
    @player.display_hand
    puts ''
    @player.display_hand_values
    puts ''
  end

  def player_turn
    loop do
      move = @player.choose_move
      clear_screen
      puts "#{@player.name} choose to #{move}..."
      break if move == 'stay'
      @deck.deal_card(@player)
      break if @player.busted?
      display_hands_for_player
    end
  end

  def dealer_turn
    loop do
      move = @dealer.choose_move
      puts ''
      puts "#{@dealer.name} choose to #{move}..."
      break if move == 'stay'
      @deck.deal_card(@dealer)
      break if @dealer.busted?
    end
  end

  def display_participant_cards
    puts ''
    @dealer.display_hand
    @dealer.display_hand_values
    puts ''
    @player.display_hand
    @player.display_hand_values
    puts ''
  end

  def participant_busted?
    @player.busted? || @dealer.busted?
  end

  def display_busted
    if @player.busted?
      puts "#{@player.name} busts!!"
      puts "#{@dealer.name} wins!"
    elsif @dealer.busted?
      puts "#{@dealer.name} busts!!"
      puts "#{@player.name} wins!"
    end
  end

  def display_winner
    winner = determine_winner
    puts winner == 'tie' ? "It's a tie!" : "#{winner} wins the round!"
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
