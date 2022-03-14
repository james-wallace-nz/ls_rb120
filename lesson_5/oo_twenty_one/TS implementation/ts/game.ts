type Move = 'hit' | 'stay'

class Participant {
  name: string
  // fix
  #hand: Card[]
  #handValues: number[]

  constructor(name: string) {
    this.name = name
    this.#hand = []
    this.#handValues = []
  }

  newHand(): void {
    this.#hand = []
    this.#handValues = this.determineHandValues()
  }

  receiveCard(card: Card): void {
    this.#hand.push(card)
    this.#handValues = this.determineHandValues()
  }

  displayCard(card: Card, displayAfterFirst: boolean): void {
    if (this.#hand.length === 1 || displayAfterFirst) {
      console.log(`${this.name} dealt a ${card}`)
    } else {
      console.log(`${this.name} dealt an unknown card`)
    }
  }

  displayHand(): void {
    console.log(`${this.name} has:`)
    this.#hand.forEach((card: Card) => console.log(card.toString()))
  }

  displayHandValues(): void {
    const playableValues: number[] = this.valuesBelowThreshold().sort()
    if (playableValues.length === 1) {
      console.log(`${this.name} has a hand value of ${playableValues[0]}.`)
    } else {
      console.log(`${this.name} has potential hand values of: ${this.joiner(playableValues, ', ')}`)
    }
  }

  displayMaxHandValue(): void {
    const maxPlayableValue: number = this.valuesBelowThreshold().max()
    console.log(`${this.name} has a hand value of ${maxPlayableValue}.`)
  }

  displayMove(move: Move): void {
    console.log(`${this.name} choose to ${move}...`)
  }

  busted(): boolean {
    // fix
    return this.minPlayableHandValue() > 21
  }

  greaterThan(otherParticipant: Participant): boolean {
    return this.maxPlayableHandValue() > otherParticipant.maxPlayableHandValue()
  }

  equalTo(otherParticipant: Participant): boolean {
    return this.maxPlayableHandValue() === otherParticipant.maxPlayableHandValue()
  }

  // fix
  clearScreen() {
    // system 'clear'
  }

  valuesBelowThreshold() {
    const playableValues = this.#handValues.filter(handValue => {
      // fix
      return handValue <= 21
    })
    return playableValues.length === 0 ? [Math.min(...this.#handValues)] : playableValues
  }

  joiner(array: number[], delimiter: string = ', ', finalSeparator: string = 'or'): string {
    switch (array.length) {
    case 0: 
      return ''
    case 1: 
      return array[0].toString()
    case 2: 
      return array.join(` ${finalSeparator} `)
    default:
      return `${array[0..-2].join(delimiter)}${delimiter}${finalSeparator} ${array[-1]}`
    }
  }

  determineHandValues() {
    // extract non-aces and aces from hand
    const nonAces = this.#hand.filter((card: Card) => card.faceValue !== 'Ace')
    const aces = this.#hand.filter((card: Card) => card.faceValue === 'Ace')

    // sum non-ace card values
    const nonAcesSum = this.sumNonAces(nonAces)

    // sum possible ace permutations
    const acePermutationsSum = this.possibleAceValues(aces)

    // add non-ace card values to ace permutations
    const possibleHandValues = this.possibleHandValues(nonAcesSum, acePermutationsSum)

    return aces.length === 0 ? [nonAcesSum] : possibleHandValues
  }

  sumNonAces(nonAces: Card[]) {
    return nonAces.reduce((sum: number, card: Card) => {
      return sum + card.cardValue
    }, 0)
  }

  possibleAceValues(aces: Card[]) {
    // extract ace values nested array
    const aceValues = aces.map((card: Card) => card.cardValue)

    // determine uniq ace permutations
    const acePermutations = aceValues.flatten().permutation(aces.length).to_a.uniq

    // sum ace permutations
    return acePermutations.map((permutation: number[][]) => permutation.sum()).uniq
  }

  possibleHandValues(nonAcesSum: number, acePermutationsSum: number[]) {
    return acePermutationsSum.map((value) => value + nonAcesSum)
  }

  minPlayableHandValue(): number {
    const minimum = Math.min(...this.#handValues)
    // fix
    return minimum === undefined ? 0 : minimum
  }

  maxPlayableHandValue(): number {
    const maximum = Math.max(...this.valuesBelowThreshold())
    // fix
    return maximum === undefined ? 0 : maximum
  }
}

class Player extends Participant {
  constructor() {
    super(this.enterPlayerName())
  }

  enterPlayerName(): string {
    let name: string;
    this.clearScreen()
    while (true) {
      console.log("What's your name?")
      // fix
      name = gets.chomp
      if (name != '') {
        break
      }

      this.clearScreen()
      console.log('Invalid name. Please enter at least one character')
    }

    return name
  }

  chooseMove(): string {
    let move: string
    while (true) {
      console.log("What do you want to do? ('Hit' or 'h' / 'Stay' or 's'):")
      // fix
      move = gets.chomp.downcase()
      move = this.normalize(move)
      if (['hit', 'stay'].includes(move)) {
        break
      }

      this.clearScreen()
      console.log("Invalid move. Enter 'Hit' or 'h' / 'Stay' or 's'")
    }
    return move
  }

  // fix types
  normalize(move: string): string {
    switch(move) {
    case 's':
      return 'stay'
    case 'h':
      return 'hit'
    default: 
      return move
    }
  }
}  

class Dealer extends Participant {
  const hitThreshold = 17

  constructor() {
    super('Dealer')
  }

  displayFirstCard(): void {
    const firstCard = this.#hand[0]
    console.log(`${this.name} has ${firstCard} and an unknown card.`)
  }

  chooseMove(): Move {
    return this.maxPlayableHandValue() >= this.hitThreshold ? 'stay' : 'hit'
  }
}

class Deck {  
  const suits: string[] = ['Diamonds', 'Hearts', 'Spades', 'Clubs']
  const faceValues: string[] = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Ace']
  const cardValues: number[] | number[][] = [2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, [1, 10]]
  deck: Card[]

  constructor() {
    this.deck = this.createNewDeck()
  }

  toString(): void {
    this.deck.forEach((card: Card) => console.log(card))
  }

  shuffleDeck() {
    // to fix
    this.deck.shuffle()
  }

  dealCard(participant: Participant, displayAfterFirst: boolean = true) {
    const card = this.deck.shift
    participant.receiveCard(card)
    participant.displayCard(card, displayAfterFirst)
  }

  createNewDeck() {
    const tempDeck: Card[] = []

    this.suits.forEach((suit: string) => {
      this.faceValues.forEach((faceValue: string, index) => {
        const cardValue = this.cardValues[index]
        const newCard = new Card(suit, faceValue, cardValue)
        tempDeck.push(newCard)
      })
    })
    return tempDeck
  }
}

class Card {
  suit: string;
  faceValue: string;
  cardValue: number | number[];

  constructor(suit: string, faceValue: string, cardValue: number | number[]) {
    this.suit = suit
    this.faceValue = faceValue
    this.cardValue = cardValue
  }

  toString() {
    `${this.faceValue} of ${this.suit}`
  }
}

class Game {
  const twentyOneThreshold = 21
  player: Player
  dealer: Dealer
  deck: Deck

  constructor() {
    this.player = new Player()
    this.dealer = new Dealer()
    this.deck = new Deck()
  }

  start() {
    this.displayWelcomeMessage()

    while (true) {
      this.gameLoop()
      this.displayFinalParticipantCards()
      this.participantBusted() ? this.displayBusted() : this.displayWinner()
      if (!this.playAgain()) {
        break
      }

      this.displayPlayAgainMessage()
    }

    this.displayGoodbyeMessage()
  }

  clearScreen() {
    // fix
    // system 'clear'
  }

  displayWelcomeMessage(): void {
    this.clearScreen()
    console.log(`Hi ${this.player.name}!`)
    console.log('Welcome to Twenty One.')
    console.log('')
  }

  gameLoop(): void {
    this.createShuffledDeck()
    this.clearParticipantHands()
    this.dealInitialCards()
    this.displayParticipantHandsForPlayer()
    this.playerTurn()
    if (this.participantBusted()) {
      break
    }
    this.dealerTurn()
  }

  createShuffledDeck() {
    this.deck = new Deck()
    this.deck.shuffleDeck()
  }

  clearParticipantHands() {
    this.player.newHand()
    this.dealer.newHand()
  }

  dealInitialCards() {
    for(let i = 0; i < 2; i++) {
      this.deck.dealCard(this.player)
      this.deck.dealCard(this.dealer, false)
      i + 1
    }
    console.log("Cards have been dealt...")
  }

  displayParticipantHandsForPlayer() {
    console.log('')
    this.dealer.displayFirstCard()
    console.log('')
    this.player.displayHand()
    console.log('')
    this.player.displayHandValues()
    console.log('')
  }

  playerTurn() {
    while (true) {
      const move = this.player.chooseMove()
      this.clearScreen()
      this.player.displayMove(move)
      if (move == 'stay') {
        break
      }
      this.deck.dealCard(this.player)
      if (this.player.busted()) {
        break
      }
      this.displayParticipantHandsForPlayer()
    }
  }

  dealerTurn() {
    while (true) {
      const move = this.dealer.chooseMove()
      console.log('')
      this.dealer.displayMove(move)
      if (move == 'stay') {
        break
      }
      this.deck.dealCard(this.dealer)
      if (this.dealer.busted()) {
        break
      }
    }
  }

  displayFinalParticipantCards() {
    console.log('')
    this.dealer.displayHand()
    this.dealer.displayMaxHandValue()
    console.log('')
    this.player.displayHand()
    this.player.displayMaxHandValue()
    console.log('')
  }

  participantBusted(): boolean {
    return this.player.busted() || this.dealer.busted()
  }

  displayBusted(): void {
    if (this.player.busted()) {
      console.log(`${this.player.name} busts!!`)
      console.log(`${this.dealer.name} wins!`)
    } else if (this.dealer.busted()) {
      console.log(`${this.dealer.name} busts!!`)
      console.log(`${this.player.name} wins!`)
    }
  }

  displayWinner(): void {
    const winner = this.determineWinner()
    winner == 'tie' ? console.log("It's a tie!") : console.log(`${winner} wins the round!`)
  }

  determineWinner(): string {
    if (this.player.greaterThan(this.dealer)) {
      return this.player.name
    } else if (this.player.equalTo(this.dealer)) {
      return 'tie'
    } else {
      return this.dealer.name
    }
  }

  playAgain(): boolean {
    let answer
    while (true) {
      console.log('')
      console.log("Do you want to play again? ('Yes' or 'y' / 'No' of 'n'):")

      // fix
      answer = gets.chomp.downcase
      if (['yes', 'y', 'no', 'n'].includes(answer)) {
        break
      }
      this. clearScreen()
      console.log( "Invalid answer. Enter 'Yes' or 'y' / 'No' of 'n'")
    }

    return ['yes', 'y'].includes(answer)
  }

  displayPlayAgainMessage(): void {
    this.clearScreen()
    console.log("Let's play another round!")
    console.log('')
  }

  displayGoodbyeMessage(): void {
    this.clearScreen()
    console.log(`Thanks for playing Twenty One, ${this.player.name}!`)
  }
}

const game = new Game()
game.start()
