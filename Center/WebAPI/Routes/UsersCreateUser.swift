//
//
//

import Foundation

enum UsersCreateUser: HTTPAPI {
    static var urlPath = "/users"
    static var httpMethod = HTTP.Method.POST

    struct Request: HTTPRequestBody {
        let nickname: String
        let mail: String
        let drink: Int?
    }
    struct Response: HTTPResponseBody {
        let user: User
    }

    static func run(request: Request) -> Response {
        let drink: DrinkID? = (request.drink != nil) ? DrinkID(rawValue: request.drink!) : nil
        let newUserID = UUID().uuidString
        let chips = initialChip()
        let pockets = initialPockets(drink: drink)
        let user = User(
            id: newUserID,
            mail: request.mail,
            nickname: request.nickname,
            icon_url: "assets://icon-guest",
            chips: chips,
            symbol_pockets: pockets,
            self_intro: "Hello Casino+. I just set up a new account.",
            created_at: Date(),
            updated_at: Date()
        )
        let userRealm = UserConverter().userRealm(user: user)
        UserRepository().create(user: userRealm)
        print("新規ユーザーを作成しました ID: \(newUserID)")
        return Response(user: user)
    }
    
    static func initialChip() -> Int {
        // 初回限定で500チッププレゼント
        return 500
    }
    
    static func initialPockets(drink: DrinkID?) -> [SymbolPocket] {
        // 初回限定で16ポケットプレゼント
        let pocketCount = 16
        let emptyPocket = SymbolPocket(symbol_id: nil, count: 0)
        var pockets = [SymbolPocket].init(repeating: emptyPocket, count: pocketCount)
        if let drink = drink {
            // ドリンクを指定された場合は先頭を置き換える
            pockets[0] = SymbolPocket(symbol_id: drink.symbol.rawValue, count: 1)
        }
        return pockets
    }
}
