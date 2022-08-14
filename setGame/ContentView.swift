//
//  ContentView.swift
//  setGame
//
//  Created by Alina Chen on 8/5/22.
//

import SwiftUI

struct ContentView: View {
  @ObservedObject var viewModel: SetGameViewModel
  var emojis:[String] = ["🥯", "🍳", "🍛","🧉","🥮", "🍑", "🫐", "🥑", "🍱", "🧋", "🎢", "🚗", "🚂", "🚃", "🚄", "🚅", "🚆", "🚇", "🚈", "🚉", "🚊", "🚝", "🚞", "🚋", "🚌"]
  //  var shapes = (Circle(), Rectangle(), Diamond())
  @State var emojiCount = 12
  var body: some View {
    ScrollView {
      VStack{
        Text("Set").font(.largeTitle)
        dealCards
        LazyVGrid(columns: [GridItem(), GridItem(), GridItem()], content: {
          ForEach(viewModel.cards, id: \.self) { card in
            
            CardView(card: card).aspectRatio(2/3, contentMode: .fit)
          }
        }).padding(.horizontal)
        Spacer()
      }
    }
  }
  
//  @ViewBuilder
  private func cardView(for card: SetGameViewModel.Card) -> some View {
//    var shape = Circle()
//    switch card.numberOfShapes {
//      case .single: return 1
//      case .double: return 2
//      case .triple: return 3
//    }
    
//    switch card.shape {
//      case .diamond:
//        Diamond()
//      case .rectangle:
//        Rectangle()
//      case .circle:
//        Circle()
//    }
//    CardView(card: card)
    Circle()
  }
  
  var dealCards: some View {
    Button(action: {
      if emojiCount < emojis.count {
        emojiCount += 3
      }
    }, label: {
      Text("Deal 3 Cards")
        .padding(4)
        .overlay(
          RoundedRectangle(cornerRadius: 10)
            .stroke(Color.black, lineWidth: 2)
          //              .background(Color.white)
          //              .opacity(0.5)
        )
    })
  }
}

struct CardView: View {
  var card: SetGame.Card
  private let colorDict: [String: Color] = ["blue": .blue, "red": .red, "yellow": .yellow]
//  var opacity: Double
//
//  switch card.shading {
//    case .outline: opacity = 0
//    case .shaded: opacity = 0.5
//    case .filled: opacity = 1
//  }
  fileprivate func diamondView(for card: SetGame.Card) -> some View {
    let numberOfShapes: Int = card.numberOfShapes.rawValue
    return HStack {
      ForEach(0..<numberOfShapes) { _ in
        Diamond().opacity(0.5).foregroundColor(colorDict[card.colorName.rawValue])
      }
    }
  }
//    switch card.numberOfShapes {
//      case .single:
//        Diamond().opacity(0.5).foregroundColor(colorDict[card.colorName.rawValue])
//      case .double:
//        HStack {
//          Diamond().opacity(0.5).foregroundColor(colorDict[card.colorName.rawValue])
//          Diamond().opacity(0.5).foregroundColor(colorDict[card.colorName.rawValue])
//        }
//      case .triple:
//        Diamond().opacity(0.5).foregroundColor(colorDict[card.colorName.rawValue])
//
//    }
  
  var body: some View {
    ZStack {
      let cardShape = RoundedRectangle(cornerRadius: 20)
      cardShape.fill().foregroundColor(.white)
      cardShape.stroke(lineWidth: 3)
      
      //        put a switch here for view
      //        Diamond.stroke().foregroundColor(.green).padding(5)
//      HStack {
//        var i = 0
//        repeat {
//          Diamond()
//        } while(i <= card.numberOfShapes)
//      }
//
//      switch card.numberOfShapes {
//        case .single: return 1
//        case .double: return 2
//        case .triple: return 3
//      }
//      switch card.shading {
//        case .outline: print("hi")
//        case .filled:
//
//      }
      
      HStack {
        diamondView(for: card)
      }.aspectRatio(1/2, contentMode: .fit)
      
      //        Text(shapeContent).font(.largeTitle)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      let game = SetGameViewModel()
      ContentView(viewModel: game).preferredColorScheme(.light)
    }
}
