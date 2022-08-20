//
//  setModel.swift
//  setGame
//
//  Created by Alina Chen on 8/8/22.
//

import Foundation

struct SetGame {
  private(set) var cards: Array<Card>
  
  func chooseSet(selectedCards: [Card]) -> Bool {
    let cardShapes: [ShapeOption] = selectedCards.map { $0.shape }
    if checkIfSet(featureArray: cardShapes) == true {
      let cardShades: [Shading] = selectedCards.map { $0.shading }
      if checkIfSet(featureArray: cardShades) == true {
        let cardColors: [ColorChoice] = selectedCards.map { $0.colorName }
        if checkIfSet(featureArray: cardColors) == true {
          let cardShapeNumber: [Repeats] = selectedCards.map { $0.numberOfShapes }
          if checkIfSet(featureArray: cardShapeNumber) == true {
            print("its a set!!")
            return true
          }
        }
      }
    }
    print("no set :/")
    return false
  }
  
  func checkIfSet<Feature>(featureArray: [Feature]) -> Bool where Feature: Equatable & Hashable {
    let featureSet = Set(featureArray)
    let setLength = featureSet.count
    if setLength == 1 {
      return true
    } else if setLength == featureArray.count {
      return true
    } else {
      return false
    }
  }
  
  init() {
    cards = Array<Card>()
// do all cases through enums and populate the cards array
    for shape in ShapeOption.allCases {
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
  
  struct Card: Equatable, Hashable, Identifiable {
    var isSelected: Bool = false
    var isMatched: Bool = false
    var shape: ShapeOption
    var shading: Shading
    var numberOfShapes: Repeats
    var colorName: ColorChoice
    let id = UUID()
  }
  
  enum ShapeOption: Equatable, CaseIterable, Hashable {
    case diamond
    case rectangle
    case circle
  }
  
  enum Shading: Double, CaseIterable, Hashable {
    case outline
    case filled
    case shaded
  }
  
  enum Repeats: Int, CaseIterable, Hashable {
    case single = 1
    case double = 2
    case triple = 3
  }
  
  enum ColorChoice: String, CaseIterable, Hashable {
    case redShape = "red"
    case yellowShape = "yellow"
    case blueShape = "blue"
  }
}
 
extension SetGame.Repeats: Identifiable {
  var id: RawValue { rawValue }
}
