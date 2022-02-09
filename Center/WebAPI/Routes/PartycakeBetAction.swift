//
// Bet chips
//

import Foundation

enum PartycakeBetAction: HTTPAPI {
    static var urlPath = "/partycake/bet-action"
    static var httpMethod = HTTP.Method.POST

    struct Request: HTTPRequestBody {
        let user_id: String
        let secret_id: String
        let level: Int
    }
    struct Response: HTTPResponseBody {
        let error: ErrorModel?
    }

    static func run(request: Request) -> Response {
        guard let level = PartycakeBetLevel(rawValue: request.level) else {
            return Response(error: ServiceError.game006.apiModel)
        }
        center.partycakeServer.betAction(level: level, userId: request.user_id, secretId: request.secret_id)
        
        return Response(error: nil)
    }
}
