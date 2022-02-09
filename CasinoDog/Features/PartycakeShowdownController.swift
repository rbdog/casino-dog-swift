//
//
//

import Foundation
import SwiftUI

struct PartycakeShowdownController {
    
    func startShowdown(
        animationList: [PartycakeShowdownAnimation],
        scoreList: [PartycakeScore]
    ) {
        let delay = 1.0
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            // 全てのプレイヤーのベットレベルを削除
            for i in 0..<appState.partycakePlayUi.sides.count {
                appState.partycakePlayUi.sides[i].playerBetLevel = nil
            }
            // ハンドカードを回収
            withAnimation {
                appState.partycakePlayUi.dockHandCards.removeAll()
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
                                appState.partycakeScoreUi?.idToScroll = ScoreListView.Const.OK_BUTTON
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
                appState.partycakePlayUi.focusTarget = .board
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + duration + 0.2) {
            completion()
        }
    }
    
    func showdownEachSeat(
        animationList: [PartycakeShowdownAnimation],
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
        animation: PartycakeShowdownAnimation,
        completion: @escaping () -> Void
    ) {
        // 裏面にしたカードで差し替え
        let card = CardId(rawValue: animation.put_card_id)!
        
        DispatchQueue.main.async {
            appState.partycakePlayUi.sides.first(where: {$0.seat.rawValue == animation.seat})!.putCardDegree = 180
            appState.partycakePlayUi.sides.first(where: {$0.seat.rawValue == animation.seat})!.putCard = card
        }
        
        self.openCard(at: animation.seat) {
            self.rotateCake(
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
                appState.partycakePlayUi.sides.first(where: {$0.seat.rawValue == seat})!.putCardDegree = 0
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            completion()
        }
    }
    
    func rotateCake(
        by card: CardId,
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
                appState.partycakePlayUi.outerCakeDegree = oldOuterDegree
                withAnimation(.easeIn(duration: duration)) {
                    appState.partycakePlayUi.outerCakeDegree = newOuterDegree
                }
            }
            if let newInnerDegree = newInnerDegree {
                appState.partycakePlayUi.innerCakeDegree = oldInnerDegree
                withAnimation(.easeIn(duration: duration)) {
                    appState.partycakePlayUi.innerCakeDegree = newInnerDegree
                }
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + duration + 0.1) {
            appState.partycakePlayUi.cardEffectImageName = nil
            completion()
        }
    }
    
    func performRotateEffect(of card: CardId, duration: Double) {
        guard let imageName = card.effectImageName() else {
            return
        }
        DispatchQueue.main.async {
            appState.partycakePlayUi.cardEffectImageSize = card.effectImageSize()
            appState.partycakePlayUi.cardEffectImageName = imageName
        }
    }
    
    func startJudgeAnimation(myScore: PartycakeScore, completion: @escaping () -> Void) {
        
        let comboName = myScore.combo_name
        let card = CardId(rawValue: myScore.put_card_id)!
        let innerId = PartycakeInnerPieceID(rawValue: myScore.inner_id)!
        let outerId = PartycakeOuterPieceID(rawValue: myScore.outer_id)!
        
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
        card: CardId,
        innerId: PartycakeInnerPieceID,
        outerId: PartycakeOuterPieceID,
        completion: @escaping () -> Void
    ) {
        DispatchQueue.main.async {
            appState.partycakePlayUi.cardEffectImageName = nil
            appState.partycakePlayUi.cardEffectImageSize = UIScreen.main.bounds.width - 20
            appState.partycakePlayUi.spotlightMySide = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation {
                appState.partycakePlayUi.flatCardImageName = card.flatImageName()
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            withAnimation {
                appState.partycakePlayUi.flatOuterImageName = outerId.flatImageName()
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
            withAnimation {
                appState.partycakePlayUi.flatInnerImageName = innerId.flatImageName()
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) {
            withAnimation {
                appState.partycakePlayUi.comboName = comboName
            }
            appState.partycakePlayUi.comboNameWaveIndex = 0
            withAnimation {
                appState.partycakePlayUi.comboNameWaveIndex = 6
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
            appState.partycakePlayUi.spotlightMySide = false
            appState.partycakePlayUi.cardEffectImageName = nil
            appState.partycakePlayUi.cardEffectImageSize = 0
            appState.partycakePlayUi.flatCardImageName = nil
            appState.partycakePlayUi.flatOuterImageName = nil
            appState.partycakePlayUi.flatInnerImageName = nil
            appState.partycakePlayUi.comboName = nil
            appState.partycakePlayUi.comboNameWaveIndex = 0
            completion()
        }
    }
    
    func showScoreList(scoreList: [PartycakeScore], completion: @escaping () -> Void) {
        // ボーナスが大きい順に並べる
        let sorted: [PartycakeScore] = scoreList.sorted(by: {
            return $0.bonus_chips > $1.bonus_chips
        })
        
        let scoreUiItems = sorted.enumerated().map { score -> PartycakeScoreUiItem in
            let card = CardId(rawValue: score.element.put_card_id)!
            let innerId = PartycakeInnerPieceID(rawValue: score.element.inner_id)!
            let outerId = PartycakeOuterPieceID(rawValue: score.element.outer_id)!
            let myUserId = appState.account.loginUser.id
            let isMyScore = score.element.user_id == myUserId
            let flatOuterImageName = outerId.flatImageName()
            let flatInnerImageName = innerId.flatImageName()
            let player = appState.partycakeSystem.players.first(where: {$0.user_id == score.element.user_id})!
            
            let item = PartycakeScoreUiItem(
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
        let scoreUiState = PartycakeScoreUiState(items: scoreUiItems)
        appState.partycakeScoreUi = scoreUiState
        
        // 自分のスコアを表示
        self.openMyScore() {
            completion()
        }
    }
    
    func openMyScore(completion: @escaping (() -> Void)) {
        
        let duration: Double = 0.3
        DispatchQueue.main.async {
            withAnimation(.linear(duration: duration)) {
                appState.partycakeScoreUi.showMyScore = true
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
                for i in 0..<appState.partycakeScoreUi.items.count {
                    let bonusChips = appState.partycakeScoreUi.items[i].bonusChips
                    appState.partycakeScoreUi.items[i].totalChips += bonusChips
                }
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            completion()
        }
    }
    
    func onTapScoreOK() {
        
        appState.partycakeScoreUi = nil
        
        let duration: Double = 0.3
        DispatchQueue.main.async {
            withAnimation(.easeOut(duration: duration)) {
                appState.partycakePlayUi.focusTarget = .all
                
                // UIを最新化
                let systemState = appState.partycakeSystem!
                for i in 0..<appState.partycakePlayUi.sides.count {
                    let uiSide = appState.partycakePlayUi.sides[i]
                    
                    // BetLevelをリセット
                    uiSide.playerBetLevel = nil
                    // 増減した Chips を UI表示
                    let systemSide = systemState.partycakeState.sides.first(where: {$0.seat == uiSide.seat})!
                    uiSide.chips = systemSide.chips
                }
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + duration + 0.2) {
            PartycakeEventController().didShowdown()
        }
    }
}
