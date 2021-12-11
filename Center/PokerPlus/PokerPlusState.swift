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

enum CardID: Int, JSONSerializable {
    case back = 1000
    case spade1 = 1001
    case spade2 = 1002
    case spade3 = 1003
    case spade4 = 1004
    case spade5 = 1005
    case spade6 = 1006
    case spade7 = 1007
    case spade8 = 1008
    case spade9 = 1009
    case spade10 = 1010
    case spade11 = 1011
    case spade12 = 1012
    case spade13 = 1013
    case heart1 = 2001
    case heart2 = 2002
    case heart3 = 2003
    case heart4 = 2004
    case heart5 = 2005
    case heart6 = 2006
    case heart7 = 2007
    case heart8 = 2008
    case heart9 = 2009
    case heart10 = 2010
    case heart11 = 2011
    case heart12 = 2012
    case heart13 = 2013
    case diamond1 = 3001
    case diamond2 = 3002
    case diamond3 = 3003
    case diamond4 = 3004
    case diamond5 = 3005
    case diamond6 = 3006
    case diamond7 = 3007
    case diamond8 = 3008
    case diamond9 = 3009
    case diamond10 = 3010
    case diamond11 = 3011
    case diamond12 = 3012
    case diamond13 = 3013
    case club1 = 4001
    case club2 = 4002
    case club3 = 4003
    case club4 = 4004
    case club5 = 4005
    case club6 = 4006
    case club7 = 4007
    case club8 = 4008
    case club9 = 4009
    case club10 = 4010
    case club11 = 4011
    case club12 = 4012
    case club13 = 4013
    case blackJocker = 9098
    case whiteJocker = 9099
}

enum PokerPlusOuterPartID: Int, JSONSerializable {
    case diamond12 = 3012
    case club11 = 4011
    case spade13 = 1013
    case heart1 = 2001
}

enum PokerPlusInnerPartID: Int, JSONSerializable {
    case club = 4
    case heart = 2
    case joker = 99
    case diamond = 3
}


struct PokerPlusState: JSONSerializable {
    let id: String
    var deck: [CardID]
    var dealerStep: PokerPlusDealerStep
    var sides: [PokerPlusSide]
    var wheel: PokerPlusWheel
}

struct PokerPlusSide: JSONSerializable {
    let seat: PokerPlusSeat
    var playerStep: PokerPlusPlayerStep
    var chips: Int
    var handCardIds: [CardID]
    var betLevel: PokerPlusBetLevel?
    var putCardId: CardID?
    var lastCombo: PokerPlusCombo
}

struct PokerPlusWheel: JSONSerializable {
    let innerPartIds: [PokerPlusInnerPartID]
    let outerPartIds: [PokerPlusOuterPartID]
    var innerOffset: Int
    var outerOffset: Int
}
