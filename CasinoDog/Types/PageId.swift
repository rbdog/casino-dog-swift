//
//
//

import Foundation

// 画面としてカウントするViewのID
enum PageId: Int, JSONSerializable {
    case splash = 1
    case onboarding = 2
    case rollDice = 3
    case receiveDrink = 4
    case home = 5
    case profile = 6
    case gameList = 7
    case slotList = 8
    case matching = 9
    case pokerPlusPlay = 10
    case pokerPlusScore = 11
    case slot = 12
    case developerMessage = 13
    case lisense = 14
    case termsOfService = 15
    case debug = 16
}
