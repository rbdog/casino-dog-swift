//
//
//

import SwiftUI

final class MatchingState: ObservableObject, JSONSerializable {
    
    let gameId: GameID
    let seatCount: Int
    @Published var message: String
    @Published var players: [Player]
    
    // カスタムエンコード
    enum CodingKeys: String, CodingKey {
        case gameId
        case seatCount
        case message
        case players
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        gameId = try container.decode(GameID.self, forKey: .gameId)
        seatCount = try container.decode(Int.self, forKey: .seatCount)
        message = try container.decode(String.self, forKey: .message)
        players = try container.decode([Player].self, forKey: .players)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(gameId, forKey: .gameId)
        try container.encode(seatCount, forKey: .seatCount)
        try container.encode(message, forKey: .message)
        try container.encode(players, forKey: .players)
    }
    
    init(gameId: GameID, seatCount: Int, message: String) {
        self.gameId = gameId
        self.seatCount = seatCount
        self.message = message
        self.players = []
    }
}
