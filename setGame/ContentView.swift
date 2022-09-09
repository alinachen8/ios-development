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
//    is this work I should do in the VM?
//    let shownCards = viewModel.cards
    let shownCards = viewModel.cards.filter { $0.isShowing == true
    }
    
    VStack{
      Text("Set").font(.largeTitle)
      HStack {
        dealCards
        newGame
      }
    AspectVGrid(items: shownCards, aspectRatio: 2/3, content: { card in
        CardView(card: card)
          .padding(4)
          .onTapGesture {
            viewModel.choose(card)
          }
      })
//        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
//          ForEach(viewModel.cards, id: \.self) { card in
//          }
//        }
        .padding(.horizontal)
    }
  }
  
  var dealCards: some View {
    Button(action: {
      viewModel.dealThreeCards()
    }, label: {
      Text("Deal 3 Cards")
        .padding(4)
        .overlay(
          RoundedRectangle(cornerRadius: 10)
            .stroke(Color.black, lineWidth: 2)
        )
    })
  }
  
  var newGame: some View {
    Button(action: {
      viewModel.newGame()
    }, label: {
      Text("New Game")
        .padding(4)
        .overlay(
          RoundedRectangle(cornerRadius: 10)
            .stroke(Color.black, lineWidth: 2)
        )
    })
  }

}

struct CardView: View {
  
  var card: SetGame.Card
  private let colorDict: [String: Color] = ["blue": .blue, "red": .red, "yellow": .yellow]
  
  var body: some View {
    GeometryReader(content: { geometry in
      ZStack {
        let cardShape = RoundedRectangle(cornerRadius: 20)
        cardShape.fill().foregroundColor(.white)
        cardShape.stroke(lineWidth: 3)
        HStack {
          shapeView(for: card).padding(7)
        }
  //      need to support deselection
        if card.isSelected == true {
          cardShape.foregroundColor(.green).opacity(0.3)
        }
        if card.isMatched == true {
          cardShape.foregroundColor(.white)
        }
      }
    })
  }
  
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
    ForEach(0..<numberOfShapes, id: \.self) { _ in
      chosenShape(shape: card.shape, color: color, opacity: opacity).foregroundColor(color)
    }
  }
}
   
  @ViewBuilder
  func chosenShape(shape: SetGame.ShapeOption, color: Color, opacity: Double) -> some View {
  
    switch shape {
      case .circle:
        Circle().stroke(color, lineWidth: 2).aspectRatio(1/2, contentMode: .fit).background(Circle().fill(color).opacity(opacity))
      case .rectangle:
        Rectangle().strokeBorder(color, lineWidth: 2).aspectRatio(1/2, contentMode: .fit).background(Rectangle().fill(color).opacity(opacity)).aspectRatio(1/2, contentMode: .fit)
      case .diamond:
        Diamond().stroke(color, lineWidth: 2).aspectRatio(1/2, contentMode: .fit).background(Diamond().fill(color).opacity(opacity)).aspectRatio(1/2, contentMode: .fit)
    }
  }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      let game = SetGameViewModel()
      ContentView(viewModel: game).preferredColorScheme(.light)
    }
}
