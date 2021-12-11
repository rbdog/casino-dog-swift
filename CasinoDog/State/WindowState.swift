//
//
//

import Foundation
import SwiftUI

final class PageWindowState: ObservableObject, JSONSerializable {
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

final class ModalWindowState: ObservableObject, JSONSerializable {
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

final class TabWindowState: ObservableObject, JSONSerializable {
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
