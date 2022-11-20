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
