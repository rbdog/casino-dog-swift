//
// Bet chips
//

enum PartycakeBetAction: HTTPAPI {
    static var urlPath = "/partycake/bet-action"
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
