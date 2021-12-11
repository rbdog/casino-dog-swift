//
//
//

import Foundation

enum ServiceError: Error {
    /// プレイヤーが不足
    case game001(playerCount: Int)
    /// すでにルーム退出済み
    case game002
    /// 参加料チップが不足
    case game003
    /// すでにルーム参加済み
    case game004
    /// 無効なカード
    case game005
    /// 無効なベットレベル
    case game006
    /// 無効なスロットを指定
    case slot001
    /// アクションのためのチップが不足
    case slot002
    
    var code: String {
        switch self {
        case .game001:
            return "Game001"
        case .game002:
            return "Game002"
        case .game003:
            return "Game003"
        case .game004:
            return "Game004"
        case .game005:
            return "Game005"
        case .game006:
            return "Game006"
        case .slot001:
            return "Slot001"
        case .slot002:
            return "Slot002"
        }
    }
    
    var message: String {
        switch self {
        case .game001(let playerCount):
            return "プレイヤーが不足しています 現在のプレイヤー数: \(playerCount)"
        case .game002:
            return "アクションしたプレイヤーはゲームに参加していません"
        case .game003:
            return "参加料のチップが足りません"
        case .game004:
            return "すでに別のルームに参加しています"
        case .game005:
            return "無効なカードを指定しました"
        case .game006:
            return "無効なベットレベルを指定しました"
        case .slot001:
            return "無効なスロットが指定されました"
        case .slot002:
            return "チップが足りません"
        }
    }
}

extension ServiceError {
    var apiModel: ErrorModel {
        print("サービスエラー \(self.code) \(self.message)")
        return .init(code: self.code, message: self.message)
    }
}
