//
//
//

import Foundation

class PokerPlusDockController {
    
    func onTapCard(card: CardID) {
        DispatchQueue.main.async {
            if appState.pokerPlusPlayUi.dockSelectedCard == card {
                // すでに選択中のアイテムを解除
                appState.pokerPlusPlayUi.dockSelectedCard = nil
            } else {
                // 未選択から、もしくは他のアイテムから変更
                appState.pokerPlusPlayUi.dockSelectedCard = card
            }
        }
    }
    
    func onTapBetLevel(level: PokerPlusBetLevel) {
        DispatchQueue.main.async {
            if appState.pokerPlusPlayUi.dockSelectedBetLevel == level {
                // すでに選択中のアイテムを解除
                appState.pokerPlusPlayUi.dockSelectedBetLevel = nil
            } else {
                // 未選択から、もしくは他のアイテムから変更
                appState.pokerPlusPlayUi.dockSelectedBetLevel = level
            }
        }
    }
    
    func onTapBetButton() {
        let level = appState.pokerPlusPlayUi.dockSelectedBetLevel!
        PokerPlusBetController().bet(level: level)
    }
    
    func onTapPutButton() {
        let card = appState.pokerPlusPlayUi.dockSelectedCard!
        PokerPlusPutController().put(card: card)
    }
    
    func card(of cardId: Int) -> CardID {
        let card = CardID(rawValue: cardId)!
        return card
    }
    
    func betLevel(of betLevelId: String) -> PokerPlusBetLevel {
        let levelValue = Int(betLevelId)!
        let level = PokerPlusBetLevel(rawValue: levelValue)!
        return level
    }
    
    func canBet(level: PokerPlusBetLevel) -> Bool {
        let myUserId = appState.account.loginUser.id
        let mySeat = appState.pokerPlusSystem.players.first(where: {$0.user_id == myUserId})!.seat
        let mySide = appState.pokerPlusSystem.pokerPlusState.sides.first(where: {$0.seat.rawValue == mySeat})!
        let betCost = level.betCost()
        return mySide.chips >= betCost
    }
    
}

extension PokerPlusBetLevel {
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

extension CardID {
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
