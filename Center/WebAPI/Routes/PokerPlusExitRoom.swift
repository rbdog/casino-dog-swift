//
// Exit the game room
//

import Foundation

enum PokerPlusExitRoom: HTTPAPI {
    static var urlPath = "/poker-plus/exit-room"
    static var httpMethod = HTTP.Method.POST
    
    struct Request: HTTPRequestBody {
        let user_id: String
        let secret_id: String
    }
    struct Response: HTTPResponseBody {
        let error: ErrorModel?
    }
    
    static func run(request: Request) -> Response {
        // 退出するユーザーのキーカード
        let keycard = KeycardRealmRepository().loadKeycard(userId: request.user_id, secretId: request.secret_id)
        // 参加中のルームステート
        let state = PokerPlusStateRepositoryImpl().loadState(id: keycard.state_id)
        let keycards = KeycardRealmRepository().loadKeycards(stateId: state.id)
        
        // 送金
        let userType = UserType(rawValue: keycard.user_type)!
        switch userType {
        case .human:
            
            // 退出するプレイヤーのチップを、ユーザーに送金
            let side = state.sides.first(where: {$0.seat.rawValue == keycard.seat})!
            let user = UserRepository().read(whereID: request.user_id)
            let payedUser = UserRealm(
                id: user.id,
                createdAt: user.created_at,
                updatedAt: user.updated_at,
                mail: user.mail,
                nickname: user.nickname,
                chip: user.chip + side.chips,
                iconURL: user.icon_url,
                selfIntro: user.self_intro,
                symbol_pockets: user.symbol_pockets
            )
            // DBを更新
            UserRepository().saveUsers([payedUser])
            
        case .bot:
            // botを停止
            center.pokerPlusServer.state.activeBots.first(where: {$0.userId == keycard.user_id})?.unlistenSpeaker()
            center.pokerPlusServer.state.activeBots.removeAll(where: {$0.userId == keycard.user_id})
            break
        }
        
        // TODO: - この間にLoadStateされると、ひとり欠けているので、エラーを追加して対応する
        // 今はアクセスできません...とか
        let announce = PokerPlusAPIModel.Announce(
            announce_type: PokerPlusAPIModel.AnnounceType.playerExit.rawValue,
            masked_state: nil,
            players: nil,
            trigger_seat: keycard.seat,
            showdown_list: nil,
            score_list: nil,
            published_keycard: nil
        )
        let userIds = keycards.map{$0.user_id}
        center.pokerPlusServer.speaker.speak(to: userIds, announce: announce)
        
        // 退出者以外のキーカード
        let otherKeycards = keycards.filter({$0.user_id != keycard.user_id})
        if !otherKeycards.contains(where: {$0.user_type == UserType.human.rawValue}) {
            // 残ったプレイヤーに人間が含まれていなかった場合
            // 起動中のロボットを削除
            for otherKeycard in otherKeycards {
                if otherKeycard.user_type == UserType.bot.rawValue {
                    // WebSocket停止
                    center.pokerPlusServer.state.activeBots.first(where: {$0.userId == otherKeycard.user_id})?.unlistenSpeaker()
                    center.pokerPlusServer.state.activeBots.removeAll(where: {$0.userId == otherKeycard.user_id})
                }
            }
            // 関連するキーカードを全て削除
            KeycardRealmRepository().deleteKeycards(stateId: state.id)
            
            return Response(error: nil)
        } else {
            // まだ人間が残っている場合
            // 代わりに入るボットユーザー
            let botUserID = avairableBotUserId(in: state.id)
            
            // 新しいキーカード
            let newKeycard = KeycardRealm(
                _id: UUID().uuidString,
                gameID: GameID.pokerPlus.rawValue,
                userID: botUserID,
                userType: UserType.bot.rawValue,
                stateID: keycard.state_id,
                seat: keycard.seat
            )
            
            // 新しいState
            // State のチップを 27 に設定
            let oldSide = state.sides.first(where: {$0.seat.rawValue == keycard.seat})!
            var newSides: [PokerPlusSide] = []
            var newSide = oldSide
            newSide.chips = 27
            newSide.lastCombo = .start
            for side in state.sides {
                if side.seat == newSide.seat {
                    newSides.append(newSide)
                } else {
                    newSides.append(side)
                }
            }
            var newState = state
            newState.sides = newSides
            // DBを更新
            KeycardRealmRepository().deleteKeycard(userId: request.user_id, secretId: request.secret_id)
            KeycardRealmRepository().saveKeycards([newKeycard])
            PokerPlusStateRepositoryImpl().saveState(newState)
            
            // 新しいロボをActivate
            center.pokerPlusServer.activateBots(keycards: [newKeycard])
            // ベットを開始させる
            center.pokerPlusServer.state.activeBots
                .first(where: {$0.userId == newKeycard.user_id})?
                .startBet(at: PokerPlusSeat(rawValue: newKeycard.seat)!, in: newState)
            
            let enterAnnounce = PokerPlusAPIModel.Announce(
                announce_type: PokerPlusAPIModel.AnnounceType.playerEnter.rawValue,
                masked_state: nil,
                players: nil,
                trigger_seat: oldSide.seat.rawValue,
                showdown_list: nil,
                score_list: nil,
                published_keycard: nil
            )
            center.pokerPlusServer.speaker.speak(to: otherKeycards.map{$0.user_id} + [newKeycard.user_id], announce: enterAnnounce)
            
            return Response(error: nil)
        }
    }
    
    // ゲームに参加していないボットのID
    static func avairableBotUserId(in stateId: String) -> String {
        let keycards = KeycardRealmRepository().loadKeycards(stateId: stateId)
        let unavairableBotIds = keycards.map{$0.user_id}
        let allBotIds = BotUserList().botUsers().map{$0.userId}
        for botId in allBotIds {
            if unavairableBotIds.contains(botId) {
                continue
            } else {
                // ゲームに参加していないボットが見つかった
                return botId
            }
        }
        fatalError("ボットが足りません")
    }
}
