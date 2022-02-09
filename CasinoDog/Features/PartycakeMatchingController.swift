//
//
//

import Foundation
import SwiftUI
import Center

class PartycakeMatchingController {
    
    func onMatchingViewAppear() {
        let myNickname = appState.account.loginUser.nickname
        let myIconUrl = appState.account.loginUser.icon_url
        appState.matching.players = [
            Player(seat: 0, user_id: "", nickname: myNickname, icon_url: myIconUrl)
        ]        
        // EnterRoom リクエスト
        let req = PartycakeEnterRoom.Request(user_id: appState.account.loginUser.id)
        CenterClient.forLocal.send(
            req,
            to: PartycakeEnterRoom.API,
            onReceive: { res in
                
                if let err = res.error {
                    fatalError("\(err.code): \(err.message)")
                }
                
                // 接続成功時は待つだけなので何もしない
            },
            onCatch: {_ in
                fatalError("EnterRoomに失敗")
            }
        )
    }
    
    // マッチング完了
    func onMatchComplete(announce: PartycakeAnnounce) {
        // プレイヤーをUIへ表示
        appState.matching.message = "ゲームを開始します"
        appState.matching.players = announce.players!
        
        // 参加中のゲームを端末に保存
        Task {
            appState.account.keycard = announce.published_keycard!
            await StorageManager().saveAccountState()
            
            // Stateの作成
            let partycakeSystemState = PartycakeSystemState(
                partycakeState: announce.masked_state!,
                players: announce.players!
            )
            appState.partycakeSystem = partycakeSystemState
            // UIStateの作成
            let partycakePlayUiState = PartycakePlayUiStateBuilder().playUiState(from: partycakeSystemState)
            appState.partycakePlayUi = partycakePlayUiState
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                // ゲーム画面へ遷移
                Router().setBasePages(stack: [.partycakePlay])
            }
        }
    }
}
