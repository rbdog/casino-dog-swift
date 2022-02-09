//
// Bet a Card
//

import Foundation

enum PartycakePutAction: HTTPAPI {
    static var urlPath = "/partycake/put-action"
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
