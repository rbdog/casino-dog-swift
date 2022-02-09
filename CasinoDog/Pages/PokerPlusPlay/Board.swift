//
//
//

import SwiftUI
import Center

struct Board: View {
    @StateObject var playUiState: PartycakePlayUiState = appState.partycakePlayUi
    
    func uiSide(at seat: PartycakeSeat) -> PartycakePlayUiSide {
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

                    // Cake
                    CakeView()
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
