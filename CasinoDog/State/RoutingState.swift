//
//
//

import SwiftUI

final class RoutingState: ObservableObject, JSONSerializable {
    @Published var baseNaviState: NaviState
    @Published var baseModalState: ModalState
    @Published var homeTabState: TabState
    @Published var onboadingNaviState: NaviState
    
    // カスタムエンコード
    enum CodingKeys: String, CodingKey {
        case baseNaviState
        case baseModalState
        case homeTabState
        case onboadingNaviState
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        baseNaviState = try container.decode(NaviState.self, forKey: .baseNaviState)
        baseModalState = try container.decode(ModalState.self, forKey: .baseModalState)
        homeTabState = try container.decode(TabState.self, forKey: .homeTabState)
        onboadingNaviState = try container.decode(NaviState.self, forKey: .onboadingNaviState)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(baseNaviState, forKey: .baseNaviState)
        try container.encode(baseModalState, forKey: .baseModalState)
        try container.encode(homeTabState, forKey: .homeTabState)
        try container.encode(onboadingNaviState, forKey: .onboadingNaviState)
    }
    
    init() {
        self.baseNaviState = NaviState(stack: [.splash])
        self.baseModalState = ModalState(queue: [])
        self.homeTabState = TabState(selectedId: .profile)
        self.onboadingNaviState = NaviState(stack: [.rollDice])
    }
}
