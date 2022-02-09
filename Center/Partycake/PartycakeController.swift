//
//
//

protocol PartycakeStateRepository {
    func saveState(_ state: PartycakeState)
    func loadState(id: String) -> PartycakeState
    func deleteState(id: String)
}

protocol PartycakeObserver {
    func onBetStart(state: PartycakeState)
    func onPutStart(state: PartycakeState)
    func onPlayerPut(state: PartycakeState, seat: PartycakeSeat)
    func onPlayerEnter(state: PartycakeState, seat: PartycakeSeat)
    func onPlayerLeave(state: PartycakeState, seat: PartycakeSeat)
}

protocol PartycakeInterface {
    func betAction(level: PartycakeBetLevel, seat: PartycakeSeat, stateId: String)
    func putAction(card: CardId, seat: PartycakeSeat, stateId: String)
}

struct PartycakeController: PartycakeInterface {
    let repository: PartycakeStateRepository
    let observer: PartycakeObserver?
    
    func betAction(level: PartycakeBetLevel, seat: PartycakeSeat, stateId: String) {
        let state = repository.loadState(id: stateId)
        let rule = PartycakeRule()
        let logger = PartycakeLogger()
        let canBet = rule.canBet(level: level, at: seat, in: state)
        if canBet {
            let player = PartycakePlayer(seat: seat)
            let bettedState = player.bet(level: level, state: state)
            repository.saveState(bettedState)
            logger.load(state: bettedState)
            logger.printAsciiLog(with: ["Player at: \(seat.rawValue) did Bet"])
            
            let canShuffle = rule.canShuffle(state: bettedState)
            if canShuffle {
                let dealer = PartycakeDealer()
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
    
    func putAction(card: CardId, seat: PartycakeSeat, stateId: String) {
        let state = repository.loadState(id: stateId)
        let rule = PartycakeRule()
        let logger = PartycakeLogger()
        let canPut = rule.canPut(cardId: card, at: seat, in: state)
        if canPut {
            let player = PartycakePlayer(seat: seat)
            let putttedState = player.put(card: card, state: state)
            repository.saveState(putttedState)
            observer?.onPlayerPut(state: putttedState, seat: seat)
            logger.load(state: putttedState)
            logger.printAsciiLog(with: ["Player at: \(seat.rawValue) did Put"])
            
            let canShowdown = rule.canShowdown(state: putttedState)
            if canShowdown {
                let dealer = PartycakeDealer()
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
