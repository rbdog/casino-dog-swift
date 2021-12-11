//
// See the game state
//

import Foundation

enum PokerPlusLoadRoom: HTTPAPI {
    static var urlPath = "/poker-plus/load-room"
    static var httpMethod = HTTP.Method.GET

    struct Request: HTTPRequestBody {
        let user_id: String
        let secret_id: String
    }
    struct Response: HTTPResponseBody {
        let state: PokerPlusState
        let players: [Player]
    }
}
