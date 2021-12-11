//
//
//

import SwiftUI

struct Dock: View {
    @StateObject var playUiState: PokerPlusPlayUiState = appState.pokerPlusPlayUi
    
    func actionLabel() -> (String, Color, Bool) {
        if let card = playUiState.dockSelectedCard {
            return (card.discription, .plusBlue, true)
        }
        if let level = playUiState.dockSelectedBetLevel {
            let canBet = PokerPlusDockController().canBet(level: level)
            if canBet {
                let count = level.cardCount()
                return ("カードを \(count)枚 もらう", .plusBlue, true)
            } else {
                return ("チップが足りません", .plusRed, false)
            }
        }
        return ("未選択", .gray, false)
    }
    
    func cardItem(card: CardID) -> CardView {
        let imageName = card.imageName()
        return CardView(imageName: imageName, degree: 0)
    }
    
    func betLevelItem(level: PokerPlusBetLevel) -> CardView {
        let imageName = level.imageName()
        return CardView(imageName: imageName, degree: 0)
    }
    
    func betButton(width: CGFloat, height: CGFloat) -> some View {
        return Button {
            PokerPlusDockController().onTapBetButton()
        } label: {
            Text(actionLabel().0)
                .font(.system(size: 22))
                .foregroundColor(.white)
                .frame(width: width, height: height)
                .background(actionLabel().1)
                .cornerRadius(14)
        }
    }
    
    func putButton(width: CGFloat, height: CGFloat) -> some View {
        return Button {
            PokerPlusDockController().onTapPutButton()
        } label: {
            Text(actionLabel().0)
                .font(.system(size: 22))
                .foregroundColor(.white)
                .frame(width: width, height: height)
                .background(actionLabel().1)
                .cornerRadius(14)
        }
    }
    
    var body: some View {

        GeometryReader { proxy in
            ZStack {
                HStack(spacing: 12) {
                    ForEach(playUiState.dockHandCards.indices, id: \.self) { index in
                        Button {
                            PokerPlusDockController().onTapCard(card: playUiState.dockHandCards[index])
                        } label: {
                            cardItem(card: playUiState.dockHandCards[index])
                                .blinkEffect(animating: playUiState.dockHandCards[index] == playUiState.dockSelectedCard)
                                .frame(width: proxy.size.height * 0.8, height: proxy.size.height * 0.8)
                                .shadow(color: .black.opacity(0.5), radius: 2, x: 1, y: 1)
                                .border(
                                    (playUiState.dockHandCards[index] == playUiState.dockSelectedCard) ? Color.blue : Color.clear,
                                    width: (playUiState.dockHandCards[index] == playUiState.dockSelectedCard) ? 3 : 0
                                )
                        }
                    }
                    .transition(.scale)
                    ForEach(Array(zip(playUiState.dockBetLevels.indices, playUiState.dockBetLevels)), id: \.1) { index, element in
                        Button {
                            PokerPlusDockController().onTapBetLevel(level: element)
                        } label: {
                            betLevelItem(level: element)
                                .blinkEffect(animating: element == playUiState.dockSelectedBetLevel)
                                .frame(width: proxy.size.height * 0.8, height: proxy.size.height * 0.8)
                                .shadow(color: .black.opacity(0.5), radius: 2, x: 1, y: 1)
                                .border(
                                    (element == playUiState.dockSelectedBetLevel) ? Color.plusBlue : Color.clear,
                                    width: (element == playUiState.dockSelectedBetLevel) ? 3 : 0
                                )
                        }
                    }
                    .transition(.scale)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white.opacity(0.5))
                .cornerRadius(14)
                .shadow(color: .black.opacity(0.5), radius: 2, x: 0, y: 0)
                
                if playUiState.dockSelectedBetLevel != nil {
                    betButton(width: proxy.size.width, height: proxy.size.height * 0.8)
                        .disabled(!actionLabel().2)
                        .offset(x: 0, y: -proxy.size.height)
                }
                if playUiState.dockSelectedCard != nil {
                    putButton(width: proxy.size.width, height: proxy.size.height * 0.8)
                        .disabled(!actionLabel().2)
                        .offset(x: 0, y: -proxy.size.height)
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }

    }
}
