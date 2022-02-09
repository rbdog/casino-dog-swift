//
//
//

struct PartycakePlayer {
    
    let seat: PartycakeSeat
    
    func bet(level: PartycakeBetLevel, state: PartycakeState) -> PartycakeState {
        guard let oldSide = state.sides.first(where: {$0.seat == seat}) else {
            return state
        }
        let betCost = PartycakeRule().betCost(of: level)
        var side = oldSide
        side.playerStep = .waitingShuffle
        side.chips = oldSide.chips - betCost
        side.betLevel = level
        var sides: [PartycakeSide] = []
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
    
    func put(card: CardId, state: PartycakeState) -> PartycakeState {
        guard let oldSide = state.sides.first(where: {$0.seat == seat}) else {
            return state
        }
        var handCards = oldSide.handCardIds
        handCards.removeAll(where: {$0 == card})
        var side = oldSide
        side.playerStep = .waitingShowdown
        side.handCardIds = handCards
        side.putCardId = card
        var sides: [PartycakeSide] = []
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
