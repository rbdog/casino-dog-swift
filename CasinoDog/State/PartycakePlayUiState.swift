//
//
//

import SwiftUI

final class PartycakePlayUiState: ObservableObject, JSONSerializable {
    
    @Published var focusTarget: PokrtPlusPlayUiFocusTarget = .all
    @Published var waitingOthers: Bool = false
    @Published var canExit: Bool = true
    @Published var showExitModal: Bool = false
    @Published var innerCakeDegree: Double = 0
    @Published var outerCakeDegree: Double = 0
    @Published var dockHandCards: [CardId] = []
    @Published var dockBetLevels: [PartycakeBetLevel] = []
    @Published var dockIsLocked: Bool = false
    @Published var dockSelectedCard: CardId?
    @Published var dockSelectedBetLevel: PartycakeBetLevel?
    
    // Effect
    @Published var spotlightMySide: Bool = false
    @Published var cardEffectImageName: String?
    @Published var cardEffectImageSize: Double = 0
    @Published var flatCardImageName: String?
    @Published var flatOuterImageName: String?
    @Published var flatInnerImageName: String?
    @Published var comboName: String?
    @Published var comboNameWaveIndex: Int = 0
    
    var sides: [PartycakePlayUiSide] = []
    
    init() {
    }
    
    // カスタムエンコード
    enum CodingKeys: String, CodingKey {
        case focusTarget
        case waitingOthers
        case canExit
        case showExitModal
        case innerCakeDegree
        case outerCakeDegree
        case dockHandCards
        case dockBetLevels
        case dockIsLocked
        case dockSelectedCard
        case dockSelectedBetLevel
        case spotlightMySide
        case cardEffectImageName
        case cardEffectImageSize
        case flatCardImageName
        case flatOuterImageName
        case flatInnerImageName
        case comboName
        case comboNameWaveIndex
        case sides
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        focusTarget = try container.decode(PokrtPlusPlayUiFocusTarget.self, forKey: .focusTarget)
        waitingOthers = try container.decode(Bool.self, forKey: .waitingOthers)
        canExit = try container.decode(Bool.self, forKey: .canExit)
        showExitModal = try container.decode(Bool.self, forKey: .showExitModal)
        innerCakeDegree = try container.decode(Double.self, forKey: .innerCakeDegree)
        outerCakeDegree = try container.decode(Double.self, forKey: .outerCakeDegree)
        dockHandCards = try container.decode([CardId].self, forKey: .dockHandCards)
        dockBetLevels = try container.decode([PartycakeBetLevel].self, forKey: .dockBetLevels)
        dockIsLocked = try container.decode(Bool.self, forKey: .dockIsLocked)
        dockSelectedCard = try container.decode(CardId?.self, forKey: .dockSelectedCard)
        dockSelectedBetLevel = try container.decode(PartycakeBetLevel?.self, forKey: .dockSelectedBetLevel)
        spotlightMySide = try container.decode(Bool.self, forKey: .spotlightMySide)
        cardEffectImageName = try container.decode(String?.self, forKey: .cardEffectImageName)
        cardEffectImageSize = try container.decode(Double.self, forKey: .cardEffectImageSize)
        flatCardImageName = try container.decode(String?.self, forKey: .flatCardImageName)
        flatOuterImageName = try container.decode(String?.self, forKey: .flatOuterImageName)
        flatInnerImageName = try container.decode(String?.self, forKey: .flatInnerImageName)
        comboName = try container.decode(String?.self, forKey: .comboName)
        comboNameWaveIndex = try container.decode(Int.self, forKey: .comboNameWaveIndex)
        sides = try container.decode([PartycakePlayUiSide].self, forKey: .sides)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(focusTarget, forKey: .focusTarget)
        try container.encode(waitingOthers, forKey: .waitingOthers)
        try container.encode(canExit, forKey: .canExit)
        try container.encode(showExitModal, forKey: .showExitModal)
        try container.encode(innerCakeDegree, forKey: .innerCakeDegree)
        try container.encode(outerCakeDegree, forKey: .outerCakeDegree)
        try container.encode(dockHandCards, forKey: .dockHandCards)
        try container.encode(dockBetLevels, forKey: .dockBetLevels)
        try container.encode(dockIsLocked, forKey: .dockIsLocked)
        try container.encode(dockSelectedCard, forKey: .dockSelectedCard)
        try container.encode(dockSelectedBetLevel, forKey: .dockSelectedBetLevel)
        try container.encode(spotlightMySide, forKey: .spotlightMySide)
        try container.encode(cardEffectImageName, forKey: .cardEffectImageName)
        try container.encode(cardEffectImageSize, forKey: .cardEffectImageSize)
        try container.encode(flatCardImageName, forKey: .flatCardImageName)
        try container.encode(flatOuterImageName, forKey: .flatOuterImageName)
        try container.encode(flatInnerImageName, forKey: .flatInnerImageName)
        try container.encode(comboName, forKey: .comboName)
        try container.encode(comboNameWaveIndex, forKey: .comboNameWaveIndex)
        try container.encode(sides, forKey: .sides)
    }
}

enum PokrtPlusPlayUiFocusTarget: Int, JSONSerializable {
    case all
    case board
}

final class PartycakePlayUiSide: ObservableObject, JSONSerializable {
    let seat: PartycakeSeat
    @Published var putCard: CardId?
    @Published var putCardDegree: Double = 0
    @Published var playerNickname: String = "--"
    @Published var playerIconUrl: String = ""
    @Published var playerBetLevel: PartycakeBetLevel?
    @Published var chips: Int = 0
    
    init(seat: PartycakeSeat) {
        self.seat = seat
    }
    
    // カスタムエンコード
    enum CodingKeys: String, CodingKey {
        case seat
        case putCard
        case putCardDegree
        case playerNickname
        case playerIconUrl
        case playerBetLevel
        case chips
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        seat = try container.decode(PartycakeSeat.self, forKey: .seat)
        putCard = try container.decode(CardId?.self, forKey: .putCard)
        putCardDegree = try container.decode(Double.self, forKey: .putCardDegree)
        playerNickname = try container.decode(String.self, forKey: .playerNickname)
        playerIconUrl =  try container.decode(String.self, forKey: .playerIconUrl)
        playerBetLevel = try container.decode(PartycakeBetLevel?.self, forKey: .playerBetLevel)
        chips = try container.decode(Int.self, forKey: .chips)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(seat, forKey: .seat)
        try container.encode(putCard, forKey: .putCard)
        try container.encode(putCardDegree, forKey: .putCardDegree)
        try container.encode(playerNickname, forKey: .playerNickname)
        try container.encode(playerIconUrl, forKey: .playerIconUrl)
        try container.encode(playerBetLevel, forKey: .playerBetLevel)
        try container.encode(chips, forKey: .chips)
    }
}
