//
//
//

import SwiftUI

struct PutBox: View {
    @StateObject var playUiSide: PokerPlusPlayUiSide
    
    func inoutEdge() -> Edge {
        if playUiSide.seat == .s1 || playUiSide.seat == .s2 {
            return .trailing
        } else {
            return .leading
        }
    }
    
    var body: some View {
        ZStack {
            Image(ImageName.Card.pokerPlusPutBox.rawValue)
                .resizable()
                .aspectRatio(contentMode: .fit)
            if let card = playUiSide.putCard {
                CardView(imageName: card.imageName(), degree: playUiSide.putCardDegree)
                    .transition(.move(edge: inoutEdge()))
            }
            // else で EmptyView を返すと transition がなくなるので注意
        }
        .shadow(color: Color.black.opacity(0.6), radius: 2, x: 1, y: 1)
    }
}
