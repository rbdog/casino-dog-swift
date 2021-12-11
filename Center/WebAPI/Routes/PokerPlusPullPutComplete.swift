//
//
//

import Foundation

enum PokerPlusPullPutComplete: HTTPAPI {
    static var urlPath = "/poker-plus/pull-put-complete"
    static var httpMethod = HTTP.Method.GET

    struct Request: HTTPRequestBody {
    }
    struct Response: HTTPResponseBody {
    }

    static func run(request: Request) -> Response {
        fatalError("未実装")
    }
}
