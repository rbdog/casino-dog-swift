//
// Join a game room
//

import Foundation

enum PartycakeEnterRoom: HTTPAPI {
    static var urlPath = "/partycake/enter-room"
    static var httpMethod = HTTP.Method.POST

    struct Request: HTTPRequestBody {
        let user_id: String
    }
    struct Response: HTTPResponseBody {
        let error: ErrorModel?
    }
}
