//
// See the game state
//

import Foundation

enum PokerPlusLoadRoom: HTTPAPI {
    static var urlPath = "/poker-plus/load-room"
    static var httpMethod = HTTP.Method.GET

    struct Request: HTTPRequestBody {
        let user_id: String
        let secret_id: String
    }
    struct Response: HTTPResponseBody {
        let state: PokerPlusState
        let players: [Player]
    }

    static func run(request: Request) -> Response {
        let keycard = KeycardRealmRepository().loadKeycard(userId: request.user_id, secretId: request.secret_id)
        let state = PokerPlusStateRepositoryImpl().loadState(id: keycard.state_id)
        let players = PokerPlusAPIModelBuilder.players(in: state)
        let seat = PokerPlusSeat(rawValue: keycard.seat)!
        let maskedState = PokerPlusAPIModelBuilder.maskedState(state: state, for: seat)
        return Response(state: maskedState, players: players)
    }
}
