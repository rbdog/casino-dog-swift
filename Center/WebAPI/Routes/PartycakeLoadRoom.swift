//
// See the game state
//

import Foundation

enum PartycakeLoadRoom: HTTPAPI {
    static var urlPath = "/partycake/load-room"
    static var httpMethod = HTTP.Method.GET

    struct Request: HTTPRequestBody {
        let user_id: String
        let secret_id: String
    }
    struct Response: HTTPResponseBody {
        let state: PartycakeState
        let players: [Player]
    }

    static func run(request: Request) -> Response {
        let keycard = KeycardRealmRepository().loadKeycard(userId: request.user_id, secretId: request.secret_id)
        let state = PartycakeStateRepositoryImpl().loadState(id: keycard.state_id)
        let players = PartycakeAPIModelBuilder.players(in: state)
        let seat = PartycakeSeat(rawValue: keycard.seat)!
        let maskedState = PartycakeAPIModelBuilder.maskedState(state: state, for: seat)
        return Response(state: maskedState, players: players)
    }
}
