//
//
//

import Foundation
import SwiftUI

final class NaviState: ObservableObject, JSONSerializable {
    @Published var stack: [PageId]
    
    // カスタムエンコード
    enum CodingKeys: String, CodingKey {
        case stack
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        stack = try container.decode([PageId].self, forKey: .stack)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(stack, forKey: .stack)
    }
    
    init(stack: [PageId]) {
        self.stack = stack
    }
}
