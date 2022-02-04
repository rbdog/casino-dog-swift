//
//
//

import Foundation

struct PokerPlusScoreListBuilder {
    func build(from state: PokerPlusState) -> [PokerPlusScore] {
        
        let keycards = KeycardRealmRepository().loadKeycards(stateId: state.id)
        
        let list = state.sides.map { side -> PokerPlusScore in
            
            let keycard = keycards.first(where: {$0.seat == side.seat.rawValue})!

            let bonusChips = PokerPlusRule().bonusChips(of: side.lastCombo)
            
            let seatOffset = side.seat.rawValue - 1
            var innerIndex = seatOffset - state.wheel.innerOffset
            if innerIndex < 0 {
                innerIndex += state.wheel.innerPartIds.count
            }
            var outerIndex = seatOffset - state.wheel.outerOffset
            if outerIndex < 0 {
                outerIndex += state.wheel.outerPartIds.count
            }
            let innerId = state.wheel.innerPartIds[innerIndex]
            let outerId = state.wheel.outerPartIds[outerIndex]
            
            let comboName = PokerPlusRule().comboName(of: side.lastCombo)
            
            let score = PokerPlusScore(
                user_id: keycard.user_id,
                old_total_chips: side.chips - bonusChips,
                bonus_chips: bonusChips,
                put_card_id: side.putCardId!.rawValue,
                inner_id: innerId.rawValue,
                outer_id: outerId.rawValue,
                combo_name: comboName
            )
            
            return score
        }

        return list
    }
}
