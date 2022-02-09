//
//
//

import SwiftUI

final class PartycakeSystemState: ObservableObject, JSONSerializable {
    var partycakeState: PartycakeState
    var players: [Player]
    
    init(partycakeState: PartycakeState,
         players: [Player]) {
        self.partycakeState = partycakeState
        self.players = players
    }
}
