//
//
//

struct PartycakeDealer {
    
    func shuffle(state: PartycakeState) -> PartycakeState {
        // Putカードを回収
        var deck: [CardId] = state.deck
        for side in state.sides {
            if let putCard = side.putCardId {
                deck.append(putCard)
            }
        }
        // デッキをシャッフル
        deck = deck.shuffled()
        // カードを配る
        var sides: [PartycakeSide] = []
        for oldSide in state.sides {
            let cardCount = PartycakeRule().cardCount(of: oldSide.betLevel)
            var newSide =  oldSide
            newSide.playerStep = .put
            newSide.handCardIds = [CardId](deck.prefix(cardCount))
            newSide.putCardId = nil
            deck = [CardId](deck.dropFirst(cardCount))
            sides.append(newSide)
        }
        
        var newState = state
        newState.deck = deck
        newState.dealerStep = .waitingPut
        newState.sides = sides
        return newState
    }
    
    func showdown(state: PartycakeState) -> PartycakeState {
        // return cards
        let cardsReturned = returnCards(state: state)
        // rotate cake
        let cakeRotated = rotateCake(state: cardsReturned)
        // judge
        let judged = judge(state: cakeRotated)
        // pay
        let payed = pay(state: judged)
        return payed
    }
    
    func returnCards(state: PartycakeState) -> PartycakeState {
        // Handカードを回収
        var deck: [CardId] = state.deck
        for side in state.sides {
            deck.append(contentsOf: side.handCardIds)
        }
        var sides: [PartycakeSide] = []
        for oldSide in state.sides {
            var newSide = oldSide
            newSide.handCardIds = []
            sides.append(newSide)
        }
        var newState = state
        newState.deck = deck
        newState.sides = sides
        return newState
    }
    
    func rotateCake(state: PartycakeState) -> PartycakeState {
        var newState = state
        for side in state.sides {
            if let putCard = side.putCardId {
                let putCard = cards.first(where: {$0.id == putCard})!
                switch putCard.number {
                case .num11:
                    newState.innerOffset += 1
                case .num12:
                    newState.outerOffset += 1
                case .num13:
                    newState.innerOffset += 1
                    newState.outerOffset += 1
                case .num1:
                    break
                default:
                    fatalError("不正なカードです")
                }
            }
            if newState.innerOffset >= state.innerPieceIds.count {
                newState.innerOffset = 0
            }
            if newState.outerOffset >= state.outerPieceIds.count {
                newState.outerOffset = 0
            }
        }
        
        return newState
    }
    
    func judge(state: PartycakeState) -> PartycakeState {
        var sides: [PartycakeSide] = []
        for side in state.sides {
            let seatOffset = side.seat.rawValue - 1
            var innerIndex = seatOffset - state.innerOffset
            if innerIndex < 0 {
                innerIndex += state.innerPieceIds.count
            }
            var outerIndex = seatOffset - state.outerOffset
            if outerIndex < 0 {
                outerIndex += state.outerPieceIds.count
            }
            guard let side = state.sides.first(where: {$0.seat == side.seat}) else {
                return state
            }
            guard let cardId = side.putCardId else {
                return state
            }
            let card = cards.first(where: {$0.id == cardId})!
            let innerId = state.innerPieceIds[innerIndex]
            let inner = partycakeInnerPieces.first(where: {$0.id == innerId})!
            let outerId = state.outerPieceIds[outerIndex]
            let outer = partycakeOuterPieces.first(where: {$0.id == outerId})!
            let cardSuit = card.suit
            let cardNumber = card.number
            let lastCombo = side.lastCombo
            
            let combo = PartycakeRule().combo(
                innerSuit: inner.suit,
                outerSuit: outer.suit,
                outerNumber: outer.number,
                cardSuit: cardSuit,
                cardNumber: cardNumber,
                lastCombo: lastCombo
            )
            
            var newSide = side
            newSide.lastCombo = combo
            sides.append(newSide)
        }
        
        var newState = state
        newState.sides = sides
        return newState
    }
    
    func pay(state: PartycakeState) -> PartycakeState {
        var sides: [PartycakeSide] = []
        for side in state.sides {
            let bonusChips = PartycakeRule().bonusChips(of: side.lastCombo)
            var newChips = side.chips + bonusChips
            if newChips < 0 {
                newChips = 0
            }
            var newSide = side
            newSide.playerStep = .bet
            newSide.chips = newChips
            newSide.betLevel = nil
            sides.append(newSide)
        }
        
        var newState = state
        newState.dealerStep = .waitingBet
        newState.sides = sides
        return newState
    }
    
}
