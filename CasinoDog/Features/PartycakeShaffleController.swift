//
//
//

import Foundation
import SwiftUI
import Center

struct PartycakeShaffleController {
    func startShuffle(with announce: PartycakeAnnounce) {
        
        let duration: Double = 0.5
        
        DispatchQueue.main.async {
            for i in 0..<appState.partycakePlayUi.sides.count {
                let uiSide = appState.partycakePlayUi.sides[i]
                
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
                for i in 0..<appState.partycakePlayUi.sides.count {
                    appState.partycakePlayUi.sides[i].putCard = nil
                }
                // Dockをからにする
                appState.partycakePlayUi.dockBetLevels.removeAll()
                // 配られたカードを Dock にセット
                let myUserId = appState.account.loginUser.id
                let mySeat = announce.players!.first(where: {$0.user_id == myUserId})!.seat
                let handCards = announce.masked_state!.sides.first(where: {$0.seat.rawValue == mySeat})!.handCardIds
                appState.partycakePlayUi.dockHandCards = handCards
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            PartycakeEventController().didShuffle()
        }
    }
}
