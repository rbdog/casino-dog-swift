//
//
//

import Foundation
import UIKit

class MatchingUser {
    var timer: Timer?
    var maxBotCount: Int = 0
    let timeInterval: TimeInterval = 2
    let userId: String
    
    init(userId: String) {
        self.userId = userId
    }
    
    func startTimer() {
        center.partycakeServer.matcher.onUserChangeMaxBotCount()
        timer = Timer.scheduledTimer(
            withTimeInterval: timeInterval,
            repeats: true
        ) { t in
            self.maxBotCount += 1
            center.partycakeServer.matcher.onUserChangeMaxBotCount()
        }
    }
}

/// マッチメイキングする
class PartycakeMatcher {
    
    let userRepository: UserRepository
    let stateRepository: PartycakeStateRepository
    let keycardRepository: KeycardRealmRepository
    
    init(userRepository: UserRepository,
         stateRepository: PartycakeStateRepository,
         keycardRepository: KeycardRealmRepository) {
        self.userRepository = userRepository
        self.stateRepository = stateRepository
        self.keycardRepository = keycardRepository
    }
    
    func entryUser(id: String) {
        let matchingUser = MatchingUser(userId: id)
        center.partycakeServer.state.matchingUsers.append(matchingUser)
        matchingUser.startTimer()
    }
    
    func onUserChangeMaxBotCount() {
        var minAvairableUserCount = 4
        for botCount in 0...3 {
            var availableUsers: [MatchingUser] = []
            availableUsers = center.partycakeServer.state.matchingUsers.filter({$0.maxBotCount >= botCount})
            if availableUsers.count >= minAvairableUserCount {
                didCpmpleteAvailableUsers(users: availableUsers)
                break
            } else {
                minAvairableUserCount -= 1
            }
        }
    }
    
    func didCpmpleteAvailableUsers(users: [MatchingUser]) {
        print("マッチングユーザーがそろいました")
        for user in users {
            print("ID: \(user.userId), 最大ボット数: \(user.maxBotCount) まで許容")
        }
        // マッチング用のタイマー停止
        for user in users{
            user.timer?.invalidate()
            user.timer = nil
            center.partycakeServer.state.matchingUsers.removeAll(where: {$0.userId == user.userId})
        }
        // プレイコストを支払ったユーザーたち
        let willPayUsers = userRepository.read(whereIDs: users.map{$0.userId})
        let payedUsers = usersPayPlayCost(users: willPayUsers)
        // State を作成
        let state = PartycakeRule.initialState
        // キーカード配列
        var keycards: [KeycardRealm] = []
        
        let count = users.count
        switch count {
        case 1:
            // ユーザーが1人の場合は 3 番目におく
            let keycard = KeycardRealm(
                _id: UUID().uuidString,
                gameID: GameId.partycake.rawValue,
                userID: payedUsers.first!.id,
                userType: UserType.human.rawValue,
                stateID: state.id,
                seat: PartycakeSeat.s3.rawValue
            )
            keycards = [keycard]
            
        case _ where count > 1 && count < 4:
            // 存在する分だけでキーカードを作成
            let sides = PartycakeRule.initialSides
            for i in 0..<payedUsers.count {
                let side = sides[i]
                let payedUser = payedUsers[i]
                let keycard = KeycardRealm(
                    _id: UUID().uuidString,
                    gameID: GameId.partycake.rawValue,
                    userID: payedUser.id,
                    userType: UserType.human.rawValue,
                    stateID: state.id,
                    seat: side.seat.rawValue
                )
                keycards.append(keycard)
            }
        case 4:
            // 存在する分だけでキーカードを作成
            let sides = PartycakeRule.initialSides
            for i in 0..<payedUsers.count {
                let side = sides[i]
                let payedUser = payedUsers[i]
                let keycard = KeycardRealm(
                    _id: UUID().uuidString,
                    gameID: GameId.partycake.rawValue,
                    userID: payedUser.id,
                    userType: UserType.human.rawValue,
                    stateID: state.id,
                    seat: side.seat.rawValue
                )
                keycards.append(keycard)
            }
        case _ where count > 4:
            fatalError("予期せぬ人数がマッチしました")
        default:
            fatalError()
        }
        
        keycards = enoughKeycards(stateId: state.id, lessKeycards: keycards)
        
        // DB保存
        userRepository.saveUsers(payedUsers)
        stateRepository.saveState(state)
        keycardRepository.saveKeycards(keycards)
        
        // ボットを起動
        center.partycakeServer.activateBots(keycards: keycards)
        
        // アナウンス
        for keycardRealm in keycards {
            // マッチング完了
            let type = PartycakeAnnounceId.matchComplete.rawValue
            let state = PartycakeStateRepositoryImpl().loadState(id: keycardRealm.state_id)
            let players = PartycakeAPIModelBuilder.players(in: state)
            let keycard = KeycardConverter().keycard(keycardRealm: keycardRealm)
            let announce = PartycakeAnnounce(
                announce_type: type,
                masked_state: state,
                players: players,
                trigger_seat: nil,
                showdown_list: nil,
                score_list: nil,
                published_keycard: keycard
            )
            // WebSocket
            center.partycakeServer.speaker.speak(to: [keycard.user_id], announce: announce)
        }
    }
    
    func usersPayPlayCost(users: [UserRealm]) -> [UserRealm] {
        // MARK: - 参加料 30chip, 3chip は運営のマージン
        // 参加料
        let playCost = 30
        let payedUsers = users.map { user -> UserRealm in
            if user.chip < playCost {
                fatalError("参加料が足りません")
            }
            let payedUser = UserRealm(
                id: user.id,
                createdAt: user.created_at,
                updatedAt: user.updated_at,
                mail: user.mail,
                nickname: user.nickname,
                chip: user.chip - playCost,
                iconURL: user.icon_url,
                selfIntro: user.self_intro,
                symbol_pockets: user.symbol_pockets
            )
            return payedUser
        }
        return payedUsers
    }
    
    // 足りない分をbotで補ったキーカード配列
    func enoughKeycards(stateId: String, lessKeycards: [KeycardRealm]) -> [KeycardRealm] {
        var keycards: [KeycardRealm] = lessKeycards
        let sides = PartycakeRule.initialSides
        // 候補になるボットたち
        var botUsers = BotUserList().botUsers().shuffled().prefix(sides.count)
        for i in 0..<sides.count {
            let side = sides[i]
            if lessKeycards.contains(where: {$0.seat == side.seat.rawValue}) {
                // すでに存在しているときはスルー
                continue
            } else {
                // まだ存在しない場合は新しいキーカードで補う
                let user = botUsers.first!
                botUsers = botUsers.dropFirst()
                let keycard = KeycardRealm(
                    _id: UUID().uuidString,
                    gameID: GameId.partycake.rawValue,
                    userID: user.userId,
                    userType: UserType.bot.rawValue,
                    stateID: stateId,
                    seat: side.seat.rawValue
                )
                keycards.append(keycard)
            }
        }
        return keycards
    }
}
