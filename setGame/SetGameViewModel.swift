//
//  SetGameViewModel.swift
//  setGame
//
//  Created by Alina Chen on 8/8/22.
//

import SwiftUI


class SetGameViewModel: ObservableObject {
  @Published private var model: SetGame = SetGame()
  typealias Card = SetGame.Card
  
  var cards: Array<Card> {
    return model.cards
  }
  
//  var shownCards = cards[0..<16]
  
//  var chosenArray: Array<Card> = []

  //  MARK: - Intent(s)
  
  func choose(_ card: Card) {
    model.chooseCard(selectedCard: card)
  }
  
  func dealThreeCards() {
    model.dealThreeCards()
  }
  
  func newGame() {
    model.newGame()
  }
  
}

extension Array {
  func split(numberOfElements: Int, cardArray: Array<Element>) -> ArraySlice<Element> {
    let newSplitArray = cardArray[0..<numberOfElements]
    return newSplitArray
  }
}
