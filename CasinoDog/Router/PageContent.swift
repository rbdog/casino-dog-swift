//
//
//

import Foundation
import SwiftUI

struct PageContent: View {
    let id: PageId
    
    var body: some View {
        return Group {
            switch id {
            case .splash:
                SplashView()
            case .onboarding:
                OnboardingView()
            case .rollDice:
                RollDiceView()
            case .receiveDrink:
                ReceiveDrinkView()
            case .home:
                HomeView()
            case .profile:
                ProfileView()
            case .gameList:
                GameListView()
            case .slotList:
                SlotListView()
            case .matching:
                MatchingView()
            case .pokerPlusPlay:
                PokerPlusPlayView()
            case .pokerPlusScore:
                ScoreListView()
            case .slot:
                SlotView()
            case .developerMessage:
                DeveloperMessageView()
            case .license:
                LicenseView()
            case .termsOfService:
                TermsOfServiceView()
            case .debug:
                DebugView()
            }
        }
    }
}
