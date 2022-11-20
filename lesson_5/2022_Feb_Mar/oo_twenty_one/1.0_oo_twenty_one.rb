class Participant
  attr_reader :name

  def initialize(name)
    new_hand
    @name = name
    @hand_values = []
  end

  def new_hand
    @hand = []
    @hand_values = determine_hand_values
  end

  def receive_card(card)
    @hand.push(card)
    @hand_values = determine_hand_values
  end

  def display_card(card, display_after_first)
    if @hand.length == 1 || display_after_first
      puts "#{name} dealt a #{card}"
    else
      puts "#{name} dealt an unknown card"
    end
  end

  def display_hand
    puts "#{name} has:"
    @hand.each do |card|
      puts card.to_s
    end
  end

  def display_hand_values
    playable_values = values_below_threshold.sort!
    if playable_values.length == 1
      puts "#{name} has a hand value of #{playable_values.first}."
    else
      puts "#{name} has potential hand values of: #{joiner(playable_values, ', ')}"
    end
  end

  def display_max_hand_value
    max_playable_value = values_below_threshold.max
    puts "#{name} has a hand value of #{max_playable_value}."
  end

  def display_move(move)
    puts "#{name} choose to #{move}..."
  end

  def busted?
    min_playable_hand_value > Game::TWENTY_ONE_THRESHOLD
  end

  def >(other_participant)
    max_playable_hand_value > other_participant.max_playable_hand_value
  end

  def ==(other_participant)
    max_playable_hand_value == other_participant.max_playable_hand_value
  end

  private

  def clear_screen
    system 'clear'
  end

  def values_below_threshold
    playable_values = @hand_values.select do |hand_value|
      hand_value <= Game::TWENTY_ONE_THRESHOLD
    end
    playable_values.empty? ? [@hand_values.min] : playable_values
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

  def determine_hand_values
    # extract non-aces and aces from hand
    non_aces, aces = @hand.partition { |card| card.face_value != 'Ace' }

    # sum non-ace card values
    non_aces_sum = sum_non_aces(non_aces)

    # sum possible ace permutations
    ace_permutations_sum = possible_ace_values(aces)

    # add non-ace card values to ace permutations
    possible_hand_values = possible_hand_values(non_aces_sum, ace_permutations_sum)

    aces.empty? ? [non_aces_sum] : possible_hand_values
  end

  def sum_non_aces(non_aces)
    non_aces.reduce(0) do |sum, card|
      sum + card.card_value
    end
  end

  def possible_ace_values(aces)
    # extract ace values nested array
    ace_values = aces.map(&:card_value)

    # determine uniq ace permutations
    ace_permutations = ace_values.flatten.permutation(aces.length).to_a.uniq

    # sum ace permutations
    ace_permutations.map(&:sum).uniq
  end

  def possible_hand_values(non_aces_sum, ace_permutations_sum)
    ace_permutations_sum.map do |value|
      value + non_aces_sum
    end
  end

  def min_playable_hand_value
    minimum = @hand_values.min
    minimum.nil? ? 0 : minimum
  end

  protected

  def max_playable_hand_value
    maximum = values_below_threshold.max
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
    puts "#{name} has #{first_card} and an unknown card."
  end

  def choose_move
    max_playable_hand_value >= HIT_THRESHOLD ? 'stay' : 'hit'
  end
end

class Deck
  SUITS = ['Diamonds', 'Hearts', 'Spades', 'Clubs']
  FACE_VALUES = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Ace']
  CARD_VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, [1, 11]]

  def initialize
    @deck = create_new_deck
  end

  def to_s
    @deck.each do |card|
      puts card
    end
  end

  def shuffle_deck!
    @deck.shuffle!
  end

  def deal_card(participant, display_after_first: true)
    card = @deck.shift
    participant.receive_card(card)
    participant.display_card(card, display_after_first)
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
      display_final_participant_cards
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
    display_participant_hands_for_player
    player_turn
    return if participant_busted?
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
      @deck.deal_card(@dealer, display_after_first: false)
    end
    puts "Cards have been dealt..."
  end

  def display_participant_hands_for_player
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
      @player.display_move(move)
      break if move == 'stay'
      @deck.deal_card(@player)
      break if @player.busted?
      display_participant_hands_for_player
    end
  end

  def dealer_turn
    loop do
      move = @dealer.choose_move
      puts ''
      @dealer.display_move(move)
      break if move == 'stay'
      @deck.deal_card(@dealer)
      break if @dealer.busted?
    end
  end

  def display_final_participant_cards
    puts ''
    @dealer.display_hand
    @dealer.display_max_hand_value
    puts ''
    @player.display_hand
    @player.display_max_hand_value
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
