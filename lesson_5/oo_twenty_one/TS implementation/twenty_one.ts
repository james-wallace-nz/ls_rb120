type Participant = {
  name: string
  hand: Card[]
  handValues: number[]
}

class participant: Participant {
  this.name: string = undefined
  #this.hand: Card[] = undefined
  #this.handValues: number[] = undefined

  constructor(name) {
    this.newhand()
    this.name = name
    this.hand_values = []
  }

  function newHand() {
    this.hand = []
    this.handValues = determineHandValues()
  }

}

class player extends participant {

}

class dealer extends participant {



}