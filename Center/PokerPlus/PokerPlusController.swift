//
//
//

protocol PokerPlusStateRepository {
    func saveState(_ state: PokerPlusState)
    func loadState(id: String) -> PokerPlusState
    func deleteState(id: String)
}

protocol PokerPlusObserver {
    func onBetStart(state: PokerPlusState)
    func onPutStart(state: PokerPlusState)
    func onPlayerPut(state: PokerPlusState, seat: PokerPlusSeat)
    func onPlayerEnter(state: PokerPlusState, seat: PokerPlusSeat)
    func onPlayerLeave(state: PokerPlusState, seat: PokerPlusSeat)
}

protocol PokerPlusInterface {
    func betAction(level: PokerPlusBetLevel, seat: PokerPlusSeat, stateId: String)
    func putAction(card: CardID, seat: PokerPlusSeat, stateId: String)
}

struct PokerPlusController: PokerPlusInterface {
    let repository: PokerPlusStateRepository
    let observer: PokerPlusObserver?
    
    func betAction(level: PokerPlusBetLevel, seat: PokerPlusSeat, stateId: String) {
        let state = repository.loadState(id: stateId)
        let rule = PokerPlusRule()
        let logger = PokerPlusLogger()
        let canBet = rule.canBet(level: level, at: seat, in: state)
        if canBet {
            let player = PokerPlusPlayer(seat: seat)
            let bettedState = player.bet(level: level, state: state)
            repository.saveState(bettedState)
            logger.load(state: bettedState)
            logger.printAsciiLog(with: ["Player at: \(seat.rawValue) did Bet"])
            
            let canShuffle = rule.canShuffle(state: bettedState)
            if canShuffle {
                let dealer = PokerPlusDealer()
                let shuffledState = dealer.shuffle(state: bettedState)
                repository.saveState(shuffledState)
                logger.load(state: shuffledState)
                logger.printAsciiLog(with: ["Dealer did Shuffle"])
                observer?.onPutStart(state: shuffledState)
            }
        } else {
            fatalError("不正なBetです")
        }
    }
    
    func putAction(card: CardID, seat: PokerPlusSeat, stateId: String) {
        let state = repository.loadState(id: stateId)
        let rule = PokerPlusRule()
        let logger = PokerPlusLogger()
        let canPut = rule.canPut(card: card, at: seat, in: state)
        if canPut {
            let player = PokerPlusPlayer(seat: seat)
            let putttedState = player.put(card: card, state: state)
            repository.saveState(putttedState)
            observer?.onPlayerPut(state: putttedState, seat: seat)
            logger.load(state: putttedState)
            logger.printAsciiLog(with: ["Player at: \(seat.rawValue) did Put"])
            
            let canShowdown = rule.canShowdown(state: putttedState)
            if canShowdown {
                let dealer = PokerPlusDealer()
                let showdownededState = dealer.showdown(state: putttedState)
                repository.saveState(showdownededState)
                logger.load(state: showdownededState)
                logger.printAsciiLog(with: ["Dealer did Showdown"])
                observer?.onBetStart(state: showdownededState)
            }
        } else {
            fatalError("不正なPutです")
        }
    }
}
