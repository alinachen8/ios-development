//
//  SetGameViewModel.swift
//  setGame
//
//  Created by Alina Chen on 8/8/22.
//

import SwiftUI


class SetGameViewModel {
  private var model: SetGame =
    SetGame(numberOfPairsOfCards: 5) { pairIndex in
//      "🫐"
    }
  
  var cards: Array<SetGame.Card> {
    return model.cards
  }
  
}
