//
//
//

import Foundation

struct PartycakeScoreListBuilder {
    func build(from state: PartycakeState) -> [PartycakeScore] {
        
        let keycards = KeycardRealmRepository().loadKeycards(stateId: state.id)
        
        let list = state.sides.map { side -> PartycakeScore in
            
            let keycard = keycards.first(where: {$0.seat == side.seat.rawValue})!

            let bonusChips = PartycakeRule().bonusChips(of: side.lastCombo)
            
            let seatOffset = side.seat.rawValue - 1
            var innerIndex = seatOffset - state.innerOffset
            if innerIndex < 0 {
                innerIndex += state.innerPieceIds.count
            }
            var outerIndex = seatOffset - state.outerOffset
            if outerIndex < 0 {
                outerIndex += state.outerPieceIds.count
            }
            let innerId = state.innerPieceIds[innerIndex]
            let outerId = state.outerPieceIds[outerIndex]
            
            let comboName = PartycakeRule().comboName(of: side.lastCombo)
            
            let score = PartycakeScore(
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
