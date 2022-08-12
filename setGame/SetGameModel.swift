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
  
  init() {
//  init(numberOfPairsOfCards: Int, createCardContent: (Int) -> Shape) {
    cards = Array<Card>()
// do all cases through enums and populate the cards array
    for shape in ShapeOptions.allCases {
      for shading in Shading.allCases {
        for numberOfShapes in Repeats.allCases {
          for colorName in ColorChoice.allCases {
            let card = Card(shape: shape, shading: shading, numberOfShapes: numberOfShapes, colorName: colorName)
            cards.append(card)
          }
        }
      }
    }
    
    print(cards.count)
    
  }
  
  struct Card: Hashable {
    var isSelected: Bool = false
    var isMatched: Bool = false
    var shape: ShapeOptions
    var shading: Shading
    var numberOfShapes: Repeats
    var colorName: ColorChoice
  }
  
  enum ShapeOptions: CaseIterable {
    case diamond
    case rectangle
    case circle
  }
  
  enum Shading: CaseIterable {
    case outline
    case filled
    case shaded
  }
  
  enum Repeats: CaseIterable {
    case single
    case double
    case triple
  }
  
  enum ColorChoice: CaseIterable {
    case redShape
    case yellowShape
    case blueShape
  }
}
