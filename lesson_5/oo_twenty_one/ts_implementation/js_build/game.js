"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const readline_sync_1 = __importDefault(require("readline-sync"));
const participants_1 = require("./participants");
const deckAndCards_1 = require("./deckAndCards");
function userInput(question) {
    return readline_sync_1.default.question(question);
}
class Game {
    constructor(playerName) {
        this.player = new participants_1.Player(playerName);
        this.dealer = new participants_1.Dealer();
        this.deck = new deckAndCards_1.Deck();
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
    static get twentyOneThreshold() {
        return 21;
    }
    displayWelcomeMessage() {
        this.clearScreen();
        console.log(`Hi ${this.player.name}!`);
        console.log("Welcome to Twenty One.");
        console.log("");
    }
    gameLoop() {
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
        this.deck = new deckAndCards_1.Deck();
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
    participantBusted() {
        return this.player.busted() || this.dealer.busted();
    }
    displayBusted() {
        if (this.player.busted()) {
            console.log(`${this.player.name} busts!!`);
            console.log(`${this.dealer.name} wins!`);
        }
        else if (this.dealer.busted()) {
            console.log(`${this.dealer.name} busts!!`);
            console.log(`${this.player.name} wins!`);
        }
    }
    displayWinner() {
        const winner = this.determineWinner();
        winner == "tie"
            ? console.log("It's a tie!")
            : console.log(`${winner} wins the round!`);
    }
    determineWinner() {
        if (this.player.greaterThan(this.dealer)) {
            return this.player.name;
        }
        else if (this.player.equalTo(this.dealer)) {
            return "tie";
        }
        else {
            return this.dealer.name;
        }
    }
    playAgain() {
        let answer = "";
        let loop = true;
        while (loop) {
            answer = userInput("Do you want to play again? ('Yes' or 'y' / 'No' of 'n'):\n");
            if (["yes", "y", "no", "n"].includes(answer)) {
                loop = false;
                break;
            }
            console.log("Invalid answer. Enter 'Yes' or 'y' / 'No' of 'n'");
        }
        return ["yes", "y"].includes(answer);
    }
    displayPlayAgainMessage() {
        this.clearScreen();
        console.log("Let's play another round!");
        console.log("");
    }
    displayGoodbyeMessage() {
        this.clearScreen();
        console.log(`Thanks for playing Twenty One, ${this.player.name}!`);
    }
}
exports.default = Game;
function enterPlayerName() {
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
//# sourceMappingURL=game.js.map