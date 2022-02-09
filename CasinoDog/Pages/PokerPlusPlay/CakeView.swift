//
//
//

import SwiftUI

struct CakeView: View {
    @StateObject var playUiState: PartycakePlayUiState = appState.partycakePlayUi
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image(ImageName.Cake.outer.rawValue)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .rotationEffect(Angle(degrees: playUiState.outerCakeDegree))
                    .shadow(color: Color.black.opacity(0.8), radius: 4, x: 0, y: 0)

                Image(ImageName.Cake.inner.rawValue)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geometry.size.width/1.618)
                    .rotationEffect(Angle(degrees: playUiState.innerCakeDegree))
                    .shadow(color: Color.black.opacity(0.8), radius: 4, x: 0, y: 0)
            }
        }
    }
}
