//
// Exit the game room
//

import Foundation

enum PokerPlusExitRoom: HTTPAPI {
    static var urlPath = "/poker-plus/exit-room"
    static var httpMethod = HTTP.Method.POST

    struct Request: HTTPRequestBody {
        let user_id: String
        let secret_id: String
    }
    struct Response: HTTPResponseBody {
        let error: ErrorModel?
    }
}
