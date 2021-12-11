//
//
//

import SwiftUI

struct SymbolCollectionView: View {
    let pockets: [SymbolPocket]
    
    let columns: [GridItem] = Array(repeating: .init(spacing: 1), count: 2)
    
    func symbolBackColor(at index: Int) -> Color {
        return (((index + 1)/2) % 2) == 0 ? .plusBlack : .plusRed
    }
    
    func itemSize(proxyHeight: CGFloat) -> CGFloat {
        return proxyHeight * 0.5 - 1
    }
    
    var body: some View {
        
        GeometryReader { proxy in
            ScrollView(.horizontal) {
                LazyHGrid(rows: columns, spacing: 2) {
                    ForEach(0..<pockets.count) { index in
                        // ポケット
                        ZStack {
                            if let symbolId = pockets[index].symbol_id {
                                Image(Symbol(rawValue: symbolId)!.imageName.rawValue)
                                    .resizable()
                                    .renderingMode(.template)
                                    .shine(.gold)
                                    .aspectRatio(contentMode: .fit)
                                    .padding(itemSize(proxyHeight: proxy.size.height) * 0.2)
                            }
                            VStack {
                                HStack {
                                    Spacer()
                                    if pockets[index].count >= 2 {
                                        Text("\(pockets[index].count)")
                                            .foregroundColor(.black)
                                            .frame(width: 20, height: 20)
                                            .background(Color.white)
                                            .cornerRadius(10)
                                            .padding(8)
                                    }
                                }
                                Spacer()
                            }
                        }
                        .frame(
                            width: itemSize(proxyHeight: proxy.size.height),
                            height: itemSize(proxyHeight: proxy.size.height)
                        )
                        .background(symbolBackColor(at: index))
                    }
                }
            }
            .background(Color.plusGold.shine(.gold))
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.plusGold, lineWidth: 2)
            )
        }
    }
}

extension SymbolCollectionView {
    class State: ObservableObject {
        @Published var symbolPockets: [SymbolPocket]
        
        init(symbolPockets: [SymbolPocket]) {
            self.symbolPockets = symbolPockets
        }
    }
}
