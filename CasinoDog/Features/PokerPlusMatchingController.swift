//
//
//

import Foundation
import SwiftUI
import Center

class PokerPlusMatchingController {
    
    func onMatchingViewAppear() {
        let myNickname = appState.account.loginUser.nickname
        let myIconUrl = appState.account.loginUser.icon_url
        appState.matching.players = [
            Player(seat: 0, user_id: "", nickname: myNickname, icon_url: myIconUrl)
        ]        
        // EnterRoom リクエスト
        let req = PokerPlusEnterRoom.Request(user_id: appState.account.loginUser.id)
        CenterClient.forLocal.send(
            req,
            to: PokerPlusEnterRoom.API,
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
    func onMatchComplete(announce: PokerPlusAnnounce) {
        // プレイヤーをUIへ表示
        appState.matching.message = "ゲームを開始します"
        appState.matching.players = announce.players!
        
        // 参加中のゲームを端末に保存
        Task {
            appState.account.keycard = announce.published_keycard!
            await StorageManager().saveAccountState()
            
            // Stateの作成
            let pokerPlusSystemState = PokerPlusSystemState(
                pokerPlusState: announce.masked_state!,
                players: announce.players!
            )
            appState.pokerPlusSystem = pokerPlusSystemState
            // UIStateの作成
            let pokerPlusPlayUiState = PokerPlusPlayUiStateBuilder().playUiState(from: pokerPlusSystemState)
            appState.pokerPlusPlayUi = pokerPlusPlayUiState
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                // ゲーム画面へ遷移
                Router().setBasePages(stack: [.pokerPlusPlay])
            }
        }
    }
}
