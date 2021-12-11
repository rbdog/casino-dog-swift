//
//
//

import SwiftUI

struct BetBox: View {
    @StateObject var playUiSide: PokerPlusPlayUiSide
    var body: some View {
        GeometryReader { proxy in
            if playUiSide.playerBetLevel != nil {
                HStack {
                    Circle()
                        .frame(width: proxy.size.height * 0.8, height: proxy.size.height * 0.8)
                        .foregroundColor((playUiSide.playerBetLevel!.cardCount() >= 1) ? .plusGold : .black)
                    Circle()
                        .frame(width: proxy.size.height * 0.8, height: proxy.size.height * 0.8)
                        .foregroundColor((playUiSide.playerBetLevel!.cardCount() >= 2) ? .plusGold : .black)
                    Circle()
                        .frame(width: proxy.size.height * 0.8, height: proxy.size.height * 0.8)
                        .foregroundColor((playUiSide.playerBetLevel!.cardCount() >= 3) ? .plusGold : .black)
                }
                .frame(width: proxy.size.width, height: proxy.size.width)
                .cornerRadius(proxy.size.height/2)
            } else {
                Color.clear
            }
        }
    }
}

// MARK: - ViewState
extension BetBox {
    final class State: ObservableObject {

        @Published var level: Int

        init(level: Int) {
            self.level = level
        }
    }
}
