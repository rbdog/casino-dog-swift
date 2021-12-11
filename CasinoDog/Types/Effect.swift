//
//
//

import SwiftUI


extension CardID {
    var suit: SuitID {
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
    
    var number: NumberID {
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
    
    var discription: String {
        switch self {
        case .back:
            return "裏面"
        case .blackJocker, .whiteJocker:
            return "ジョーカー"
        default:
            return "\(suit.discription) の \(number.discription)"
        }
    }
}

extension SuitID {
    var discription: String {
        switch self {
        case .back:
            return "裏面"
        case .spade:
            return "スペード"
        case .heart:
            return "ハート"
        case .diamond:
            return "ダイヤ"
        case .club:
            return "クラブ"
        case .joker:
            return "ジョーカー"
        }
    }
}

extension NumberID {
    var discription: String {
        switch self {
        case .back:
            return "裏面"
        case .num1:
            return "A"
        case .num2:
            return "2"
        case .num3:
            return "3"
        case .num4:
            return "4"
        case .num5:
            return "5"
        case .num6:
            return "6"
        case .num7:
            return "7"
        case .num8:
            return "8"
        case .num9:
            return "9"
        case .num10:
            return "10"
        case .num11:
            return "J"
        case .num12:
            return "Q"
        case .num13:
            return "K"
        case .joker:
            return "ジョーカー"
        }
    }
}

extension PokerPlusOuterPartID {
    var suit: SuitID {
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
    var number: NumberID {
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
    var suit: SuitID {
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

extension CardID {
    func effectImageName() -> String? {
        switch self.number {
        case .num1:
            return nil
        case .num11:
            return ImageName.Effect.jack.rawValue
        case .num12:
            return ImageName.Effect.queen.rawValue
        case .num13:
            return ImageName.Effect.king.rawValue
        default:
            return nil
        }
    }
    
    func effectImageSize() -> CGFloat {
        switch self.number {
        case .num1:
            return 0
        case .num11:
            return 100
        case .num12:
            return UIScreen.main.bounds.width - 30
        case .num13:
            return 170
        default:
            return 0
        }
    }
    
    func effectDuration() -> Double {
        switch self.number {
        case .num1:
            return 0
        case .num11:
            return 0.7
        case .num12:
            return 0.7
        case .num13:
            return 0.7
        default:
            return 0
        }
    }
    
    func flatImageName() -> String {
        switch self {
        case .back:
            return "Image not found"
        case .spade1:
            return ImageName.Score.Card.spade1.rawValue
        case .spade2:
            return "Image not found"
        case .spade3:
            return "Image not found"
        case .spade4:
            return "Image not found"
        case .spade5:
            return "Image not found"
        case .spade6:
            return "Image not found"
        case .spade7:
            return "Image not found"
        case .spade8:
            return "Image not found"
        case .spade9:
            return "Image not found"
        case .spade10:
            return "Image not found"
        case .spade11:
            return ImageName.Score.Card.spade11.rawValue
        case .spade12:
            return ImageName.Score.Card.spade12.rawValue
        case .spade13:
            return "Image not found"
        case .heart1:
            return ImageName.Score.Card.heart1.rawValue
        case .heart2:
            return "Image not found"
        case .heart3:
            return "Image not found"
        case .heart4:
            return "Image not found"
        case .heart5:
            return "Image not found"
        case .heart6:
            return "Image not found"
        case .heart7:
            return "Image not found"
        case .heart8:
            return "Image not found"
        case .heart9:
            return "Image not found"
        case .heart10:
            return "Image not found"
        case .heart11:
            return ImageName.Score.Card.heart11.rawValue
        case .heart12:
            return ImageName.Score.Card.heart12.rawValue
        case .heart13:
            return "Image not found"
        case .diamond1:
            return "Image not found"
        case .diamond2:
            return "Image not found"
        case .diamond3:
            return "Image not found"
        case .diamond4:
            return "Image not found"
        case .diamond5:
            return "Image not found"
        case .diamond6:
            return "Image not found"
        case .diamond7:
            return "Image not found"
        case .diamond8:
            return "Image not found"
        case .diamond9:
            return "Image not found"
        case .diamond10:
            return "Image not found"
        case .diamond11:
            return ImageName.Score.Card.diamond11.rawValue
        case .diamond12:
            return ImageName.Score.Card.diamond12.rawValue
        case .diamond13:
            return ImageName.Score.Card.diamond13.rawValue
        case .club1:
            return "Image not found"
        case .club2:
            return "Image not found"
        case .club3:
            return "Image not found"
        case .club4:
            return "Image not found"
        case .club5:
            return "Image not found"
        case .club6:
            return "Image not found"
        case .club7:
            return "Image not found"
        case .club8:
            return "Image not found"
        case .club9:
            return "Image not found"
        case .club10:
            return "Image not found"
        case .club11:
            return ImageName.Score.Card.club11.rawValue
        case .club12:
            return ImageName.Score.Card.club12.rawValue
        case .club13:
            return ImageName.Score.Card.club13.rawValue
        case .blackJocker:
            return "Image not found"
        case .whiteJocker:
            return "Image not found"
        }
    }
}

extension PokerPlusOuterPartID {
    func flatImageName() -> String {
        switch self {
        case .diamond12:
            return ImageName.Score.Outer.diamond12.rawValue
        case .club11:
            return ImageName.Score.Outer.club11.rawValue
        case .spade13:
            return ImageName.Score.Outer.spade13.rawValue
        case .heart1:
            return ImageName.Score.Outer.heart1.rawValue
        }
    }
}

extension PokerPlusInnerPartID {
    func flatImageName() -> String {
        switch self {
        case .club:
            return ImageName.Score.Inner.club.rawValue
        case .heart:
            return ImageName.Score.Inner.heart.rawValue
        case .joker:
            return ImageName.Score.Inner.joker.rawValue
        case .diamond:
            return ImageName.Score.Inner.diamond.rawValue
        }
    }
}
