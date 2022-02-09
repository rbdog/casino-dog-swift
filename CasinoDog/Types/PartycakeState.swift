//
//
//

enum PartycakeBetLevel: Int, JSONSerializable {
    case min = 0
    case mid = 1
    case max = 2
}

enum PartycakeSeat: Int, JSONSerializable {
    case s1 = 1
    case s2 = 2
    case s3 = 3
    case s4 = 4
}

enum PartycakeDealerStep: Int, JSONSerializable {
    case waitingBet = 0
    case shuffle = 1
    case waitingPut = 2
    case showdown = 3
}

enum PartycakePlayerStep: Int, JSONSerializable {
    case bet = 0
    case waitingShuffle = 1
    case put = 2
    case waitingShowdown = 3
}

enum PartycakeCombo: Int, JSONSerializable {
    // initial
    case start = 0
    // need 3
    case rsf = 1
    case sf = 2
    case fullHouse = 3
    case flush = 4
    case straight = 5
    case twoPairs = 6
    case double = 7
    case triple = 8
    case miracle = 9
    // need 2
    case kingJoker = 10
    case numberPair = 11
    case suitPair = 12
    // need 1
    case joker = 13
    // need 0
    case noPairs = 14
}

enum PartycakeOuterPieceID: Int, JSONSerializable {
    case diamond12 = 312
    case club11 = 411
    case spade13 = 113
    case heart1 = 201
}

enum PartycakeInnerPieceID: Int, JSONSerializable {
    case club = 4
    case heart = 2
    case joker = 99
    case diamond = 3
}

struct PartycakeState: JSONSerializable {
    let id: String
    let deck: [CardId]
    let dealerStep: PartycakeDealerStep
    let sides: [PartycakeSide]
    let innerPieceIds: [PartycakeInnerPieceID]
    let outerPieceIds: [PartycakeOuterPieceID]
    let innerOffset: Int
    let outerOffset: Int
}

struct PartycakeSide: JSONSerializable {
    let seat: PartycakeSeat
    let playerStep: PartycakePlayerStep
    let chips: Int
    let handCardIds: [CardId]
    let betLevel: PartycakeBetLevel?
    let putCardId: CardId?
    let lastCombo: PartycakeCombo
}
