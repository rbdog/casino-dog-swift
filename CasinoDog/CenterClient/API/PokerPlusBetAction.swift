//
// Bet chips
//

enum PokerPlusBetAction: HTTPAPI {
    static var urlPath = "/poker-plus/bet-action"
    static var httpMethod = HTTP.Method.POST

    struct Request: HTTPRequestBody {
        let user_id: String
        let secret_id: String
        let level: Int
    }
    struct Response: HTTPResponseBody {
        let error: ErrorModel?
    }
}
