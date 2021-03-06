//
//
//

import Foundation

struct PartycakeAPIModelBuilder {

    static func maskedState(state: PartycakeState, for seat: PartycakeSeat) -> PartycakeState {
        let hasPuttingPlayer = state.sides.contains(where: {$0.playerStep == .put})
        
        let maskedSides = state.sides.map { side -> PartycakeSide in
            var handCards: [CardId] = []
            if side.seat == seat {
                // 自分の席なら手札を公開
                handCards = side.handCardIds
            }
            var putCard: CardId? = nil
            if let card = side.putCardId {
                // プットカードがある時
                if hasPuttingPlayer {
                    // まだPut中のプレイヤーがいたら裏面だけを返す
                    putCard = .back
                } else {
                    // 全員プットが完了していたら公開する
                    putCard = card
                }
            }
            var maskedSide = side
            maskedSide.handCardIds = handCards
            maskedSide.putCardId = putCard
            return maskedSide
        }

        var maskedState = state
        maskedState.deck = []
        maskedState.sides = maskedSides
        return maskedState
    }
    
    static func players(in state: PartycakeState) -> [Player] {
        var players: [Player] = []
        let keycards = KeycardRealmRepository().loadKeycards(stateId: state.id)
        
        for keycard in keycards {
            let userType = UserType(rawValue: keycard.user_type)!
            switch userType {
            case .human:
                let user = UserRepository().read(whereID: keycard.user_id)
                let player = Player(
                    seat: keycard.seat,
                    user_id: keycard.user_id,
                    nickname: user.nickname,
                    icon_url: user.icon_url
                )
                players.append(player)
            case .bot:
                let allBots = BotUserList().botUsers()
                let bot = allBots.first(where: {$0.userId == keycard.user_id})!
                let player = Player(
                    seat: keycard.seat,
                    user_id: keycard.user_id,
                    nickname: bot.nickname,
                    icon_url: bot.iconUrl
                )
                players.append(player)
            }
        }
        return players
    }
}
