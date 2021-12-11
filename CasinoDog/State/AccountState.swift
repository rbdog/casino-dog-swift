//
//
//

import SwiftUI

final class AccountState: ObservableObject, JSONSerializable {
    
    // ログイン中のユーザー
    @Published var loginUser: User!
    // ログアウト済みのユーザー
    @Published var logoutUserIDList: [String]
    // 参加中ゲームのキーカード
    var keycard: Keycard?
    
    // カスタムエンコード
    enum CodingKeys: String, CodingKey {
        case loginUser
        case logoutUserIDList
        case keycard
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        loginUser = try container.decode(User?.self, forKey: .loginUser)
        logoutUserIDList = try container.decode([String].self, forKey: .logoutUserIDList)
        keycard = try container.decode(Keycard?.self, forKey: .keycard)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(loginUser, forKey: .loginUser)
        try container.encode(logoutUserIDList, forKey: .logoutUserIDList)
        try container.encode(keycard, forKey: .keycard)
    }
    
    init(loginUser: User? = nil,
         logoutUserIDList: [String] = [],
         keycard: Keycard? = nil) {
        self.loginUser = loginUser
        self.logoutUserIDList = logoutUserIDList
        self.keycard = keycard
    }
}
