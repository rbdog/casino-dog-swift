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

    static func run(request: Request) -> Response {
        let userRealm = UserRepository().read(whereID: request.user_id)
        let user = UserConverter().user(userRealm: userRealm)
        let response = Response(user: user)
        return response
    }
}
