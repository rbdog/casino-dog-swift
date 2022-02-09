//
//
//

import Foundation

enum PartycakePullPutAction: HTTPAPI {
    static var urlPath = "/partycake/pull-put-action"
    static var httpMethod = HTTP.Method.GET

    struct Request: HTTPRequestBody {
    }
    struct Response: HTTPResponseBody {
    }
}
