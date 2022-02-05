//
//
//

import SwiftUI

struct OnboardingView: View {
    @StateObject var onboarding: OnboardingState = appState.onboarding
    
    var body: some View {
        ZStack {
            NaviWindow(state: appState.routing.onboadingNaviState)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .background(
            Color.plusDarkGreen
                .ignoresSafeArea(.all)
        )
    }
}
