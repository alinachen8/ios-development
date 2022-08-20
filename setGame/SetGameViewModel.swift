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
  
  var chosenArray: Array<Card> = []
  
  //  MARK: - Intent(s)
  
  func choose(_ card: Card) {
    chosenArray.append(card)
    print("hi")
    if chosenArray.count == 3 {
      model.chooseSet(selectedCards: chosenArray)
    }
  }
  
}
