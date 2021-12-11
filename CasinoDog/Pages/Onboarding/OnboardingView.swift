//
//
//

import SwiftUI

struct OnboardingView: View {
    @StateObject var onboarding: OnboardingState = appState.onboarding
    let builder = OnboardingPageBuilder()
    
    var body: some View {
        ZStack {
            PageWindow(state: appState.routing.onboadingWindowState, builder: builder)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .background(
            Color.plusDarkGreen
                .ignoresSafeArea(.all)
        )
    }
}
