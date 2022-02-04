//
// Poker+ サーバー
//

public class PokerPlusServer {
    
    public let speaker = PokerPlusSpeaker()
    
    var state = PokerPlusServerState()
    
    let matcher = PokerPlusMatcher(
        userRepository: UserRepository(),
        stateRepository: PokerPlusStateRepositoryImpl(),
        keycardRepository: KeycardRealmRepository()
    )
    
    func onFirstLaunch() {
        state = PokerPlusServerState()
    }
    
    func onLaunch() {
        let keycards = KeycardRealmRepository().loadAllKeycards()
        activateBots(keycards: keycards)
        resumeBots()
    }
    
    func deleteAllMemory() {
        
    }
    
    func betAction(level: PokerPlusBetLevel, userId: String, secretId: String) {
        let keycard = KeycardRealmRepository().loadKeycard(userId: userId, secretId: secretId)
        let seat = PokerPlusSeat(rawValue: keycard.seat)!
        let controller = PokerPlusController(
            repository: PokerPlusStateRepositoryImpl(),
            observer: self
        )
        controller.betAction(level: level, seat: seat, stateId: keycard.state_id)
    }
    
    func putAction(card: CardId, userId: String, secretId: String) {
        let keycard = KeycardRealmRepository().loadKeycard(userId: userId, secretId: secretId)
        let seat = PokerPlusSeat(rawValue: keycard.seat)!
        let controller = PokerPlusController(
            repository: PokerPlusStateRepositoryImpl(),
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
            let bot = PokerPlusBot(
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
            let seat = PokerPlusSeat(rawValue: keycard.seat)!
            let state = PokerPlusStateRepositoryImpl().loadState(id: keycard.state_id)
            bot.resume(at: seat, in: state)
        }
    }
}

extension PokerPlusServer: PokerPlusObserver {
    
    func onBetStart(state: PokerPlusState) {
        let keycards = KeycardRealmRepository().loadKeycards(stateId: state.id)
        
        for keycard in keycards {
            let seat = PokerPlusSeat(rawValue: keycard.seat)!
            let maskedState = PokerPlusAPIModelBuilder.maskedState(state: state, for: seat)
            let players = PokerPlusAPIModelBuilder.players(in: state)
            let animationList = ShowdownAnimationBuilder().build(from: state)
            let scoreList = PokerPlusScoreListBuilder().build(from: state)
            let announce = PokerPlusAnnounce(
                announce_type: PokerPlusAnnounceId.betStart.rawValue,
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
    
    func onPutStart(state: PokerPlusState) {
        let keycards = KeycardRealmRepository().loadKeycards(stateId: state.id)
        
        for keycard in keycards {
            let seat = PokerPlusSeat(rawValue: keycard.seat)!
            let maskedState = PokerPlusAPIModelBuilder.maskedState(state: state, for: seat)
            let players = PokerPlusAPIModelBuilder.players(in: state)
            let announce = PokerPlusAnnounce(
                announce_type: PokerPlusAnnounceId.putStart.rawValue,
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
    
    func onPlayerPut(state: PokerPlusState, seat: PokerPlusSeat) {
        let keycards = KeycardRealmRepository().loadKeycards(stateId: state.id)
        let userIds = keycards.map{$0.user_id}
        let announce = PokerPlusAnnounce(
            announce_type: PokerPlusAnnounceId.playerPut.rawValue,
            masked_state: nil,
            players: nil,
            trigger_seat: seat.rawValue,
            showdown_list: nil,
            score_list: nil,
            published_keycard: nil
        )
        speaker.speak(to: userIds, announce: announce)
    }
    
    func onPlayerEnter(state: PokerPlusState, seat: PokerPlusSeat) {
        let keycards = KeycardRealmRepository().loadKeycards(stateId: state.id)
        let userIds = keycards.map{$0.user_id}
        let announce = PokerPlusAnnounce(
            announce_type: PokerPlusAnnounceId.playerEnter.rawValue,
            masked_state: nil,
            players: nil,
            trigger_seat: seat.rawValue,
            showdown_list: nil,
            score_list: nil,
            published_keycard: nil
        )
        speaker.speak(to: userIds, announce: announce)
    }
    
    func onPlayerLeave(state: PokerPlusState, seat: PokerPlusSeat) {
        let keycards = KeycardRealmRepository().loadKeycards(stateId: state.id)
        let userIds = keycards.map{$0.user_id}
        let announce = PokerPlusAnnounce(
            announce_type: PokerPlusAnnounceId.playerExit.rawValue,
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
