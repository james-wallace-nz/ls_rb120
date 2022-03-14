"use strict";
require("lodash.permutations");
const _ = require("lodash");
const readline = require("readline");
class Participant {
    constructor(name) {
        this.name = name;
        this._hand = [];
        this._handValues = [];
    }
    newHand() {
        this._hand = [];
        this._handValues = this.determineHandValues();
    }
    receiveCard(card) {
        this._hand.push(card);
        this._handValues = this.determineHandValues();
    }
    displayCard(card, displayAfterFirst) {
        if (this._hand.length === 1 || displayAfterFirst) {
            console.log(`${this.name} dealt a ${card}`);
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
        return this.minPlayableHandValue() > 21;
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
        const playableValues = this._handValues.filter((handValue) => {
            return handValue <= 21;
        });
        return playableValues.length === 0
            ? [Math.min(...this._handValues)]
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
        const minimum = Math.min(...this._handValues);
        return minimum === undefined ? 0 : minimum;
    }
    maxPlayableHandValue() {
        const maximum = Math.max(...this.valuesBelowThreshold());
        return maximum === undefined ? 0 : maximum;
    }
}
class Player extends Participant {
    constructor(name) {
        super(name);
    }
    chooseMove() {
        let move = "";
        const rl = readline.createInterface({
            input: process.stdin,
            output: process.stdout,
        });
        rl.on("close", function () {
            process.exit(0);
        });
        let loop = true;
        while (loop) {
            move = rl.question("What do you want to do? ('Hit' or 'h' / 'Stay' or 's'):", function (move) {
                switch (move) {
                    case "s":
                        return "stay";
                    case "h":
                        return "hit";
                    default:
                        return move;
                }
            });
            if (["hit", "stay"].includes(move)) {
                loop = false;
                break;
            }
            this.clearScreen();
            console.log("Invalid move. Enter 'Hit' or 'h' / 'Stay' or 's'");
        }
        rl.close();
        if (move === "hit" || move == "stay") {
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
        this.cardValues = [
            2,
            3,
            4,
            5,
            6,
            7,
            8,
            9,
            10,
            10,
            10,
            10,
            [1, 10],
        ];
        this.deck = this.createNewDeck();
    }
    toString() {
        this.deck.forEach((card) => console.log(card));
    }
    shuffleDeck() {
        return _.shuffle(this.deck);
    }
    dealCard(participant, displayAfterFirst = true) {
        const card = this.deck.shift;
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
        `${this.faceValue} of ${this.suit}`;
    }
}
class Game {
    constructor(playerName) {
        this.twentyOneThreshold = 21;
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
        let answer;
        const rl = readline.createInterface({
            input: process.stdin,
            output: process.stdout,
        });
        rl.on("close", function () {
            process.exit(0);
        });
        let loop = true;
        while (loop) {
            console.log("");
            answer = rl.question("Do you want to play again? ('Yes' or 'y' / 'No' of 'n'):", function (answer) {
                return answer;
            });
            if (["yes", "y", "no", "n"].includes(answer)) {
                loop = false;
                break;
            }
            this.clearScreen();
            console.log("Invalid answer. Enter 'Yes' or 'y' / 'No' of 'n'");
        }
        rl.close();
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
    let playerName = "";
    console.clear();
    const rl = readline.createInterface({
        input: process.stdin,
        output: process.stdout,
    });
    let loop = true;
    while (loop) {
        playerName = rl.question("What's your name?", function (name) {
            return name.toLowerCase();
        });
        if (playerName !== "") {
            loop = false;
            break;
        }
        console.clear();
        console.log("Invalid name. Please enter at least one character");
    }
    rl.close();
    rl.on("close", function () {
        process.exit(0);
    });
    return playerName;
}
const playerName = enterPlayerName();
const game = new Game(playerName);
game.start();
//# sourceMappingURL=game.js.map