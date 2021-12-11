//
//
//

import SwiftUI

struct WheelView: View {
    @StateObject var playUiState: PokerPlusPlayUiState = appState.pokerPlusPlayUi
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image(ImageName.Wheel.outer.rawValue)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .rotationEffect(Angle(degrees: playUiState.outerWheelDegree))
                    .shadow(color: Color.black.opacity(0.8), radius: 4, x: 0, y: 0)

                Image(ImageName.Wheel.inner.rawValue)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geometry.size.width/1.618)
                    .rotationEffect(Angle(degrees: playUiState.innerWheelDegree))
                    .shadow(color: Color.black.opacity(0.8), radius: 4, x: 0, y: 0)
            }
        }
    }
}
