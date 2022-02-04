//
// Put a Card
//

import Foundation
import RealmSwift

enum PokerPlusPutAction: HTTPAPI {
    static var urlPath = "/poker-plus/put-action"
    static var httpMethod = HTTP.Method.POST

    struct Request: HTTPRequestBody {
        let user_id: String
        let secret_id: String
        let card_id: Int
    }
    struct Response: HTTPResponseBody {
        let error: ErrorModel?
    }
    
    static func run(request: Request) -> Response {
        guard let card = CardId(rawValue: request.card_id) else {
            return Response(error: ServiceError.game005.apiModel)
        }
        center.pokerPlusServer.putAction(card: card, userId: request.user_id, secretId: request.secret_id)
        
        return Response(error: nil)
    }
}
