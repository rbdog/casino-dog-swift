//
//
//

import Foundation
import SwiftUI
import Center

struct PokerPlusBetController {
    
    func enableBet() {
        DispatchQueue.main.async {
            withAnimation {
                appState.pokerPlusPlayUi.dockBetLevels = [.min, .mid, .max]
            }
            appState.pokerPlusPlayUi.dockIsLocked = false
        }
    }
    
    func bet(level: PokerPlusBetLevel) {
        DispatchQueue.main.async {
            withAnimation {
                appState.pokerPlusPlayUi.dockBetLevels.removeAll(where: {$0 == appState.pokerPlusPlayUi.dockSelectedBetLevel})
            }
            appState.pokerPlusPlayUi.dockSelectedBetLevel = nil
            appState.pokerPlusPlayUi.waitingOthers = true
            appState.pokerPlusPlayUi.dockIsLocked = true
            appState.pokerPlusPlayUi.canExit = false
        }
        
        let userId = appState.account.loginUser.id
        let secretId = appState.account.keycard!.secret_id
        let request = PokerPlusBetAction.Request(
            user_id: userId,
            secret_id: secretId,
            level: level.rawValue
        )

        CenterClient.forLocal.send(
            request,
            to: PokerPlusBetAction.API,
            onReceive: { _ in
                // Bet 完了
                print("Bet 送信に成功しました", self)
            },
            onCatch: { _ in
                fatalError("Bet 送信に失敗しました")
            }
        )
    }
    
    func onTapExit() {
        DispatchQueue.main.async {
            appState.pokerPlusPlayUi.showExitModal = true
        }
    }
    
    func onTapExitYes() {
        // ゲーム退出のリクエスト
        let userId = appState.account.loginUser.id
        let secretId = appState.account.keycard!.secret_id
        let exitGameRequest = PokerPlusExitRoom.Request(user_id: userId, secret_id: secretId)
        CenterClient.forLocal.send(
            exitGameRequest,
            to: PokerPlusExitRoom.API,
            onReceive: { exitGameResponse in
                
                // プレイ中のゲーム情報を破棄
                appState.account.keycard = nil
                
                // WSを解除
                center.pokerPlusServer.speaker.disconnect(userID: appState.account.loginUser.id)
                
                // ホームに戻る
                Router().setBasePages(stack: [.home], animated: false)
            },
            onCatch: { _ in
                fatalError("ゲームの退出に失敗しました")
            }
        )
    }
    
    func onTapExitNo() {
        DispatchQueue.main.async {
            appState.pokerPlusPlayUi.showExitModal = false
        }
    }
    
}
