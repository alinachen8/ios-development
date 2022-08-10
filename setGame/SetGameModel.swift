//
//  setModel.swift
//  setGame
//
//  Created by Alina Chen on 8/8/22.
//

import Foundation

struct SetGame {
  private(set) var cards: Array<Card>
  
  func chooseSet(_ card: Card) {
    
  }
  
  init(numberOfPairsOfCards: Int, createCardContent: (Int) -> Shape) {
    cards = Array<Card>()
    for pairIndex in 0..<numberOfPairsOfCards {
      let content: Shape = createCardContent(pairIndex)
//      cards.append(Card(content: content))
//      cards.append(Card(content: content))
    }
  }
  
  struct Card {
    var isSelected: Bool = false
    var isMatched: Bool = false
    var shape: Shape
    var shading: Shading
    var numberOfShapes: Repeats
    var colorName: ColorChoice
  }
  
  enum Shape: CaseIterable {
    case triangle
    case rectangle
    case circle
  }
  
  enum Shading: CaseIterable {
    case outline
    case filled
    case shaded
  }
  
  enum Repeats {
    case single
    case double
    case triple
  }
  
  enum ColorChoice {
    case redShape
    case yellowShape
    case blueShape
  }
}
