//
//
//

import Foundation

struct PokerPlusPlayUiStateBuilder {
    
    // プロパティ単位で変更の通知がいかないので、State丸ごとのセットは初期化時のみ有効
    func playUiState(from systemState: PokerPlusSystemState) -> PokerPlusPlayUiState {
        let myUserId = appState.account.loginUser.id
        let mySeat = systemState.players.first(where: {$0.user_id == myUserId})?.seat
        let mySide = systemState.pokerPlusState.sides.first(where: {$0.seat.rawValue == mySeat})!
        
        let playUiState = PokerPlusPlayUiState()
        playUiState.innerWheelDegree = Double(systemState.pokerPlusState.wheel.innerOffset * 90)
        playUiState.outerWheelDegree = Double(systemState.pokerPlusState.wheel.outerOffset * 90)
        playUiState.dockHandCards = mySide.handCardIds
        playUiState.dockBetLevels = (mySide.playerStep == .bet) ? [.min, .mid, .max] : []
        
        let uiSides = systemState.players.map { player -> PokerPlusPlayUiSide in
            let systemSide = systemState.pokerPlusState.sides.first(where: {$0.seat.rawValue == player.seat})!
            let uiSide = PokerPlusPlayUiSide(
                seat: PokerPlusSeat(rawValue: player.seat)!
            )
            uiSide.playerNickname = player.nickname
            uiSide.playerIconUrl = player.icon_url
            uiSide.playerBetLevel = systemSide.betLevel
            uiSide.chips = systemSide.chips
            uiSide.putCard = systemSide.putCardId
            
            if systemState.pokerPlusState.dealerStep == .waitingBet {
                // Bet中なら表向き
                uiSide.putCardDegree = 0
            } else {
                uiSide.putCardDegree = 180
            }
            return uiSide
        }
        
        playUiState.sides = uiSides
        return playUiState
    }
}
