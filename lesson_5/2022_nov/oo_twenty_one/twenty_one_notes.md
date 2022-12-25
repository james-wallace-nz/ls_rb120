
Description:
52-card deck consisting of 4 suits (hearts, diamonds, clubs, spades) and 13 values (2, 3, 4, 5, 6, 7, 8, 9, 10, jack, queek, king, ace).each

Dealer deals cards to a Player and iteself. 2 cards dealt first.
Player can see their 2 cards but only one of the Dealer's cards.

Cards are worth face value, except:
jack, queen, king worth 10
Ace can be 1 or 11 - determined each time a new card is dealt

Player goes first and decides to 'hit' or 'stay'
Hit means player is dealt another card
If total exceeds 21 then player 'busts'

Once Player 'stays', Dealer must hit until total is at least 17

If dealer busts then Player wins

When both player and dealer stay, compare total value of cards to see who has highest value

Nouns:
  Card
  Deck
  Suit
  Face value
  Dealer
  Player
  Hand
  Hand_value (attribute within a class, or verb #calculate_total)

Verbs:
  deal
  hit
  stay
  bust (state, player/dealer busted?)
  compare hands

Organised:
  deck
   - deal? (or in Dealer?)
  - card
    - suit
      - face value

  Participant super-class or Hand module?
     - #hit
     - #stay
     - #busted?
     - #total
    - Dealer
        - #deal (or in deck?)
    - Player
      - hand
        - #hand value (total)
        - #compare hand
         - cards

  Game
  - #start
    - #turn