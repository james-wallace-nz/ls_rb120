"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Card = exports.Deck = void 0;
const _ = require("lodash");
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
exports.Deck = Deck;
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
exports.Card = Card;
//# sourceMappingURL=deckAndCards.js.map