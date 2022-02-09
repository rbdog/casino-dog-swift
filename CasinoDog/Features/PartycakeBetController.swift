//
//
//

import Foundation
import SwiftUI
import Center

struct PartycakeBetController {
    
    func enableBet() {
        DispatchQueue.main.async {
            withAnimation {
                appState.partycakePlayUi.dockBetLevels = [.min, .mid, .max]
            }
            appState.partycakePlayUi.dockIsLocked = false
        }
    }
    
    func bet(level: PartycakeBetLevel) {
        DispatchQueue.main.async {
            withAnimation {
                appState.partycakePlayUi.dockBetLevels.removeAll(where: {$0 == appState.partycakePlayUi.dockSelectedBetLevel})
            }
            appState.partycakePlayUi.dockSelectedBetLevel = nil
            appState.partycakePlayUi.waitingOthers = true
            appState.partycakePlayUi.dockIsLocked = true
            appState.partycakePlayUi.canExit = false
        }
        
        let userId = appState.account.loginUser.id
        let secretId = appState.account.keycard!.secret_id
        let request = PartycakeBetAction.Request(
            user_id: userId,
            secret_id: secretId,
            level: level.rawValue
        )

        CenterClient.forLocal.send(
            request,
            to: PartycakeBetAction.API,
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
            appState.partycakePlayUi.showExitModal = true
        }
    }
    
    func onTapExitYes() {
        // ゲーム退出のリクエスト
        let userId = appState.account.loginUser.id
        let secretId = appState.account.keycard!.secret_id
        let exitGameRequest = PartycakeExitRoom.Request(user_id: userId, secret_id: secretId)
        CenterClient.forLocal.send(
            exitGameRequest,
            to: PartycakeExitRoom.API,
            onReceive: { exitGameResponse in
                
                // プレイ中のゲーム情報を破棄
                appState.account.keycard = nil
                
                // WSを解除
                center.partycakeServer.speaker.disconnect(userID: appState.account.loginUser.id)
                
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
            appState.partycakePlayUi.showExitModal = false
        }
    }
    
}
