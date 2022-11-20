/* eslint-disable */
const _ = require("lodash");

import { Participant } from './participants'

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

export { Deck, Card }