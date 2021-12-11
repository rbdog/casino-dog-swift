//
//
//

import SwiftUI

final class PokerPlusSystemState: ObservableObject, JSONSerializable {
    var pokerPlusState: PokerPlusState
    var players: [Player]
    
    init(pokerPlusState: PokerPlusState,
         players: [Player]) {
        self.pokerPlusState = pokerPlusState
        self.players = players
    }
}
