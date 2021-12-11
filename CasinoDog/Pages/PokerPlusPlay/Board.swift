//
//
//

import SwiftUI
import Center

struct Board: View {
    @StateObject var playUiState: PokerPlusPlayUiState = appState.pokerPlusPlayUi
    
    func uiSide(at seat: PokerPlusSeat) -> PokerPlusPlayUiSide {
        let side = playUiState.sides.first(where: {$0.seat == seat})!
        return side
    }

    var body: some View {

        ZStack {

            GeometryReader { proxy in
                VStack {

                    Spacer()

                    HStack {
                        PutBox(playUiSide: uiSide(at: .s4))
                            .frame(width: proxy.size.width * 0.25)
                        Spacer()
                        PutBox(playUiSide: uiSide(at: .s1))
                            .frame(width: proxy.size.width * 0.25)
                    }

                    // Wheel
                    WheelView()
                        .frame(width: proxy.size.width * 0.9, height: proxy.size.width * 0.9)

                    HStack {
                        PutBox(playUiSide: uiSide(at: .s3))
                            .frame(width: proxy.size.width * 0.25)
                        Spacer()
                        PutBox(playUiSide: uiSide(at: .s2))
                            .frame(width: proxy.size.width * 0.25)
                    }
                    
                    Spacer()
                }
            }
            .padding()
            
            EffectView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
