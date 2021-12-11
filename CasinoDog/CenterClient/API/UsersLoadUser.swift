//
//
//

import Foundation

enum UsersLoadUser: HTTPAPI {
    static var urlPath = "/users"
    static var httpMethod = HTTP.Method.GET

    struct Request: HTTPRequestBody {
        let user_id: String
    }
    struct Response: HTTPResponseBody {
        let user: User
    }
}
