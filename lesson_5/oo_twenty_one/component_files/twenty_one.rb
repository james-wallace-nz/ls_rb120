require './participants'
require './deck_and_card'

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
