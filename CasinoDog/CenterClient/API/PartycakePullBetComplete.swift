//
//
//

import Foundation

enum PartycakePullBetComplete: HTTPAPI {
    static var urlPath = "/partycake/pull-bet-complete"
    static var httpMethod = HTTP.Method.GET

    struct Request: HTTPRequestBody {
    }
    struct Response: HTTPResponseBody {
    }
}
