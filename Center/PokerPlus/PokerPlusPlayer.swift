//
//
//

struct PokerPlusPlayer {
    
    let seat: PokerPlusSeat
    
    func bet(level: PokerPlusBetLevel, state: PokerPlusState) -> PokerPlusState {
        guard let oldSide = state.sides.first(where: {$0.seat == seat}) else {
            return state
        }
        let betCost = PokerPlusRule().betCost(of: level)
        var side = oldSide
        side.playerStep = .waitingShuffle
        side.chips = oldSide.chips - betCost
        side.betLevel = level
        var sides: [PokerPlusSide] = []
        for oldSide in state.sides {
            if oldSide.seat == seat {
                sides.append(side)
            } else {
                sides.append(oldSide)
            }
        }
        
        var newState = state
        newState.sides = sides
        return newState
    }
    
    func put(card: CardID, state: PokerPlusState) -> PokerPlusState {
        guard let oldSide = state.sides.first(where: {$0.seat == seat}) else {
            return state
        }
        var handCards = oldSide.handCardIds
        handCards.removeAll(where: {$0.suit == card.suit && $0.number == $0.number})
        var side = oldSide
        side.playerStep = .waitingShowdown
        side.handCardIds = handCards
        side.putCardId = card
        var sides: [PokerPlusSide] = []
        for oldSide in state.sides {
            if oldSide.seat == seat {
                sides.append(side)
            } else {
                sides.append(oldSide)
            }
        }
        
        var newState = state
        newState.sides = sides
        return newState
    }
}
