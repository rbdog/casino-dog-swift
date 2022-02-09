//
//
//

import Foundation

struct PartycakeRule {
    
    static var initialDealerStep: PartycakeDealerStep {
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
    
    static var initialSides: [PartycakeSide] {
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
    static var initialState: PartycakeState {
        let stateId = UUID().uuidString
        return PartycakeState(
            id: stateId,
            deck: Self.initialDeck,
            dealerStep: Self.initialDealerStep,
            sides: Self.initialSides,
            innerPieceIds: [
                .club,
                .heart,
                .joker,
                .diamond,
            ],
            outerPieceIds: [
                .diamond12,
                .club11,
                .spade13,
                .heart1,
            ],
            innerOffset: 0,
            outerOffset: 0
        )
    }
    
    func canShuffle(state: PartycakeState) -> Bool {
        // 全員のベットが完了しているか確認
        let hasBettingPlayer = state.sides.contains(where: {$0.playerStep == .bet})
        return !(hasBettingPlayer)
    }
    
    func canShowdown(state: PartycakeState) -> Bool {
        // 全員のプットが完了しているか確認
        let hasPuttingPlayer = state.sides.contains(where: {$0.playerStep == .put})
        return !(hasPuttingPlayer)
    }
    
    func canBet(level: PartycakeBetLevel, at seat: PartycakeSeat, in state: PartycakeState) -> Bool {
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
    
    func canPut(cardId: CardId, at seat: PartycakeSeat, in state: PartycakeState) -> Bool {
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
        } else if !(side.handCardIds.contains(where: {$0 == cardId})) {
            print("そのカードは持っていません")
            return false
        } else {
            return true
        }
    }
    
    func betCost(of level: PartycakeBetLevel) -> Int {
        switch level {
        case .min:
            return 3
        case .mid:
            return 5
        case .max:
            return 7
        }
    }
    
    func cardCount(of level: PartycakeBetLevel?) -> Int {
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
        lastCombo: PartycakeCombo
    ) -> PartycakeCombo {
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
    
    func bonusChips(of combo: PartycakeCombo) -> Int {
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
    
    func comboName(of combo: PartycakeCombo) -> String {
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

let partycakeOuterPieces = [
    PartycakeOuterPiece(id: .diamond12, number: .num12, suit: .diamond),
    PartycakeOuterPiece(id: .club11, number: .num11, suit: .club),
    PartycakeOuterPiece(id: .spade13, number: .num13, suit: .spade),
    PartycakeOuterPiece(id: .heart1, number: .num1, suit: .heart),
]

let partycakeInnerPieces = [
    PartycakeInnerPiece(id: .club, suit: .club),
    PartycakeInnerPiece(id: .heart, suit: .heart),
    PartycakeInnerPiece(id: .joker, suit: .joker),
    PartycakeInnerPiece(id: .diamond, suit: .diamond),
]
