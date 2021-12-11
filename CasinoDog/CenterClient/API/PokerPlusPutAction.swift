//
// Bet a Card
//

import Foundation

enum PokerPlusPutAction: HTTPAPI {
    static var urlPath = "/poker-plus/put-action"
    static var httpMethod = HTTP.Method.POST

    struct Request: HTTPRequestBody {
        let user_id: String
        let secret_id: String
        let card_id: Int
    }
    struct Response: HTTPResponseBody {
        let error: ErrorModel?
    }
}
