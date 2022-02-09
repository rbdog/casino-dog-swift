//
// See the game state
//

import Foundation

enum PartycakeLoadRoom: HTTPAPI {
    static var urlPath = "/partycake/load-room"
    static var httpMethod = HTTP.Method.GET

    struct Request: HTTPRequestBody {
        let user_id: String
        let secret_id: String
    }
    struct Response: HTTPResponseBody {
        let state: PartycakeState
        let players: [Player]
    }
}
