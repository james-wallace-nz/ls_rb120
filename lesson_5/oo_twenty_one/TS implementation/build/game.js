"use strict";
var __classPrivateFieldSet = (this && this.__classPrivateFieldSet) || function (receiver, state, value, kind, f) {
    if (kind === "m") throw new TypeError("Private method is not writable");
    if (kind === "a" && !f) throw new TypeError("Private accessor was defined without a setter");
    if (typeof state === "function" ? receiver !== state || !f : !state.has(receiver)) throw new TypeError("Cannot write private member to an object whose class did not declare it");
    return (kind === "a" ? f.call(receiver, value) : f ? f.value = value : state.set(receiver, value)), value;
};
var __classPrivateFieldGet = (this && this.__classPrivateFieldGet) || function (receiver, state, kind, f) {
    if (kind === "a" && !f) throw new TypeError("Private accessor was defined without a getter");
    if (typeof state === "function" ? receiver !== state || !f : !state.has(receiver)) throw new TypeError("Cannot read private member from an object whose class did not declare it");
    return kind === "m" ? f : kind === "a" ? f.call(receiver) : f ? f.value : state.get(receiver);
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
var _Participant_handValues;
Object.defineProperty(exports, "__esModule", { value: true });
const readline_sync_1 = __importDefault(require("readline-sync"));
const _ = require("lodash");
require("lodash.permutations");
function userInput(question) {
    return readline_sync_1.default.question(question);
}
class Participant {
    constructor(name) {
        _Participant_handValues.set(this, void 0);
        this.name = name;
        this._hand = [];
        __classPrivateFieldSet(this, _Participant_handValues, [], "f");
    }
    newHand() {
        this._hand = [];
        __classPrivateFieldSet(this, _Participant_handValues, this.determineHandValues(), "f");
    }
    receiveCard(card) {
        this._hand.push(card);
        __classPrivateFieldSet(this, _Participant_handValues, this.determineHandValues(), "f");
    }
    displayCard(card, displayAfterFirst) {
        if (this._hand.length === 1 || displayAfterFirst) {
            console.log(`${this.name} dealt a ${card.toString()}`);
        }
        else {
            console.log(`${this.name} dealt an unknown card`);
        }
    }
    displayHand() {
        console.log(`${this.name} has:`);
        this._hand.forEach((card) => console.log(card.toString()));
    }
    displayHandValues() {
        const playableValues = this.valuesBelowThreshold().sort();
        if (playableValues.length === 1) {
            console.log(`${this.name} has a hand value of ${playableValues[0]}.`);
        }
        else {
            console.log(`${this.name} has potential hand values of: ${this.joiner(playableValues, ", ")}`);
        }
    }
    displayMaxHandValue() {
        const maxPlayableValue = Math.max(...this.valuesBelowThreshold());
        console.log(`${this.name} has a hand value of ${maxPlayableValue}.`);
    }
    displayMove(move) {
        console.log(`${this.name} choose to ${move}...`);
    }
    busted() {
        return this.minPlayableHandValue() > Game.twentyOneThreshold;
    }
    greaterThan(otherParticipant) {
        return (this.maxPlayableHandValue() > otherParticipant.maxPlayableHandValue());
    }
    equalTo(otherParticipant) {
        return (this.maxPlayableHandValue() === otherParticipant.maxPlayableHandValue());
    }
    clearScreen() {
        console.clear();
    }
    valuesBelowThreshold() {
        const playableValues = __classPrivateFieldGet(this, _Participant_handValues, "f").filter((handValue) => {
            return handValue <= Game.twentyOneThreshold;
        });
        return playableValues.length === 0
            ? [Math.min(...__classPrivateFieldGet(this, _Participant_handValues, "f"))]
            : playableValues;
    }
    joiner(array, delimiter = ", ", finalSeparator = "or") {
        switch (array.length) {
            case 0:
                return "";
            case 1:
                return array[0].toString();
            case 2:
                return array.join(` ${finalSeparator} `);
            default:
                return `${_.join(array.slice(0, -2), delimiter)}${delimiter}${finalSeparator} ${array.slice(-1)}`;
        }
    }
    determineHandValues() {
        const nonAces = this._hand.filter((card) => card.faceValue !== "Ace");
        const aces = this._hand.filter((card) => card.faceValue === "Ace");
        const nonAcesSum = this.sumNonAces(nonAces);
        const acePermutationsSum = this.possibleAceValues(aces);
        const possibleHandValues = this.possibleHandValues(nonAcesSum, acePermutationsSum);
        return aces.length === 0 ? [nonAcesSum] : possibleHandValues;
    }
    sumNonAces(nonAces) {
        return nonAces.reduce((sum, card) => {
            if (typeof card.cardValue === "number") {
                const value = card.cardValue;
                return sum + value;
            }
            else {
                return sum;
            }
        }, 0);
    }
    possibleAceValues(aces) {
        const aceValues = aces.map((card) => card.cardValue);
        const acePermutations = _.uniqWith(_.permutations(aceValues.flat(), aceValues.length), _.isEqual);
        return _.uniq(acePermutations.map((permutation) => {
            return permutation.reduce((cum, cur) => {
                return cum + cur;
            }, 0);
        }));
    }
    possibleHandValues(nonAcesSum, acePermutationsSum) {
        return acePermutationsSum.map((value) => value + nonAcesSum);
    }
    minPlayableHandValue() {
        const minimum = Math.min(...__classPrivateFieldGet(this, _Participant_handValues, "f"));
        return minimum === undefined ? 0 : minimum;
    }
    maxPlayableHandValue() {
        const maximum = Math.max(...this.valuesBelowThreshold());
        return maximum === undefined ? 0 : maximum;
    }
}
_Participant_handValues = new WeakMap();
class Player extends Participant {
    constructor(name) {
        super(name);
    }
    chooseMove() {
        let move = "";
        let loop = true;
        while (loop) {
            move = userInput("What do you want to do? ('Hit' or 'h' / 'Stay' or 's'):").toLowerCase();
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
        }
        else {
            return "stay";
        }
    }
}
class Dealer extends Participant {
    constructor() {
        super("Dealer");
        this.hitThreshold = 17;
    }
    displayFirstCard() {
        const firstCard = this._hand[0];
        console.log(`${this.name} has ${firstCard} and an unknown card.`);
    }
    chooseMove() {
        return this.maxPlayableHandValue() >= this.hitThreshold ? "stay" : "hit";
    }
}
class Deck {
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
    toString() {
        this.deck.forEach((card) => console.log(card));
    }
    shuffleDeck() {
        this.deck = _.shuffle(this.deck);
    }
    dealCard(participant, displayAfterFirst = true) {
        const card = this.deck.shift();
        if (card instanceof Card) {
            participant.receiveCard(card);
            participant.displayCard(card, displayAfterFirst);
        }
    }
    createNewDeck() {
        const tempDeck = [];
        this.suits.forEach((suit) => {
            this.faceValues.forEach((faceValue, index) => {
                const cardValue = this.cardValues[index];
                const newCard = new Card(suit, faceValue, cardValue);
                tempDeck.push(newCard);
            });
        });
        return tempDeck;
    }
}
class Card {
    constructor(suit, faceValue, cardValue) {
        this.suit = suit;
        this.faceValue = faceValue;
        this.cardValue = cardValue;
    }
    toString() {
        return `${this.faceValue} of ${this.suit}`;
    }
}
class Game {
    constructor(playerName) {
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