//
//
//

import SwiftUI

final class RoutingState: ObservableObject, JSONSerializable {
    @Published var basePageWindowState: PageWindowState
    @Published var baseModalWindowState: ModalWindowState
    @Published var homeTabWindowState: TabWindowState
    @Published var onboadingWindowState: PageWindowState
    
    // カスタムエンコード
    enum CodingKeys: String, CodingKey {
        case basePageWindowState
        case baseModalWindowState
        case homeTabWindowState
        case onboadingWindowState
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        basePageWindowState = try container.decode(PageWindowState.self, forKey: .basePageWindowState)
        baseModalWindowState = try container.decode(ModalWindowState.self, forKey: .baseModalWindowState)
        homeTabWindowState = try container.decode(TabWindowState.self, forKey: .homeTabWindowState)
        onboadingWindowState = try container.decode(PageWindowState.self, forKey: .onboadingWindowState)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(basePageWindowState, forKey: .basePageWindowState)
        try container.encode(baseModalWindowState, forKey: .baseModalWindowState)
        try container.encode(homeTabWindowState, forKey: .homeTabWindowState)
        try container.encode(onboadingWindowState, forKey: .onboadingWindowState)
    }
    
    init() {
        self.basePageWindowState = PageWindowState(stack: [.splash])
        self.baseModalWindowState = ModalWindowState(queue: [])
        self.homeTabWindowState = TabWindowState(list: [.profile, .gameList, .slotList], selectedId: .profile)
        self.onboadingWindowState = PageWindowState(stack: [.rollDice])
    }
}
