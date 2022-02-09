//
//
//

import SwiftUI

final class PartycakeScoreUiState: ObservableObject, JSONSerializable {
    
    @Published var idToScroll: String = ""
    @Published var showMyScore: Bool = false
    
    let items: [PartycakeScoreUiItem]
    
    init(items: [PartycakeScoreUiItem]) {
        self.items = items
    }
    
    // カスタムエンコード
    enum CodingKeys: String, CodingKey {
        case idToScroll
        case showMyScore
        case items
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        idToScroll = try container.decode(String.self, forKey: .idToScroll)
        showMyScore = try container.decode(Bool.self, forKey: .showMyScore)
        items = try container.decode([PartycakeScoreUiItem].self, forKey: .items)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(idToScroll, forKey: .idToScroll)
        try container.encode(showMyScore, forKey: .showMyScore)
        try container.encode(items, forKey: .items)
    }
}

final class PartycakeScoreUiItem: ObservableObject, JSONSerializable  {
    let sort: Int
    let isMyScore: Bool
    let iconUrl: String
    let nickname: String
    @Published var totalChips: Int
    let bonusChips: Int
    let comboName: String
    let flatCardImageName: String
    let flatOuterImageName: String
    let flatInnerImageName: String

    init(sort: Int,
         isMyScore: Bool,
         iconUrl: String,
         nickname: String,
         totalChip: Int,
         bonusChip: Int,
         comboName: String,
         flatCardImageName: String,
         flatOuterImageName: String,
         flatInnerImageName: String) {
        self.sort = sort
        self.isMyScore = isMyScore
        self.iconUrl = iconUrl
        self.nickname = nickname
        self.totalChips = totalChip
        self.bonusChips = bonusChip
        self.comboName = comboName
        self.flatCardImageName = flatCardImageName
        self.flatOuterImageName = flatOuterImageName
        self.flatInnerImageName = flatInnerImageName
    }
    
    // カスタムエンコード
    enum CodingKeys: String, CodingKey {
        case sort
        case isMyScore
        case iconUrl
        case nickname
        case totalChips
        case bonusChips
        case comboName
        case flatCardImageName
        case flatOuterImageName
        case flatInnerImageName
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        sort = try container.decode(Int.self, forKey: .sort)
        isMyScore = try container.decode(Bool.self, forKey: .isMyScore)
        iconUrl = try container.decode(String.self, forKey: .iconUrl)
        nickname = try container.decode(String.self, forKey: .nickname)
        totalChips = try container.decode(Int.self, forKey: .totalChips)
        bonusChips = try container.decode(Int.self, forKey: .bonusChips)
        comboName = try container.decode(String.self, forKey: .comboName)
        flatCardImageName = try container.decode(String.self, forKey: .flatCardImageName)
        flatOuterImageName = try container.decode(String.self, forKey: .flatOuterImageName)
        flatInnerImageName = try container.decode(String.self, forKey: .flatInnerImageName)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(sort, forKey: .sort)
        try container.encode(isMyScore, forKey: .isMyScore)
        try container.encode(iconUrl, forKey: .iconUrl)
        try container.encode(nickname, forKey: .nickname)
        try container.encode(totalChips, forKey: .totalChips)
        try container.encode(bonusChips, forKey: .bonusChips)
        try container.encode(comboName, forKey: .comboName)
        try container.encode(flatCardImageName, forKey: .flatCardImageName)
        try container.encode(flatOuterImageName, forKey: .flatOuterImageName)
        try container.encode(flatInnerImageName, forKey: .flatInnerImageName)
    }
}
