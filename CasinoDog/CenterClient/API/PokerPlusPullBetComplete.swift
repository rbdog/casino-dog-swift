//
//
//

import Foundation

enum PokerPlusPullBetComplete: HTTPAPI {
    static var urlPath = "/poker-plus/pull-bet-complete"
    static var httpMethod = HTTP.Method.GET

    struct Request: HTTPRequestBody {
    }
    struct Response: HTTPResponseBody {
    }
}