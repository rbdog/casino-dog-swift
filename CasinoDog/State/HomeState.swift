//
//
//

import SwiftUI

final class HomeState: ObservableObject, JSONSerializable {
    @Published var showMenu: Bool = false
    
    // カスタムエンコード
    enum CodingKeys: String, CodingKey {
        case showMenu
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        showMenu = try container.decode(Bool.self, forKey: .showMenu)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(showMenu, forKey: .showMenu)
    }
    init() {}
}
