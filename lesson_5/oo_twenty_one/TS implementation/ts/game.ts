import readlineSync from "readline-sync";
/* eslint-disable */
const _ = require("lodash");
require("lodash.permutations");

function userInput(question: string): string {
  return readlineSync.question(question);
}

type Move = "hit" | "stay";

class Participant {
  name: string;
  _hand: Card[];
  #handValues: number[];

  constructor(name: string) {
    this.name = name;
    this._hand = [];
    this.#handValues = [];
  }

  newHand(): void {
    this._hand = [];
    this.#handValues = this.determineHandValues();
  }

  receiveCard(card: Card): void {
    this._hand.push(card);
    this.#handValues = this.determineHandValues();
  }

  displayCard(card: Card, displayAfterFirst: boolean): void {
    if (this._hand.length === 1 || displayAfterFirst) {
      console.log(`${this.name} dealt a ${card.toString()}`);
    } else {
      console.log(`${this.name} dealt an unknown card`);
    }
  }

  displayHand(): void {
    console.log(`${this.name} has:`);
    this._hand.forEach((card: Card) => console.log(card.toString()));
  }

  displayHandValues(): void {
    const playableValues: number[] = this.valuesBelowThreshold().sort();
    if (playableValues.length === 1) {
      console.log(`${this.name} has a hand value of ${playableValues[0]}.`);
    } else {
      console.log(
        `${this.name} has potential hand values of: ${this.joiner(
          playableValues,
          ", "
        )}`
      );
    }
  }

  displayMaxHandValue(): void {
    const maxPlayableValue: number = Math.max(...this.valuesBelowThreshold());
    console.log(`${this.name} has a hand value of ${maxPlayableValue}.`);
  }

  displayMove(move: Move): void {
    console.log(`${this.name} choose to ${move}...`);
  }

  busted(): boolean {
    return this.minPlayableHandValue() > Game.twentyOneThreshold;
  }

  greaterThan(otherParticipant: Participant): boolean {
    return (
      this.maxPlayableHandValue() > otherParticipant.maxPlayableHandValue()
    );
  }

  equalTo(otherParticipant: Participant): boolean {
    return (
      this.maxPlayableHandValue() === otherParticipant.maxPlayableHandValue()
    );
  }

  clearScreen() {
    console.clear();
  }

  valuesBelowThreshold() {
    const playableValues = this.#handValues.filter((handValue) => {
      return handValue <= Game.twentyOneThreshold;
    });
    return playableValues.length === 0
      ? [Math.min(...this.#handValues)]
      : playableValues;
  }

  joiner(array: number[], delimiter = ", ", finalSeparator = "or"): string {
    switch (array.length) {
      case 0:
        return "";
      case 1:
        return array[0].toString();
      case 2:
        return array.join(` ${finalSeparator} `);
      default:
        return `${_.join(
          array.slice(0, -2),
          delimiter
        )}${delimiter}${finalSeparator} ${array.slice(-1)}`;
    }
  }

  determineHandValues() {
    // extract non-aces and aces from hand
    const nonAces = this._hand.filter((card: Card) => card.faceValue !== "Ace");
    const aces = this._hand.filter((card: Card) => card.faceValue === "Ace");

    // sum non-ace card values
    const nonAcesSum = this.sumNonAces(nonAces);

    // sum possible ace permutations
    const acePermutationsSum = this.possibleAceValues(aces);

    // add non-ace card values to ace permutations
    const possibleHandValues = this.possibleHandValues(
      nonAcesSum,
      acePermutationsSum
    );

    return aces.length === 0 ? [nonAcesSum] : possibleHandValues;
  }

  sumNonAces(nonAces: Card[]) {
    return nonAces.reduce((sum: number, card: Card) => {
      if (typeof card.cardValue === "number") {
        const value: number = card.cardValue;
        return sum + value;
      } else {
        return sum;
      }
    }, 0);
  }

  possibleAceValues(aces: Card[]) {
    // extract ace values nested array
    const aceValues = aces.map((card: Card) => card.cardValue);

    // determine uniq ace permutations
    const acePermutations = _.uniqWith(
      _.permutations(aceValues.flat(), aceValues.length),
      _.isEqual
    );

    // sum ace permutations
    return _.uniq(
      acePermutations.map((permutation: number[]) => {
        return permutation.reduce((cum, cur) => {
          return cum + cur;
        }, 0);
      })
    );
  }

  possibleHandValues(nonAcesSum: number, acePermutationsSum: number[]) {
    return acePermutationsSum.map((value) => value + nonAcesSum);
  }

  minPlayableHandValue(): number {
    const minimum = Math.min(...this.#handValues);
    return minimum === undefined ? 0 : minimum;
  }

  maxPlayableHandValue(): number {
    const maximum = Math.max(...this.valuesBelowThreshold());
    return maximum === undefined ? 0 : maximum;
  }
}

class Player extends Participant {
  constructor(name: string) {
    super(name);
  }

  chooseMove(): Move {
    let move = "";
    let loop = true;
    while (loop) {
      move = userInput(
        "What do you want to do? ('Hit' or 'h' / 'Stay' or 's'):"
      ).toLowerCase();

      switch (move) {
        case "s":
          move = "stay";
          break;
        case "h":
          move = "hit";
          break;
        default:
          break;
      }

      if (["hit", "stay"].includes(move)) {
        loop = false;
        break;
      }

      this.clearScreen();
      console.log("Invalid move. Enter 'Hit' or 'h' / 'Stay' or 's'");
    }

    if (move === "hit" || move === "stay") {
      return move;
    } else {
      return "stay";
    }
  }
}

class Dealer extends Participant {
  hitThreshold: number;

  constructor() {
    super("Dealer");
    this.hitThreshold = 17;
  }

  displayFirstCard(): void {
    const firstCard = this._hand[0];
    console.log(`${this.name} has ${firstCard} and an unknown card.`);
  }

  chooseMove(): Move {
    return this.maxPlayableHandValue() >= this.hitThreshold ? "stay" : "hit";
  }
}

class Deck {
  suits: string[];
  faceValues: string[];
  cardValues: (number | [number, number])[];
  deck: Card[];

  constructor() {
    this.suits = ["Diamonds", "Hearts", "Spades", "Clubs"];
    this.faceValues = [
      "2",
      "3",
      "4",
      "5",
      "6",
      "7",
      "8",
      "9",
      "10",
      "Jack",
      "Queen",
      "King",
      "Ace",
    ];
    this.cardValues = [2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, [1, 10]];
    this.deck = this.createNewDeck();
  }

  toString(): void {
    this.deck.forEach((card: Card) => console.log(card));
  }

  shuffleDeck() {
    this.deck = _.shuffle(this.deck);
  }

  dealCard(participant: Participant, displayAfterFirst = true) {
    const card = this.deck.shift();

    if (card instanceof Card) {
      participant.receiveCard(card);
      participant.displayCard(card, displayAfterFirst);
    }
  }

  createNewDeck() {
    const tempDeck: Card[] = [];

    this.suits.forEach((suit: string) => {
      this.faceValues.forEach((faceValue: string, index) => {
        const cardValue = this.cardValues[index];
        const newCard = new Card(suit, faceValue, cardValue);
        tempDeck.push(newCard);
      });
    });
    return tempDeck;
  }
}

class Card {
  suit: string;
  faceValue: string;
  cardValue: number | number[];

  constructor(suit: string, faceValue: string, cardValue: number | number[]) {
    this.suit = suit;
    this.faceValue = faceValue;
    this.cardValue = cardValue;
  }

  toString(): string {
    return `${this.faceValue} of ${this.suit}`;
  }
}

class Game {
  player: Player;
  dealer: Dealer;
  deck: Deck;

  constructor(playerName: string) {
    this.player = new Player(playerName);
    this.dealer = new Dealer();
    this.deck = new Deck();
  }

  start() {
    this.displayWelcomeMessage();

    let loop = true;
    while (loop) {
      this.gameLoop();
      this.displayFinalParticipantCards();
      this.participantBusted() ? this.displayBusted() : this.displayWinner();
      if (!this.playAgain()) {
        loop = false;
        break;
      }

      this.displayPlayAgainMessage();
    }

    this.displayGoodbyeMessage();
  }

  clearScreen() {
    console.clear();
  }

  static get twentyOneThreshold(): number {
    return 21;
  }

  displayWelcomeMessage(): void {
    this.clearScreen();
    console.log(`Hi ${this.player.name}!`);
    console.log("Welcome to Twenty One.");
    console.log("");
  }

  gameLoop(): void {
    this.createShuffledDeck();
    this.clearParticipantHands();
    this.dealInitialCards();
    this.displayParticipantHandsForPlayer();
    this.playerTurn();
    if (this.participantBusted()) {
      return;
    }
    this.dealerTurn();
  }

  createShuffledDeck() {
    this.deck = new Deck();
    this.deck.shuffleDeck();
  }

  clearParticipantHands() {
    this.player.newHand();
    this.dealer.newHand();
  }

  dealInitialCards() {
    for (let i = 0; i < 2; i++) {
      this.deck.dealCard(this.player);
      this.deck.dealCard(this.dealer, false);
      i + 1;
    }
    console.log("Cards have been dealt...");
  }

  displayParticipantHandsForPlayer() {
    console.log("");
    this.dealer.displayFirstCard();
    console.log("");
    this.player.displayHand();
    console.log("");
    this.player.displayHandValues();
    console.log("");
  }

  playerTurn() {
    let loop = true;
    while (loop) {
      const move = this.player.chooseMove();
      this.clearScreen();
      this.player.displayMove(move);
      if (move == "stay") {
        loop = false;
        break;
      }
      this.deck.dealCard(this.player);
      if (this.player.busted()) {
        break;
      }
      this.displayParticipantHandsForPlayer();
    }
  }

  dealerTurn() {
    let loop = true;
    while (loop) {
      const move = this.dealer.chooseMove();
      console.log("");
      this.dealer.displayMove(move);
      if (move == "stay") {
        loop = false;
        break;
      }
      this.deck.dealCard(this.dealer);
      if (this.dealer.busted()) {
        break;
      }
    }
  }

  displayFinalParticipantCards() {
    console.log("");
    this.dealer.displayHand();
    this.dealer.displayMaxHandValue();
    console.log("");
    this.player.displayHand();
    this.player.displayMaxHandValue();
    console.log("");
  }

  participantBusted(): boolean {
    return this.player.busted() || this.dealer.busted();
  }

  displayBusted(): void {
    if (this.player.busted()) {
      console.log(`${this.player.name} busts!!`);
      console.log(`${this.dealer.name} wins!`);
    } else if (this.dealer.busted()) {
      console.log(`${this.dealer.name} busts!!`);
      console.log(`${this.player.name} wins!`);
    }
  }

  displayWinner(): void {
    const winner = this.determineWinner();
    winner == "tie"
      ? console.log("It's a tie!")
      : console.log(`${winner} wins the round!`);
  }

  determineWinner(): string {
    if (this.player.greaterThan(this.dealer)) {
      return this.player.name;
    } else if (this.player.equalTo(this.dealer)) {
      return "tie";
    } else {
      return this.dealer.name;
    }
  }

  playAgain(): boolean {
    let answer = "";
    let loop = true;
    while (loop) {
      answer = userInput(
        "Do you want to play again? ('Yes' or 'y' / 'No' of 'n'):\n"
      );

      if (["yes", "y", "no", "n"].includes(answer)) {
        loop = false;
        break;
      }

      console.log("Invalid answer. Enter 'Yes' or 'y' / 'No' of 'n'");
    }

    return ["yes", "y"].includes(answer);
  }

  displayPlayAgainMessage(): void {
    this.clearScreen();
    console.log("Let's play another round!");
    console.log("");
  }

  displayGoodbyeMessage(): void {
    this.clearScreen();
    console.log(`Thanks for playing Twenty One, ${this.player.name}!`);
  }
}

function enterPlayerName(): string {
  console.clear();
  let playerName = "";
  let loop = true;
  while (loop) {
    playerName = userInput("What's your name?\n");
    if (playerName !== "") {
      loop = false;
      break;
    }
    console.clear();
    console.log("Invalid name. Please enter at least one character");
  }
  return playerName;
}

const playerName = enterPlayerName();
const game = new Game(playerName);
game.start();
