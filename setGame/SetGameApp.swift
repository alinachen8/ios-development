//
//  SetGameApp.swift
//  setGame
//
//  Created by Alina Chen on 8/5/22.
//

import SwiftUI

@main
struct SetGameApp: App {
  let game = SetGameViewModel()
  
  var body: some Scene {
      WindowGroup {
          ContentView(viewModel: game)
      }
  }
}
