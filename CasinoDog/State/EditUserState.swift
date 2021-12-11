//
//
//

import SwiftUI

final class EditUserState: ObservableObject, JSONSerializable {
    
    @Published var mode: EditUserMode = .noEditting
    @Published var nickname: String = ""
    @Published var iconURL: String = ""
    
    // カスタムエンコード
    enum CodingKeys: String, CodingKey {
        case mode
        case nickname
        case iconURL
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        mode = try container.decode(EditUserMode.self, forKey: .mode)
        nickname = try container.decode(String.self, forKey: .nickname)
        iconURL = try container.decode(String.self, forKey: .iconURL)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(mode, forKey: .mode)
        try container.encode(nickname, forKey: .nickname)
        try container.encode(iconURL, forKey: .iconURL)
    }
    
    init(mode: EditUserMode = .noEditting,
         nickname: String = "",
         iconURL: String = "") {
        self.mode = mode
        self.nickname = nickname
        self.iconURL = iconURL
    }
}
