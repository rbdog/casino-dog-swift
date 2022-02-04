//
//
//

import SwiftUI

final class OnboardingState: ObservableObject, JSONSerializable {
    @Published var faceImageName: String
    @Published var canRoll: Bool
    @Published var isRollingDice: Bool = false
    @Published var drink: DrinkId?
    @Published var stopDiceFace: DiceFace?

    // カスタムエンコード
    enum CodingKeys: String, CodingKey {
        case faceImageName
        case canRoll
        case isRollingDice
        case drink
        case stopDiceFace
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        faceImageName = try container.decode(String.self, forKey: .faceImageName)
        canRoll = try container.decode(Bool.self, forKey: .canRoll)
        isRollingDice = try container.decode(Bool.self, forKey: .isRollingDice)
        drink = try container.decode(DrinkId?.self, forKey: .drink)
        stopDiceFace = try container.decode(DiceFace?.self, forKey: .stopDiceFace)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(faceImageName, forKey: .faceImageName)
        try container.encode(canRoll, forKey: .canRoll)
        try container.encode(isRollingDice, forKey: .isRollingDice)
        try container.encode(drink, forKey: .drink)
        try container.encode(stopDiceFace, forKey: .stopDiceFace)
    }
    
    init(faceImageName: String = ImageName.Dice.face1.rawValue,
         canRoll: Bool = true,
         isRollingDice: Bool = false,
         drink: DrinkId? = nil,
         stopDiceFace: DiceFace? = nil) {
        self.faceImageName = faceImageName
        self.canRoll = canRoll
        self.isRollingDice = isRollingDice
        self.drink = drink
        self.stopDiceFace = stopDiceFace
    }
}
