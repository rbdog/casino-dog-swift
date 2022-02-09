//
//
//

import Foundation

struct PartycakePlayUiStateBuilder {
    
    // プロパティ単位で変更の通知がいかないので、State丸ごとのセットは初期化時のみ有効
    func playUiState(from systemState: PartycakeSystemState) -> PartycakePlayUiState {
        let myUserId = appState.account.loginUser.id
        let mySeat = systemState.players.first(where: {$0.user_id == myUserId})?.seat
        let mySide = systemState.partycakeState.sides.first(where: {$0.seat.rawValue == mySeat})!
        
        let playUiState = PartycakePlayUiState()
        playUiState.innerCakeDegree = Double(systemState.partycakeState.innerOffset * 90)
        playUiState.outerCakeDegree = Double(systemState.partycakeState.outerOffset * 90)
        playUiState.dockHandCards = mySide.handCardIds
        playUiState.dockBetLevels = (mySide.playerStep == .bet) ? [.min, .mid, .max] : []
        
        let uiSides = systemState.players.map { player -> PartycakePlayUiSide in
            let systemSide = systemState.partycakeState.sides.first(where: {$0.seat.rawValue == player.seat})!
            let uiSide = PartycakePlayUiSide(
                seat: PartycakeSeat(rawValue: player.seat)!
            )
            uiSide.playerNickname = player.nickname
            uiSide.playerIconUrl = player.icon_url
            uiSide.playerBetLevel = systemSide.betLevel
            uiSide.chips = systemSide.chips
            uiSide.putCard = systemSide.putCardId
            
            if systemState.partycakeState.dealerStep == .waitingBet {
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
