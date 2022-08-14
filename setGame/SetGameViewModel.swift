//
//  SetGameViewModel.swift
//  setGame
//
//  Created by Alina Chen on 8/8/22.
//

import SwiftUI


class SetGameViewModel: ObservableObject {
  private var model: SetGame = SetGame()
  typealias Card = SetGame.Card
  
  var cards: Array<SetGame.Card> {
    return model.cards
  }
//
  
}
