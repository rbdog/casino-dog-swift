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

    static func run(request: Request) -> Response {
        fatalError("未実装")
    }
}
