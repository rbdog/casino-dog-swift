//
//
//

import SwiftUI

struct RelaunchView: View {
    var body: some View {
        ZStack {
            Image(ImageName.Splash.splash.rawValue)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .background(
            Color.plusRed
                .ignoresSafeArea(.all)
        )
    }
}
