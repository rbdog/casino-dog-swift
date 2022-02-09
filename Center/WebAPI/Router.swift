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

        case (PartycakeLoadRoom.httpMethod.rawValue, PartycakeLoadRoom.urlPath):
            return PartycakeLoadRoom.response(to: request)

        case (PartycakeEnterRoom.httpMethod.rawValue, PartycakeEnterRoom.urlPath):
            return PartycakeEnterRoom.response(to: request)

        case (PartycakeBetAction.httpMethod.rawValue, PartycakeBetAction.urlPath):
            return PartycakeBetAction.response(to: request)

        case (PartycakePutAction.httpMethod.rawValue, PartycakePutAction.urlPath):
            return PartycakePutAction.response(to: request)

        case (UsersUpdateUser.httpMethod.rawValue, UsersUpdateUser.urlPath):
            return UsersUpdateUser.response(to: request)

        case (UsersCreateUser.httpMethod.rawValue, UsersCreateUser.urlPath):
            return UsersCreateUser.response(to: request)

        case (PartycakeExitRoom.httpMethod.rawValue, PartycakeExitRoom.urlPath):
            return PartycakeExitRoom.response(to: request)
            
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
