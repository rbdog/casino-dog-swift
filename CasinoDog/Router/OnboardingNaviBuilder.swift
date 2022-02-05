//
//
//

import Foundation
import SwiftUI

struct OnboardingNaviBuilder: NaviBuilder {
   
    func emptyView() -> AnyView {
        fatalError("Viewが見つかりません")
    }
    
    func contentView(_ id: PageId) -> some View {
        return Group {
            switch id {
            case .rollDice:
                RollDiceView()
            case .receiveDrink:
                ReceiveDrinkView()
            default:
                fatalError("無効なページです")
            }
        }
    }
}
