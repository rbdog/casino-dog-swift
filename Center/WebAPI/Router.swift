//
//
//

import Foundation

// エラー: 不明なエラーです
// エラー: そのプレイヤーIDはルームに参加していません
// エラー: 要求とステップが合いません
// エラー: 同時に参加できるルーム数の限界に達しています
// エラー: 既に選択済みです

// "/api.casinoplus.xxx/"
public class Router {

    public init() {}

    public func route(_ method: String,
                      _ endpoint: String,
                      request: Data) -> Data {

        switch (method, endpoint) {

        case (PokerPlusLoadRoom.httpMethod.rawValue, PokerPlusLoadRoom.urlPath):
            return PokerPlusLoadRoom.response(to: request)

        case (PokerPlusEnterRoom.httpMethod.rawValue, PokerPlusEnterRoom.urlPath):
            return PokerPlusEnterRoom.response(to: request)

        case (PokerPlusBetAction.httpMethod.rawValue, PokerPlusBetAction.urlPath):
            return PokerPlusBetAction.response(to: request)

        case (PokerPlusPutAction.httpMethod.rawValue, PokerPlusPutAction.urlPath):
            return PokerPlusPutAction.response(to: request)

        case (UsersUpdateUser.httpMethod.rawValue, UsersUpdateUser.urlPath):
            return UsersUpdateUser.response(to: request)

        case (UsersCreateUser.httpMethod.rawValue, UsersCreateUser.urlPath):
            return UsersCreateUser.response(to: request)

        case (PokerPlusExitRoom.httpMethod.rawValue, PokerPlusExitRoom.urlPath):
            return PokerPlusExitRoom.response(to: request)
            
        case (UsersLoadUser.httpMethod.rawValue, UsersLoadUser.urlPath):
            return UsersLoadUser.response(to: request)
            
        case (SlotsSpinSlot.httpMethod.rawValue, SlotsSpinSlot.urlPath):
            return SlotsSpinSlot.response(to: request)
            
        default:
            // FIXME: - 404 エラー
            fatalError("404 URL: \(endpoint) Method: \(method)")
        }
    }
}
