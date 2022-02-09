//
//
//

import SwiftUI

final class GameListState: ObservableObject, JSONSerializable {
    @Published var selectedGameID: GameId
    
    // カスタムエンコード
    enum CodingKeys: String, CodingKey {
        case selectedGameID
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        selectedGameID = try container.decode(GameId.self, forKey: .selectedGameID)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(selectedGameID, forKey: .selectedGameID)
    }
    
    init(selectedGameID: GameId = .partycake) {
        self.selectedGameID = selectedGameID
    }
}
