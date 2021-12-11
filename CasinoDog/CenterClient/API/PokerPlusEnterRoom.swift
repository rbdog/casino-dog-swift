//
// Join a game room
//

import Foundation

enum PokerPlusEnterRoom: HTTPAPI {
    static var urlPath = "/poker-plus/enter-room"
    static var httpMethod = HTTP.Method.POST

    struct Request: HTTPRequestBody {
        let user_id: String
    }
    struct Response: HTTPResponseBody {
        let error: ErrorModel?
    }
}
