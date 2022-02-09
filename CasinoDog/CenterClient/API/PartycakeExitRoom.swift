//
// Exit the game room
//

import Foundation

enum PartycakeExitRoom: HTTPAPI {
    static var urlPath = "/partycake/exit-room"
    static var httpMethod = HTTP.Method.POST

    struct Request: HTTPRequestBody {
        let user_id: String
        let secret_id: String
    }
    struct Response: HTTPResponseBody {
        let error: ErrorModel?
    }
}
