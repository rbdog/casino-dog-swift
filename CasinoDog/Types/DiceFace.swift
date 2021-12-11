//
//
//

import Foundation

enum DiceFace: Int, JSONSerializable {
    case zero = 0
    case one = 1
    case two = 2
    case three = 3
    case four = 4
    case five = 5
    case six = 6

    var imageName: ImageName.Dice {
        switch self {
        case .one: return .face1
        case .two: return .face2
        case .three: return .face3
        case .four: return .face4
        case .five: return .face5
        case .six: return .face6
        case .zero: return .face0
        }
    }

    static var nomalCases: [Self] {
        return [
            .one,
            .two,
            .three,
            .four,
            .five,
            .six
        ]
    }
}
