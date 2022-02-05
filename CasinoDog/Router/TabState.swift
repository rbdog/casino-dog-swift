//
//
//

import Foundation
import SwiftUI

final class TabState: ObservableObject, JSONSerializable {
    let list: [PageId]
    @Published var selectedId: PageId
    
    // カスタムエンコード
    enum CodingKeys: String, CodingKey {
        case list
        case selectedId
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        list = try container.decode([PageId].self, forKey: .list)
        selectedId = try container.decode(PageId.self, forKey: .selectedId)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(list, forKey: .list)
        try container.encode(selectedId, forKey: .selectedId)
    }
    
    init(list: [PageId], selectedId: PageId) {
        self.list = list
        self.selectedId = selectedId
    }
}
