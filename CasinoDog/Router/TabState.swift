//
//
//

import Foundation
import SwiftUI

final class TabState: ObservableObject, JSONSerializable {
    @Published var selectedId: PageId
    
    // カスタムエンコード
    enum CodingKeys: String, CodingKey {
        case selectedId
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        selectedId = try container.decode(PageId.self, forKey: .selectedId)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(selectedId, forKey: .selectedId)
    }
    
    init(selectedId: PageId) {
        self.selectedId = selectedId
    }
}
