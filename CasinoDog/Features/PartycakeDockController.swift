//
//
//

import Foundation

class PartycakeDockController {
    
    func onTapCard(card: CardId) {
        DispatchQueue.main.async {
            if appState.partycakePlayUi.dockSelectedCard == card {
                // すでに選択中のアイテムを解除
                appState.partycakePlayUi.dockSelectedCard = nil
            } else {
                // 未選択から、もしくは他のアイテムから変更
                appState.partycakePlayUi.dockSelectedCard = card
            }
        }
    }
    
    func onTapBetLevel(level: PartycakeBetLevel) {
        DispatchQueue.main.async {
            if appState.partycakePlayUi.dockSelectedBetLevel == level {
                // すでに選択中のアイテムを解除
                appState.partycakePlayUi.dockSelectedBetLevel = nil
            } else {
                // 未選択から、もしくは他のアイテムから変更
                appState.partycakePlayUi.dockSelectedBetLevel = level
            }
        }
    }
    
    func onTapBetButton() {
        let level = appState.partycakePlayUi.dockSelectedBetLevel!
        PartycakeBetController().bet(level: level)
    }
    
    func onTapPutButton() {
        let card = appState.partycakePlayUi.dockSelectedCard!
        PartycakePutController().put(card: card)
    }
    
    func card(of cardId: Int) -> CardId {
        let card = CardId(rawValue: cardId)!
        return card
    }
    
    func betLevel(of betLevelId: String) -> PartycakeBetLevel {
        let levelValue = Int(betLevelId)!
        let level = PartycakeBetLevel(rawValue: levelValue)!
        return level
    }
    
    func canBet(level: PartycakeBetLevel) -> Bool {
        let myUserId = appState.account.loginUser.id
        let mySeat = appState.partycakeSystem.players.first(where: {$0.user_id == myUserId})!.seat
        let mySide = appState.partycakeSystem.partycakeState.sides.first(where: {$0.seat.rawValue == mySeat})!
        let betCost = level.betCost()
        return mySide.chips >= betCost
    }
    
}

extension PartycakeBetLevel {
    func imageName() -> String {
        switch self {
        case .min:
            return ImageName.Chip.chip3.rawValue
        case .mid:
            return ImageName.Chip.chip5.rawValue
        case .max:
            return ImageName.Chip.chip7.rawValue
        }
    }
    
    func betCost() -> Int {
        switch self {
        case .min:
            return 3
        case .mid:
            return 5
        case .max:
            return 7
        }
    }
    
    func cardCount() -> Int {
        switch self {
        case .min:
            return 1
        case .mid:
            return 2
        case .max:
            return 3
        }
    }
}

extension CardId {
    func imageName() -> String {
        switch self {
        case .back:
            return ImageName.Card.back.rawValue
        case .spade1:
            return ImageName.Card.spade1.rawValue
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
            return ImageName.Card.spade11.rawValue
        case .spade12:
            return ImageName.Card.spade12.rawValue
        case .spade13:
            return "Image not found"
        case .heart1:
            return ImageName.Card.heart1.rawValue
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
            return ImageName.Card.heart11.rawValue
        case .heart12:
            return ImageName.Card.heart12.rawValue
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
            return ImageName.Card.diamond11.rawValue
        case .diamond12:
            return ImageName.Card.diamond12.rawValue
        case .diamond13:
            return ImageName.Card.diamond13.rawValue
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
            return ImageName.Card.club11.rawValue
        case .club12:
            return ImageName.Card.club12.rawValue
        case .club13:
            return ImageName.Card.club13.rawValue
        case .blackJocker:
            return "Image not found"
        case .whiteJocker:
            return "Image not found"
        }
    }
}
