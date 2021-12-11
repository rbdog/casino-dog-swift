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

    static func run(request: Request) -> Response {
        let userRealm = UserRepository().read(whereID: request.user_id)
        let user = UserConverter().user(userRealm: userRealm)
        var updatedUser = user
        updatedUser.nickname = request.nickname ?? user.nickname
        updatedUser.icon_url = request.icon_url ?? user.icon_url
        let updatedUserRealm = UserConverter().userRealm(user: updatedUser)
        UserRepository().update(user: updatedUserRealm)
        return Response()
    }
}
