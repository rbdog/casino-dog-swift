//
//
//

import Foundation
import SwiftUI
import Center

struct PokerPlusShaffleController {
    func startShuffle(with announce: PokerPlusAPIModel.Announce) {
        
        let duration: Double = 0.5
        
        DispatchQueue.main.async {
            for i in 0..<appState.pokerPlusPlayUi.sides.count {
                let uiSide = appState.pokerPlusPlayUi.sides[i]
                
                // 決定された BetLevel, 増減した Chips を UI表示
                let systemSide = announce.masked_state!.sides.first(where: {$0.seat == uiSide.seat})!
                uiSide.playerBetLevel = systemSide.betLevel
                uiSide.chips = systemSide.chips
                
                // プレイヤーの名前, アイコン を表示
                let player = announce.players!.first(where: {$0.seat == uiSide.seat.rawValue})!
                uiSide.playerNickname = player.nickname
                uiSide.playerIconUrl = player.icon_url
            }
            
            withAnimation(.linear(duration: duration)) {
                // PutBoxを空にする
                for i in 0..<appState.pokerPlusPlayUi.sides.count {
                    appState.pokerPlusPlayUi.sides[i].putCard = nil
                }
                // Dockをからにする
                appState.pokerPlusPlayUi.dockBetLevels.removeAll()
                // 配られたカードを Dock にセット
                let myUserId = appState.account.loginUser.id
                let mySeat = announce.players!.first(where: {$0.user_id == myUserId})!.seat
                let handCards = announce.masked_state!.sides.first(where: {$0.seat.rawValue == mySeat})!.handCardIds
                appState.pokerPlusPlayUi.dockHandCards = handCards
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            PokerPlusEventController().didShuffle()
        }
    }
}
