//
// Change user's nickname
//

import Foundation

enum UsersUpdateUser: HTTPAPI {
    static var urlPath = "/users"
    static var httpMethod = HTTP.Method.PATCH

    struct Request: HTTPRequestBody {
        let user_id: String
        let nickname: String?
        let icon_url: String?
    }
    struct Response: HTTPResponseBody {

    }
}
