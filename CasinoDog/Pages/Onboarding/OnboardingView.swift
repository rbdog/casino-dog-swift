//
//
//

import SwiftUI

struct OnboardingView: View {
    @StateObject var onboarding: OnboardingState = appState.onboarding
    let builder = OnboardingNaviBuilder()
    
    var body: some View {
        ZStack {
            NaviWindow(state: appState.routing.onboadingWindowState, builder: builder)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .background(
            Color.plusDarkGreen
                .ignoresSafeArea(.all)
        )
    }
}
