//
//
//

enum PokerPlusBetLevel: Int, JSONSerializable {
    case min = 0
    case mid = 1
    case max = 2
}

enum PokerPlusSeat: Int, JSONSerializable {
    case s1 = 1
    case s2 = 2
    case s3 = 3
    case s4 = 4
}

enum PokerPlusDealerStep: Int, JSONSerializable {
    case waitingBet = 0
    case shuffle = 1
    case waitingPut = 2
    case showdown = 3
}

enum PokerPlusPlayerStep: Int, JSONSerializable {
    case bet = 0
    case waitingShuffle = 1
    case put = 2
    case waitingShowdown = 3
}

enum PokerPlusCombo: Int, JSONSerializable {
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

enum CardId: Int, JSONSerializable {
    case back = 100
    case spade1 = 101
    case spade2 = 102
    case spade3 = 103
    case spade4 = 104
    case spade5 = 105
    case spade6 = 106
    case spade7 = 107
    case spade8 = 108
    case spade9 = 109
    case spade10 = 110
    case spade11 = 111
    case spade12 = 112
    case spade13 = 113
    case heart1 = 201
    case heart2 = 202
    case heart3 = 203
    case heart4 = 204
    case heart5 = 205
    case heart6 = 206
    case heart7 = 207
    case heart8 = 208
    case heart9 = 209
    case heart10 = 210
    case heart11 = 211
    case heart12 = 212
    case heart13 = 213
    case diamond1 = 301
    case diamond2 = 302
    case diamond3 = 303
    case diamond4 = 304
    case diamond5 = 305
    case diamond6 = 306
    case diamond7 = 307
    case diamond8 = 308
    case diamond9 = 309
    case diamond10 = 310
    case diamond11 = 311
    case diamond12 = 312
    case diamond13 = 313
    case club1 = 401
    case club2 = 402
    case club3 = 403
    case club4 = 404
    case club5 = 405
    case club6 = 406
    case club7 = 407
    case club8 = 408
    case club9 = 409
    case club10 = 410
    case club11 = 411
    case club12 = 412
    case club13 = 413
    case blackJocker = 998
    case whiteJocker = 999
}

enum PokerPlusOuterPartID: Int, JSONSerializable {
    case diamond12 = 312
    case club11 = 411
    case spade13 = 113
    case heart1 = 201
}

enum PokerPlusInnerPartID: Int, JSONSerializable {
    case club = 4
    case heart = 2
    case joker = 99
    case diamond = 3
}


struct PokerPlusState: JSONSerializable {
    let id: String
    var deck: [CardId]
    var dealerStep: PokerPlusDealerStep
    var sides: [PokerPlusSide]
    var wheel: PokerPlusWheel
}

struct PokerPlusSide: JSONSerializable {
    let seat: PokerPlusSeat
    var playerStep: PokerPlusPlayerStep
    var chips: Int
    var handCardIds: [CardId]
    var betLevel: PokerPlusBetLevel?
    var putCardId: CardId?
    var lastCombo: PokerPlusCombo
}

struct PokerPlusWheel: JSONSerializable {
    let innerPartIds: [PokerPlusInnerPartID]
    let outerPartIds: [PokerPlusOuterPartID]
    var innerOffset: Int
    var outerOffset: Int
}
