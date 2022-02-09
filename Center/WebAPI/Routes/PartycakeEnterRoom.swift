//
// Join a game room
//

import Foundation

enum PartycakeEnterRoom: HTTPAPI {
    static var urlPath = "/partycake/enter-room"
    static var httpMethod = HTTP.Method.POST

    struct Request: HTTPRequestBody {
        let user_id: String
    }
    struct Response: HTTPResponseBody {
        let error: ErrorModel?
    }

    static func run(request: Request) -> Response {
        let keycard = KeycardRealmRepository().loadKeycard(userId: request.user_id)
        if keycard != nil {
            // すでにプレイヤーIDを持っていた場合
            return Response(error: ServiceError.game004.apiModel)
        }
        // まだプレイヤーIDを持っていない場合
        center.partycakeServer.matcher.entryUser(id: request.user_id)
        
        return Response(error: nil)
    }
}
