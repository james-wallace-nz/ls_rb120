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
