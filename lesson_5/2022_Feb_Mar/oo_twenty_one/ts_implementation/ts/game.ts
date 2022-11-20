import readlineSync from "readline-sync";

import { Player, Dealer } from './participants'
import { Deck } from './deckAndCards'

function userInput(question: string): string {
  return readlineSync.question(question);
}

export default class Game {
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
