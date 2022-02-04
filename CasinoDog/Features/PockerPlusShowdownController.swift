//
//
//

import Foundation
import SwiftUI

struct PokerPlusShowdownController {
    
    func startShowdown(
        animationList: [PokerPlusShowdownAnimation],
        scoreList: [PokerPlusScore]
    ) {
        let delay = 1.0
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            // 全てのプレイヤーのベットレベルを削除
            for i in 0..<appState.pokerPlusPlayUi.sides.count {
                appState.pokerPlusPlayUi.sides[i].playerBetLevel = nil
            }
            // ハンドカードを回収
            withAnimation {
                appState.pokerPlusPlayUi.dockHandCards.removeAll()
            }
            
            // ボードを拡大
            self.focusToBoard() {
                // Showdown
                self.showdownEachSeat(animationList: animationList) {
                    // Judge
                    let myUserId = appState.account.loginUser.id
                    let myScore = scoreList.first(where: {$0.user_id == myUserId })!
                    self.startJudgeAnimation(myScore: myScore) {
                        // ScoreList
                        self.showScoreList(scoreList: scoreList) {
                            // Pay
                            self.startPay {
                                appState.pokerPlusScoreUi?.idToScroll = ScoreListView.Const.OK_BUTTON
                            }
                        }
                    }
                }
            }
        }
    }
    
    func focusToBoard(completion: @escaping () -> Void) {
        let duration: Double = 0.3
        // メインスレッド実行明示が必要
        DispatchQueue.main.async {
            withAnimation(.linear(duration: duration)) {
                appState.pokerPlusPlayUi.focusTarget = .board
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + duration + 0.2) {
            completion()
        }
    }
    
    func showdownEachSeat(
        animationList: [PokerPlusShowdownAnimation],
        completion: @escaping () -> Void
    ) {
        
        let animation1 = animationList.first(where: {$0.seat == 1})!
        let animation2 = animationList.first(where: {$0.seat == 2})!
        let animation3 = animationList.first(where: {$0.seat == 3})!
        let animation4 = animationList.first(where: {$0.seat == 4})!
        
        self.showdownSeat(animation: animation1) {
            self.showdownSeat(animation: animation2) {
                self.showdownSeat(animation: animation3) {
                    self.showdownSeat(animation: animation4) {
                        completion()
                    }
                }
            }
        }
    }
    
    func showdownSeat(
        animation: PokerPlusShowdownAnimation,
        completion: @escaping () -> Void
    ) {
        // 裏面にしたカードで差し替え
        let card = CardID(rawValue: animation.put_card_id)!
        
        DispatchQueue.main.async {
            appState.pokerPlusPlayUi.sides.first(where: {$0.seat.rawValue == animation.seat})!.putCardDegree = 180
            appState.pokerPlusPlayUi.sides.first(where: {$0.seat.rawValue == animation.seat})!.putCard = card
        }
        
        self.openCard(at: animation.seat) {
            self.rotateWheel(
                by: card,
                oldOuterDegree: Double(animation.old_outer_offset),
                newOuterDegree: Double(animation.new_outer_offset),
                oldInnerDegree: Double(animation.old_inner_offset),
                newInnerDegree: Double(animation.new_inner_offset)
            ) {
                completion()
            }
        }
    }
    
    func openCard(at seat: Int, completion: @escaping (() -> Void)) {
        let duration: Double = 1
        DispatchQueue.main.async {
            withAnimation(.easeInOut(duration: duration)) {
                appState.pokerPlusPlayUi.sides.first(where: {$0.seat.rawValue == seat})!.putCardDegree = 0
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            completion()
        }
    }
    
    func rotateWheel(
        by card: CardID,
        oldOuterDegree: Double,
        newOuterDegree: Double?,
        oldInnerDegree: Double,
        newInnerDegree: Double?,
        completion: @escaping (() -> Void)
    ) {
        
        let duration: Double = card.effectDuration()
        
        self.performRotateEffect(of: card, duration: duration)
        
        DispatchQueue.main.async {
            if let newOuterDegree = newOuterDegree {
                appState.pokerPlusPlayUi.outerWheelDegree = oldOuterDegree
                withAnimation(.easeIn(duration: duration)) {
                    appState.pokerPlusPlayUi.outerWheelDegree = newOuterDegree
                }
            }
            if let newInnerDegree = newInnerDegree {
                appState.pokerPlusPlayUi.innerWheelDegree = oldInnerDegree
                withAnimation(.easeIn(duration: duration)) {
                    appState.pokerPlusPlayUi.innerWheelDegree = newInnerDegree
                }
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + duration + 0.1) {
            appState.pokerPlusPlayUi.cardEffectImageName = nil
            completion()
        }
    }
    
    func performRotateEffect(of card: CardID, duration: Double) {
        guard let imageName = card.effectImageName() else {
            return
        }
        DispatchQueue.main.async {
            appState.pokerPlusPlayUi.cardEffectImageSize = card.effectImageSize()
            appState.pokerPlusPlayUi.cardEffectImageName = imageName
        }
    }
    
    func startJudgeAnimation(myScore: PokerPlusScore, completion: @escaping () -> Void) {
        
        let comboName = myScore.combo_name
        let card = CardID(rawValue: myScore.put_card_id)!
        let innerId = PokerPlusInnerPartID(rawValue: myScore.inner_id)!
        let outerId = PokerPlusOuterPartID(rawValue: myScore.outer_id)!
        
        performComboEffect(
            comboName: comboName,
            card: card,
            innerId: innerId,
            outerId: outerId
        ) {
            completion()
        }
    }
    
    func performComboEffect(
        comboName: String,
        card: CardID,
        innerId: PokerPlusInnerPartID,
        outerId: PokerPlusOuterPartID,
        completion: @escaping () -> Void
    ) {
        DispatchQueue.main.async {
            appState.pokerPlusPlayUi.cardEffectImageName = nil
            appState.pokerPlusPlayUi.cardEffectImageSize = UIScreen.main.bounds.width - 20
            appState.pokerPlusPlayUi.spotlightMySide = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation {
                appState.pokerPlusPlayUi.flatCardImageName = card.flatImageName()
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            withAnimation {
                appState.pokerPlusPlayUi.flatOuterImageName = outerId.flatImageName()
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
            withAnimation {
                appState.pokerPlusPlayUi.flatInnerImageName = innerId.flatImageName()
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) {
            withAnimation {
                appState.pokerPlusPlayUi.comboName = comboName
            }
            appState.pokerPlusPlayUi.comboNameWaveIndex = 0
            withAnimation {
                appState.pokerPlusPlayUi.comboNameWaveIndex = 6
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
            appState.pokerPlusPlayUi.spotlightMySide = false
            appState.pokerPlusPlayUi.cardEffectImageName = nil
            appState.pokerPlusPlayUi.cardEffectImageSize = 0
            appState.pokerPlusPlayUi.flatCardImageName = nil
            appState.pokerPlusPlayUi.flatOuterImageName = nil
            appState.pokerPlusPlayUi.flatInnerImageName = nil
            appState.pokerPlusPlayUi.comboName = nil
            appState.pokerPlusPlayUi.comboNameWaveIndex = 0
            completion()
        }
    }
    
    func showScoreList(scoreList: [PokerPlusScore], completion: @escaping () -> Void) {
        // ボーナスが大きい順に並べる
        let sorted: [PokerPlusScore] = scoreList.sorted(by: {
            return $0.bonus_chips > $1.bonus_chips
        })
        
        let scoreUiItems = sorted.enumerated().map { score -> PokerPlusScoreUiItem in
            let card = CardID(rawValue: score.element.put_card_id)!
            let innerId = PokerPlusInnerPartID(rawValue: score.element.inner_id)!
            let outerId = PokerPlusOuterPartID(rawValue: score.element.outer_id)!
            let myUserId = appState.account.loginUser.id
            let isMyScore = score.element.user_id == myUserId
            let flatOuterImageName = outerId.flatImageName()
            let flatInnerImageName = innerId.flatImageName()
            let player = appState.pokerPlusSystem.players.first(where: {$0.user_id == score.element.user_id})!
            
            let item = PokerPlusScoreUiItem(
                sort: score.offset,
                isMyScore: isMyScore,
                iconUrl: player.icon_url,
                nickname: player.nickname,
                totalChip: score.element.old_total_chips,
                bonusChip: score.element.bonus_chips,
                comboName: score.element.combo_name,
                flatCardImageName: card.flatImageName(),
                flatOuterImageName: flatOuterImageName,
                flatInnerImageName: flatInnerImageName
            )
            return item
        }
        
        // スコア画面を表示
        let scoreUiState = PokerPlusScoreUiState(items: scoreUiItems)
        appState.pokerPlusScoreUi = scoreUiState
        
        // 自分のスコアを表示
        self.openMyScore() {
            completion()
        }
    }
    
    func openMyScore(completion: @escaping (() -> Void)) {
        
        let duration: Double = 0.3
        DispatchQueue.main.async {
            withAnimation(.linear(duration: duration)) {
                appState.pokerPlusScoreUi.showMyScore = true
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            completion()
        }
    }
    
    func startPay(completion: @escaping (() -> Void)) {
        
        let duration: Double = 1.5
        DispatchQueue.main.async {
            withAnimation(.linear(duration: duration)) {
                for i in 0..<appState.pokerPlusScoreUi.items.count {
                    let bonusChips = appState.pokerPlusScoreUi.items[i].bonusChips
                    appState.pokerPlusScoreUi.items[i].totalChips += bonusChips
                }
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            completion()
        }
    }
    
    func onTapScoreOK() {
        
        appState.pokerPlusScoreUi = nil
        
        let duration: Double = 0.3
        DispatchQueue.main.async {
            withAnimation(.easeOut(duration: duration)) {
                appState.pokerPlusPlayUi.focusTarget = .all
                
                // UIを最新化
                let systemState = appState.pokerPlusSystem!
                for i in 0..<appState.pokerPlusPlayUi.sides.count {
                    let uiSide = appState.pokerPlusPlayUi.sides[i]
                    
                    // BetLevelをリセット
                    uiSide.playerBetLevel = nil
                    // 増減した Chips を UI表示
                    let systemSide = systemState.pokerPlusState.sides.first(where: {$0.seat == uiSide.seat})!
                    uiSide.chips = systemSide.chips
                }
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + duration + 0.2) {
            PokerPlusEventController().didShowdown()
        }
    }
}
