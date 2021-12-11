//
//
//

import SwiftUI

final class GameListState: ObservableObject, JSONSerializable {
    @Published var gameIDList: [GameID]
    @Published var selectedGameID: GameID
    @Published var chipCount: Int
    
    // カスタムエンコード
    enum CodingKeys: String, CodingKey {
        case gameIDList
        case selectedGameID
        case chipCount
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        gameIDList = try container.decode([GameID].self, forKey: .gameIDList)
        selectedGameID = try container.decode(GameID.self, forKey: .selectedGameID)
        chipCount = try container.decode(Int.self, forKey: .chipCount)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(gameIDList, forKey: .gameIDList)
        try container.encode(selectedGameID, forKey: .selectedGameID)
        try container.encode(chipCount, forKey: .chipCount)
    }
    
    init(gameIDList: [GameID] = [.pokerPlus],
         selectedGameID: GameID = .pokerPlus,
         chipCount: Int = 50) {
        self.gameIDList = gameIDList
        self.selectedGameID = selectedGameID
        self.chipCount = chipCount
    }
}