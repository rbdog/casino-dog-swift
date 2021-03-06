//
//
//

import Foundation

struct ShowdownAnimationBuilder {
    func build(from state: PartycakeState) -> [PartycakeShowdownAnimation] {

        let animations = state.sides.map { side -> PartycakeShowdownAnimation in
            return self.animation(at: side.seat, in: state)
        }

        return animations
    }

    func degrees(_ oldOffset: Int, _ newOffset: Int) -> (old: Int, new: Int?) {
        var new: Int? = newOffset
        if oldOffset == newOffset {
            new = nil
        }
        if oldOffset > newOffset {
            new = (newOffset + 4)
        }
        return (old: oldOffset * 90, new: new == nil ? nil : new! * 90)
    }

    func animation(at seat: PartycakeSeat, in state: PartycakeState) -> PartycakeShowdownAnimation {
        let maxIndex = state.sides.count - 1
        let myPutId = state.sides.first(where: {$0.seat == seat})!.putCardId!
        let myPut = cards.first(where: {$0.id == myPutId})!

        // 自分の後にInnerを回転させた回数
        let futureInnerCount = state.sides
            .filter {$0.seat.rawValue > seat.rawValue}
            .map { side -> Card in
                let card = cards.first(where: {$0.id == side.putCardId!})!
                return card
            }
            .filter {$0.number == .num13 || $0.number == .num11}
            .count
        // 自分の後にOuterを回転させた回数
        let futureOuterCount = state.sides
            .filter {$0.seat.rawValue > seat.rawValue}
            .map { side -> Card in
                let card = cards.first(where: {$0.id == side.putCardId!})!
                return card
            }
            .filter {$0.number == .num13 || $0.number == .num12}
            .count
        // 現在のInnerオフセット
        let currentInnerOffset = state.innerOffset
        // 現在のOuterオフセット
        let currentOuterOffset = state.outerOffset
        // 自分の直後のInnerオフセット
        let newInnerOffset = (currentInnerOffset - futureInnerCount).looped(in: 0...maxIndex)
        // 自分の直後のOuterオフセット
        let newOuterOffset = (currentOuterOffset - futureOuterCount).looped(in: 0...maxIndex)
        // 自分の直前のInnerオフセット
        let oldInnerOffset = newInnerOffset - ( (myPut.number == .num13 || myPut.number == .num11) ? 1 : 0 )
            .looped(in: 0...maxIndex)
        // 自分の直前のOuterオフセット
        let oldOuterOffset = newOuterOffset - ( (myPut.number == .num13 || myPut.number == .num12) ? 1 : 0 )
            .looped(in: 0...maxIndex)

        let innerDgrees = self.degrees(oldInnerOffset, newInnerOffset)
        let outerDegrees = self.degrees(oldOuterOffset, newOuterOffset)

        let animation = PartycakeShowdownAnimation(
            seat: seat.rawValue,
            put_card_id: myPutId.rawValue,
            old_inner_offset: innerDgrees.old,
            new_inner_offset: innerDgrees.new,
            old_outer_offset: outerDegrees.old,
            new_outer_offset: outerDegrees.new
        )
        return animation
    }
}
