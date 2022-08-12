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
//            ForEach(emojis[0..<emojiCount], id: \.self) { emoji in
//              CardView(content: emoji).aspectRatio(2/3, contentMode:.fit)
//            }
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
    var body: some View {
      ZStack {
        let shape = RoundedRectangle(cornerRadius: 20)
        shape.fill().foregroundColor(.white)
        shape.stroke(lineWidth: 3)
//        put a switch here for view 
//        Diamond.stroke().foregroundColor(.green).padding(5)
        switch card.shape {
          case .diamond:
            Diamond().stroke().foregroundColor(.green).padding(5)
          case .rectangle:
            Rectangle().stroke().foregroundColor(.green).padding(5)
          case .circle:
            Circle().stroke().foregroundColor(.green).padding(5)
        }
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
