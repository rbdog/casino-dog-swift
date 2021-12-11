//
//
//

struct PokerPlusDealer {
    
    func shuffle(state: PokerPlusState) -> PokerPlusState {
        // Putカードを回収
        var deck: [CardID] = state.deck
        for side in state.sides {
            if let putCard = side.putCardId {
                deck.append(putCard)
            }
        }
        // デッキをシャッフル
        deck = deck.shuffled()
        // カードを配る
        var sides: [PokerPlusSide] = []
        for oldSide in state.sides {
            let cardCount = PokerPlusRule().cardCount(of: oldSide.betLevel)
            var newSide =  oldSide
            newSide.playerStep = .put
            newSide.handCardIds = [CardID](deck.prefix(cardCount))
            newSide.putCardId = nil
            deck = [CardID](deck.dropFirst(cardCount))
            sides.append(newSide)
        }
        
        var newState = state
        newState.deck = deck
        newState.dealerStep = .waitingPut
        newState.sides = sides
        return newState
    }
    
    func showdown(state: PokerPlusState) -> PokerPlusState {
        // return cards
        let cardsReturned = returnCards(state: state)
        // rotate wheel
        let wheelRotated = rotateWheel(state: cardsReturned)
        // judge
        let judged = judge(state: wheelRotated)
        // pay
        let payed = pay(state: judged)
        return payed
    }
    
    func returnCards(state: PokerPlusState) -> PokerPlusState {
        // Handカードを回収
        var deck: [CardID] = state.deck
        for side in state.sides {
            deck.append(contentsOf: side.handCardIds)
        }
        var sides: [PokerPlusSide] = []
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
    
    func rotateWheel(state: PokerPlusState) -> PokerPlusState {
        var innerOffset: Int = state.wheel.innerOffset
        var outerOffset: Int = state.wheel.outerOffset
        for side in state.sides {
            if let putCard = side.putCardId {
                switch putCard.number {
                case .num11:
                    innerOffset += 1
                case .num12:
                    outerOffset += 1
                case .num13:
                    innerOffset += 1
                    outerOffset += 1
                case .num1:
                    break
                default:
                    fatalError("不正なカードです")
                }
            }
            if innerOffset >= state.wheel.innerPartIds.count {
                innerOffset = 0
            }
            if outerOffset >= state.wheel.outerPartIds.count {
                outerOffset = 0
            }
        }
        
        var wheel = state.wheel
        wheel.innerOffset = innerOffset
        wheel.outerOffset = outerOffset
        var newState = state
        newState.wheel = wheel
        return newState
    }
    
    func judge(state: PokerPlusState) -> PokerPlusState {
        var sides: [PokerPlusSide] = []
        for side in state.sides {
            let seatOffset = side.seat.rawValue - 1
            var innerIndex = seatOffset - state.wheel.innerOffset
            if innerIndex < 0 {
                innerIndex += state.wheel.innerPartIds.count
            }
            var outerIndex = seatOffset - state.wheel.outerOffset
            if outerIndex < 0 {
                outerIndex += state.wheel.outerPartIds.count
            }
            guard let side = state.sides.first(where: {$0.seat == side.seat}) else {
                return state
            }
            guard let card = side.putCardId else {
                return state
            }
            let innerId = state.wheel.innerPartIds[innerIndex]
            let outerId = state.wheel.outerPartIds[outerIndex]
            let cardSuit = card.suit
            let cardNumber = card.number
            let lastCombo = side.lastCombo
            
            let combo = PokerPlusRule().combo(
                innerSuit: innerId.suit,
                outerSuit: outerId.suit,
                outerNumber: outerId.number,
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
    
    func pay(state: PokerPlusState) -> PokerPlusState {
        var sides: [PokerPlusSide] = []
        for side in state.sides {
            let bonusChips = PokerPlusRule().bonusChips(of: side.lastCombo)
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
