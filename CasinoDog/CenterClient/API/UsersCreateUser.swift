//
//
//

import Foundation

enum UsersCreateUser: HTTPAPI {
    static var urlPath = "/users"
    static var httpMethod = HTTP.Method.POST

    struct Request: HTTPRequestBody {
        let nickname: String
        let mail: String
        let drink: Int?
    }
    struct Response: HTTPResponseBody {
        let user: User
    }
}
