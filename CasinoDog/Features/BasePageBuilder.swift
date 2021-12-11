//
//
//

import Foundation
import SwiftUI

struct BasePageBuilder: PageBuilder {
   
    func emptyView() -> AnyView {
        return AnyView(
            RelaunchView()
        )
    }
    
    func contentView(_ id: PageId) -> some View {
        return Group {
            switch id {
            case .splash:
                SplashView()
            case .onboarding:
                OnboardingView()
            case .rollDice:
                fatalError("無効なページです")
            case .receiveDrink:
                fatalError("無効なページです")
            case .home:
                HomeView()
            case .profile:
                fatalError("無効なページです")
            case .gameList:
                fatalError("無効なページです")
            case .slotList:
                fatalError("無効なページです")
            case .matching:
                MatchingView()
            case .pokerPlusPlay:
                PokerPlusPlayView()
            case .pokerPlusScore:
                fatalError("無効なページです")
            case .slot:
                SlotView()
            case .developerMessage:
                DeveloperMessageView()
            case .lisense:
                LisenceView()
            case .termsOfService:
                TermsOfServiceView()
            case .debug:
                DebugView()
            }
        }
    }
}
