//
//
//

import Foundation

struct PokerPlusRule {
    
    static var initialDealerStep: PokerPlusDealerStep {
        return .waitingBet
    }
    
    static var initialDeck: [CardId] {
        return [
            .spade1,
            .spade11,
            .spade12,
            .heart1,
            .heart11,
            .heart12,
            .diamond11,
            .diamond12,
            .diamond13,
            .club11,
            .club12,
            .club13,
        ]
    }
    
    //
    // +---+---+
    // | D | C |
    // |---+---|
    // | Z | H |
    // +---+---+
    // +----+----+
    // | H1 | DQ |
    // |----+----|
    // | SK | CJ |
    // +----+----+
    //
    static var initialWheel: PokerPlusWheel {
        return PokerPlusWheel(
            innerPartIds: [
                .club,
                .heart,
                .joker,
                .diamond,
            ],
            outerPartIds: [
                .diamond12,
                .club11,
                .spade13,
                .heart1,
            ],
            innerOffset: 0,
            outerOffset: 0
        )
    }
    
    static var initialSides: [PokerPlusSide] {
        return [
            .init(
                seat: .s1,
                playerStep: .bet,
                chips: 27,
                handCardIds: [],
                betLevel: nil,
                putCardId: nil,
                lastCombo: .start
            ),
            .init(
                seat: .s2,
                playerStep: .bet,
                chips: 27,
                handCardIds: [],
                betLevel: nil,
                putCardId: nil,
                lastCombo: .start
            ),
            .init(
                seat: .s3,
                playerStep: .bet,
                chips: 27,
                handCardIds: [],
                betLevel: nil,
                putCardId: nil,
                lastCombo: .start
            ),
            .init(
                seat: .s4,
                playerStep: .bet,
                chips: 27,
                handCardIds: [],
                betLevel: nil,
                putCardId: nil,
                lastCombo: .start
            ),
        ]
    }
    
    static var initialState: PokerPlusState {
        let stateId = UUID().uuidString
        return PokerPlusState(
            id: stateId,
            deck: Self.initialDeck,
            dealerStep: Self.initialDealerStep,
            sides: Self.initialSides,
            wheel: Self.initialWheel
        )
    }
    
    func canShuffle(state: PokerPlusState) -> Bool {
        // 全員のベットが完了しているか確認
        let hasBettingPlayer = state.sides.contains(where: {$0.playerStep == .bet})
        return !(hasBettingPlayer)
    }
    
    func canShowdown(state: PokerPlusState) -> Bool {
        // 全員のプットが完了しているか確認
        let hasPuttingPlayer = state.sides.contains(where: {$0.playerStep == .put})
        return !(hasPuttingPlayer)
    }
    
    func canBet(level: PokerPlusBetLevel, at seat: PokerPlusSeat, in state: PokerPlusState) -> Bool {
        guard let side = state.sides.first(where: {$0.seat == seat}) else {
            print("指定されたシートが見つかりません")
            return false
        }
        if side.playerStep != .bet {
            print("現在はベットのステップではありません")
            return false
        } else if side.betLevel != nil {
            print("既にベット済みです")
            return false
        } else if side.chips < betCost(of: level) {
            print("チップが足りません")
            return false
        } else {
            return true
        }
    }
    
    func canPut(card: CardId, at seat: PokerPlusSeat, in state: PokerPlusState) -> Bool {
        guard let side = state.sides.first(where: {$0.seat == seat}) else {
            print("指定されたシートが見つかりません")
            return false
        }
        if side.playerStep != .put {
            print("現在はプットのステップではありません")
            return false
        } else if side.putCardId != nil {
            print("既にプット済みです")
            return false
        } else if !(side.handCardIds.contains(where: {$0.suit == card.suit && $0.number == card.number})) {
            print("そのカードは持っていません")
            return false
        } else {
            return true
        }
    }
    
    func betCost(of level: PokerPlusBetLevel) -> Int {
        switch level {
        case .min:
            return 3
        case .mid:
            return 5
        case .max:
            return 7
        }
    }
    
    func cardCount(of level: PokerPlusBetLevel?) -> Int {
        guard let level = level else {
            return 0
        }
        switch level {
        case .min:
            return 1
        case .mid:
            return 2
        case .max:
            return 3
        }
    }
    
    func combo(
        innerSuit: SuitId,
        outerSuit: SuitId,
        outerNumber: NumberId,
        cardSuit: SuitId,
        cardNumber: NumberId,
        lastCombo: PokerPlusCombo
    ) -> PokerPlusCombo {
        // 判定優先順
        
        // RoyalStraightFlush
        if (innerSuit == .joker)
            && (outerNumber == .num13)
            && (cardSuit == .spade)
            && (cardNumber == .num1)
            && (outerSuit == .spade) {
            // joker, Ks, As
            return .rsf
        }
        // KingJoker
        else if (innerSuit == .joker)
                    && (outerNumber == .num13)
                    && (cardSuit == .spade) {
            // joker, Ks
            return .kingJoker
        }
        // Joker
        else if innerSuit == .joker {
            // ジョーカー
            return .joker
        }
        // StraightFlush
        else if (innerSuit == outerSuit)
                    && (innerSuit == cardSuit)
                    && (outerNumber == cardNumber) {
            if lastCombo == .sf {
                return .double
            } else if lastCombo == .double {
                return .triple
            } else if (lastCombo == .triple)
                        || (lastCombo == .miracle) {
                return .miracle
            } else {
                // スートが全て同じ && ナンバーが全て同じ
                return .sf
            }
        }
        // FullHouse
        else if (innerSuit == cardSuit)
                    && (outerNumber == cardNumber) {
            // 内スート と カードスート が同じ && 外ナンバー と カードナンバーが同じ
            return .fullHouse
        }
        // Flush
        else if (innerSuit == outerSuit)
                    && (innerSuit == cardSuit) {
            // スートが全て同じ
            return .flush
        }
        // Straight
        else if (outerSuit == cardSuit)
                    && (outerNumber == cardNumber) {
            // 外スート と カードスート が同じ && 外ナンバー と カードナンバーが同じ
            return .straight
        }
        // TwoPairs
        else if (innerSuit == outerSuit)
                    && (outerNumber == cardNumber) {
            // 内スート と 外スート が同じ && 外ナンバー と カードナンバーが同じ
            return .twoPairs
        }
        // NumberPair
        else if outerNumber == cardNumber {
            // 外ナンバー と カードナンバーが同じ
            return .numberPair
        }
        // SuitPair
        else if (innerSuit == outerSuit)
                    || (innerSuit == cardSuit)
                    || (outerSuit == cardSuit) {
            // スートがどれか同じ
            return .suitPair
        }
        // NoPairs
        else {
            // ノーペア
            return .noPairs
        }
    }
    
    func bonusChips(of combo: PokerPlusCombo) -> Int {
        switch combo {
        case .start:
            return 0
        case .rsf:
            return 100
        case .sf:
            return 50
        case .fullHouse:
            return 30
        case .flush:
            return 25
        case .straight:
            return 15
        case .twoPairs:
            return 15
        case .double:
            return 100
        case .triple:
            return 200
        case .miracle:
            return 500
        case .kingJoker:
            return -30
        case .numberPair:
            return 7
        case .suitPair:
            return 5
        case .joker:
            return -10
        case .noPairs:
            return 0
        }
    }
    
    func comboName(of combo: PokerPlusCombo) -> String {
        switch combo {
        case .start:
            return "--"
        case .rsf:
            return "ロイヤルストレートフラッシュ"
        case .sf:
            return "ストレートフラッシュ"
        case .fullHouse:
            return "フルハウス"
        case .flush:
            return "フラッシュ"
        case .straight:
            return "ストレート"
        case .twoPairs:
            return "ツーペア"
        case .double:
            return "ダブル"
        case .triple:
            return "トリプル"
        case .miracle:
            return "ミラクル"
        case .kingJoker:
            return "キングジョーカー"
        case .numberPair:
            return "ナンバーペア"
        case .suitPair:
            return "マークペア"
        case .joker:
            return "ジョーカー"
        case .noPairs:
            return "ノーペア"
        }
    }
}

extension CardId {
    var suit: SuitId {
        switch self {
        case .back:
            return .back
        case .spade1, .spade2, .spade3, .spade4, .spade5, .spade6, .spade7, .spade8, .spade9, .spade10, .spade11, .spade12, .spade13:
            return .spade
        case .heart1, .heart2, .heart3, .heart4, .heart5, .heart6, .heart7, .heart8, .heart9, .heart10, .heart11, .heart12, .heart13:
            return .heart
        case .diamond1, .diamond2, .diamond3, .diamond4, .diamond5, .diamond6, .diamond7, .diamond8, .diamond9, .diamond10, .diamond11, .diamond12, .diamond13:
            return .diamond
        case .club1, .club2, .club3, .club4, .club5, .club6, .club7, .club8, .club9, .club10, .club11, .club12, .club13:
            return .club
        case .blackJocker, .whiteJocker:
            return .joker
        }
    }
    
    var number: NumberId {
        switch self {
        case .back:
            return .back
        case .spade1, .heart1, .diamond1, .club1:
            return .num1
        case .spade2, .heart2, .diamond2, .club2:
            return .num2
        case .spade3, .heart3, .diamond3, .club3:
            return .num3
        case .spade4, .heart4, .diamond4, .club4:
            return .num4
        case .spade5, .heart5, .diamond5, .club5:
            return .num5
        case .spade6, .heart6, .diamond6, .club6:
            return .num6
        case .spade7, .heart7, .diamond7, .club7:
            return .num7
        case .spade8, .heart8, .diamond8, .club8:
            return .num8
        case .spade9, .heart9, .diamond9, .club9:
            return .num9
        case .spade10, .heart10, .diamond10, .club10:
            return .num10
        case .spade11, .heart11, .diamond11, .club11:
            return .num11
        case .spade12, .heart12, .diamond12, .club12:
            return .num12
        case .spade13, .heart13, .diamond13, .club13:
            return .num13
        case .blackJocker, .whiteJocker:
            return .joker
        }
    }
}

extension PokerPlusOuterPartID {
    var suit: SuitId {
        switch self {
        case .diamond12:
            return .diamond
        case .club11:
            return .club
        case .spade13:
            return .spade
        case .heart1:
            return .heart
        }
    }
    var number: NumberId {
        switch self {
        case .diamond12:
            return .num12
        case .club11:
            return .num11
        case .spade13:
            return .num13
        case .heart1:
            return .num1
        }
    }
}

extension PokerPlusInnerPartID {
    var suit: SuitId {
        switch self {
        case .club:
            return .club
        case .heart:
            return .heart
        case .joker:
            return .joker
        case .diamond:
            return .diamond
        }
    }
}
