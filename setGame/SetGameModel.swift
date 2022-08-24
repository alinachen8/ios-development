//
//  setModel.swift
//  setGame
//
//  Created by Alina Chen on 8/8/22.
//

import Foundation

struct SetGame {
  private(set) var cards: Array<Card>
//  need to make this a set
  var chosenCardsSet: Set<Card> = []
  var chosenCardsIndexArray: [Int] = []
  var matchedSetsArray: Array<Card> = []

  mutating func chooseCard(selectedCard: Card) {
//    need to make it so you can't select the same card twice
    if let chosenCardIndex = cards.firstIndex(where: { $0.id == selectedCard.id}) {
      print("chosen card index: \(chosenCardIndex)")
      cards[chosenCardIndex].isSelected.toggle()
      if cards[chosenCardIndex].isSelected == true {
        chosenCardsSet.insert(selectedCard)
        chosenCardsIndexArray.append(chosenCardIndex)
        if chosenCardsSet.count == 3 {
          var setArray = Array(chosenCardsSet)
          chosenCardsSet.removeAll()
//          move conditions and code for if set/not set here
          if chooseSet(selectedCards: setArray, selectedCardsIndices: chosenCardsIndexArray) == true {
            for index in 0..<setArray.count {
//            need to eventually remove cards from array/view so number of cards decreases
              cards[chosenCardsIndexArray[index]].isMatched = true
            }
          } else {
            for index in 0..<setArray.count {
              cards[chosenCardsIndexArray[index]].isSelected = false
            }
          }
          chosenCardsIndexArray = []
          setArray = []
          chosenCardsSet.removeAll()
        }
      }
    }
  }
  
  mutating func chooseSet(selectedCards: [Card], selectedCardsIndices: [Int]) -> Bool {
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
