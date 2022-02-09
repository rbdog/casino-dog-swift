//
// Partycake サーバー
//

public class PartycakeServer {
    
    public let speaker = PartycakeSpeaker()
    
    var state = PartycakeServerState()
    
    let matcher = PartycakeMatcher(
        userRepository: UserRepository(),
        stateRepository: PartycakeStateRepositoryImpl(),
        keycardRepository: KeycardRealmRepository()
    )
    
    func onFirstLaunch() {
        state = PartycakeServerState()
    }
    
    func onLaunch() {
        let keycards = KeycardRealmRepository().loadAllKeycards()
        activateBots(keycards: keycards)
        resumeBots()
    }
    
    func deleteAllMemory() {
        
    }
    
    func betAction(level: PartycakeBetLevel, userId: String, secretId: String) {
        let keycard = KeycardRealmRepository().loadKeycard(userId: userId, secretId: secretId)
        let seat = PartycakeSeat(rawValue: keycard.seat)!
        let controller = PartycakeController(
            repository: PartycakeStateRepositoryImpl(),
            observer: self
        )
        controller.betAction(level: level, seat: seat, stateId: keycard.state_id)
    }
    
    func putAction(card: CardId, userId: String, secretId: String) {
        let keycard = KeycardRealmRepository().loadKeycard(userId: userId, secretId: secretId)
        let seat = PartycakeSeat(rawValue: keycard.seat)!
        let controller = PartycakeController(
            repository: PartycakeStateRepositoryImpl(),
            observer: self
        )
        controller.putAction(card: card, seat: seat, stateId: keycard.state_id)
    }
    
    func activateBots(keycards: [KeycardRealm]) {
        for keycard in keycards where keycard.user_type == UserType.bot.rawValue {
            if state.activeBots.contains(where: {$0.userId == keycard.user_id}) {
                print("現在稼働中のボット: ", state.activeBots.map{$0.userId})
                print("起動しようとしたボット: ", keycard.user_id)
                fatalError("すでにアクティブなボットです")
            }
            let bot = PartycakeBot(
                userId: keycard.user_id,
                secretId: keycard.secret_id
            )
            self.state.activeBots.append(bot)
            // WS開始
            bot.listenSpeaker()
        }
    }
    
    // ローカル版限定機能
    // ボットの行動中にアプリが終了された場合に備えて、もう一度行動させる
    func resumeBots() {
        
        for bot in state.activeBots {
            let keycard = KeycardRealmRepository().loadKeycard(userId: bot.userId, secretId: bot.secretId)
            let seat = PartycakeSeat(rawValue: keycard.seat)!
            let state = PartycakeStateRepositoryImpl().loadState(id: keycard.state_id)
            bot.resume(at: seat, in: state)
        }
    }
}

extension PartycakeServer: PartycakeObserver {
    
    func onBetStart(state: PartycakeState) {
        let keycards = KeycardRealmRepository().loadKeycards(stateId: state.id)
        
        for keycard in keycards {
            let seat = PartycakeSeat(rawValue: keycard.seat)!
            let maskedState = PartycakeAPIModelBuilder.maskedState(state: state, for: seat)
            let players = PartycakeAPIModelBuilder.players(in: state)
            let animationList = ShowdownAnimationBuilder().build(from: state)
            let scoreList = PartycakeScoreListBuilder().build(from: state)
            let announce = PartycakeAnnounce(
                announce_type: PartycakeAnnounceId.betStart.rawValue,
                masked_state: maskedState,
                players: players,
                trigger_seat: nil,
                showdown_list: animationList,
                score_list: scoreList,
                published_keycard: nil
            )
            speaker.speak(to: [keycard.user_id], announce: announce)
        }
    }
    
    func onPutStart(state: PartycakeState) {
        let keycards = KeycardRealmRepository().loadKeycards(stateId: state.id)
        
        for keycard in keycards {
            let seat = PartycakeSeat(rawValue: keycard.seat)!
            let maskedState = PartycakeAPIModelBuilder.maskedState(state: state, for: seat)
            let players = PartycakeAPIModelBuilder.players(in: state)
            let announce = PartycakeAnnounce(
                announce_type: PartycakeAnnounceId.putStart.rawValue,
                masked_state: maskedState,
                players: players,
                trigger_seat: nil,
                showdown_list: nil,
                score_list: nil,
                published_keycard: nil
            )
            speaker.speak(to: [keycard.user_id], announce: announce)
        }
    }
    
    func onPlayerPut(state: PartycakeState, seat: PartycakeSeat) {
        let keycards = KeycardRealmRepository().loadKeycards(stateId: state.id)
        let userIds = keycards.map{$0.user_id}
        let announce = PartycakeAnnounce(
            announce_type: PartycakeAnnounceId.playerPut.rawValue,
            masked_state: nil,
            players: nil,
            trigger_seat: seat.rawValue,
            showdown_list: nil,
            score_list: nil,
            published_keycard: nil
        )
        speaker.speak(to: userIds, announce: announce)
    }
    
    func onPlayerEnter(state: PartycakeState, seat: PartycakeSeat) {
        let keycards = KeycardRealmRepository().loadKeycards(stateId: state.id)
        let userIds = keycards.map{$0.user_id}
        let announce = PartycakeAnnounce(
            announce_type: PartycakeAnnounceId.playerEnter.rawValue,
            masked_state: nil,
            players: nil,
            trigger_seat: seat.rawValue,
            showdown_list: nil,
            score_list: nil,
            published_keycard: nil
        )
        speaker.speak(to: userIds, announce: announce)
    }
    
    func onPlayerLeave(state: PartycakeState, seat: PartycakeSeat) {
        let keycards = KeycardRealmRepository().loadKeycards(stateId: state.id)
        let userIds = keycards.map{$0.user_id}
        let announce = PartycakeAnnounce(
            announce_type: PartycakeAnnounceId.playerExit.rawValue,
            masked_state: nil,
            players: nil,
            trigger_seat: seat.rawValue,
            showdown_list: nil,
            score_list: nil,
            published_keycard: nil
        )
        speaker.speak(to: userIds, announce: announce)
    }
    
}
