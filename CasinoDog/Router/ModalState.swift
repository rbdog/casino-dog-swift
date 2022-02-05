//
//
//

import Foundation
import SwiftUI

final class ModalState: ObservableObject, JSONSerializable {
    @Published var queue: [ModalId]
    
    // カスタムエンコード
    enum CodingKeys: String, CodingKey {
        case queue
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        queue = try container.decode([ModalId].self, forKey: .queue)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(queue, forKey: .queue)
    }
    
    init(queue: [ModalId]) {
        self.queue = queue
    }
}
