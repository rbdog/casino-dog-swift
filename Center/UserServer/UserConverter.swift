//
//
//

import Foundation

struct UserConverter {
    func userRealm(user: User) -> UserRealm {
        let encoder = JSONEncoder()
        guard let pocketsData = try? encoder.encode(user.symbol_pockets) else {
            fatalError("JOSNエンコードに失敗しました")
        }
        let pockets =  String(data: pocketsData, encoding: .utf8)!
        let userRealm = UserRealm(
            id: user.id,
            createdAt: user.created_at,
            updatedAt: user.updated_at,
            mail: user.mail,
            nickname: user.nickname,
            chip: user.chips,
            iconURL: user.icon_url,
            selfIntro: user.self_intro,
            symbol_pockets: pockets
        )
        return userRealm
    }
    
    func user(userRealm: UserRealm) -> User {
        let pocketsData = userRealm.symbol_pockets.data(using: .utf8)!
        let decoder = JSONDecoder()
        guard let pockets: [SymbolPocket] = try? decoder.decode([SymbolPocket].self, from: pocketsData) else {
           fatalError("JOSNデコードに失敗しました")
        }
        let user = User(
            id: userRealm.id,
            mail: userRealm.mail,
            nickname: userRealm.nickname,
            icon_url: userRealm.icon_url,
            chips: userRealm.chip,
            symbol_pockets: pockets,
            self_intro: userRealm.self_intro,
            created_at: userRealm.created_at,
            updated_at: userRealm.updated_at
        )
        return user
    }
}
