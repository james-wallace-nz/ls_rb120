import readlineSync from "readline-sync";
/* eslint-disable */
const _ = require("lodash");
require("lodash.permutations");

import Game from './game'
import { Card } from './deckAndCards'
import { Move } from './types'

function userInput(question: string): string {
  return readlineSync.question(question);
}

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

export { Participant, Player, Dealer }
