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
  
 fileprivate func shapeView(for card: SetGame.Card) -> some View {
  let numberOfShapes: Int = card.numberOfShapes.rawValue
  let color = colorDict[card.colorName.rawValue]!
  let opacity: Double
  
  switch card.shading {
    case .outline: opacity = 0
    case .shaded: opacity = 0.4
    case .filled: opacity = 1.0
  }
  
  return HStack {
    ForEach(0..<numberOfShapes) { _ in
      chosenShape(shape: card.shape, color: color, opacity: opacity).foregroundColor(color)
    }
  }
  }
   
  @ViewBuilder
  func chosenShape(shape: SetGame.ShapeOption, color: Color, opacity: Double) -> some View {
  
    switch shape {
      case .circle:
        Circle().stroke(color, lineWidth: 2).aspectRatio(1/2, contentMode: .fit).background(Circle().fill(color).opacity(opacity)).padding(7)
      case .rectangle:
        Rectangle().strokeBorder(Color.purple, lineWidth: 2).aspectRatio(1/2, contentMode: .fit).background(Rectangle().fill(color).opacity(0.5)).aspectRatio(1/2, contentMode: .fit).padding(7)
      case .diamond:
        Diamond().stroke(color, lineWidth: 2).aspectRatio(1/2, contentMode: .fit).background(Diamond().fill(color).opacity(opacity)).aspectRatio(1/2, contentMode: .fit).padding(7)
    }
  }
  
  var body: some View {
    ZStack {
      let cardShape = RoundedRectangle(cornerRadius: 20)
      cardShape.fill().foregroundColor(.white)
      cardShape.stroke(lineWidth: 3)
      
      HStack {
        shapeView(for: card)
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      let game = SetGameViewModel()
      ContentView(viewModel: game).preferredColorScheme(.light)
    }
}
