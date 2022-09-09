//
//  AspectVGrid.swift
//  setGame
//
//  Created by Alina Chen on 8/23/22.
//

import SwiftUI

struct AspectVGrid<Item, ItemView>: View where ItemView: View, Item: Identifiable{
  var items: [Item]
  var aspectRatio: CGFloat
  var content: (Item) -> ItemView
  
  var body: some View {
    GeometryReader { geometry in
      if items.count > 15 {
        let width: CGFloat = widthThatFits(itemCount: 15, in: geometry.size, itemAspectRatio: aspectRatio)
        ScrollView {
          LazyVGrid(columns: [adaptiveGridItem(width: width)], spacing: 0) {
            ForEach(items) { item in
              content(item).aspectRatio(aspectRatio, contentMode: .fit)
            }
          }
        }
      } else {
        let width: CGFloat = widthThatFits(itemCount: items.count, in: geometry.size, itemAspectRatio: aspectRatio)
        LazyVGrid(columns: [adaptiveGridItem(width: width)], spacing: 0) {
          ForEach(items) { item in
            content(item).aspectRatio(aspectRatio, contentMode: .fit)
          }
        }
      }
      
    }
  }
  
  private func adaptiveGridItem(width: CGFloat) -> GridItem {
    var gridItem = GridItem(.adaptive(minimum: width))
    gridItem.spacing = 0
    return gridItem
  }
  
  private func widthThatFits(itemCount: Int, in size: CGSize, itemAspectRatio: CGFloat) -> CGFloat {
    var columnCount = 1
    var rowCount = itemCount
    repeat {
      let itemWidth = size.width / CGFloat(columnCount)
      let itemHeight = itemWidth / itemAspectRatio
      if CGFloat(rowCount) * itemHeight < size.height {
        break
      }
      columnCount += 1
      rowCount = (itemCount + (columnCount - 1)) / columnCount
    } while columnCount < itemCount
    if columnCount > itemCount {
      columnCount = itemCount
    }
    return floor(size.width / CGFloat(columnCount))
  }
}

//struct AspectVGrid_Previews: PreviewProvider {
//    static var previews: some View {
//        AspectVGrid()
//    }
//}
