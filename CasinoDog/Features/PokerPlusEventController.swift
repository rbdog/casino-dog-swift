//
//
//

import Foundation
import SwiftUI

class PokerPlusEventController {
    
    func play(secretId: String?) {
        // Connection オブイェクトを生成
        let myUserId = appState.account.loginUser.id
        appState.pokerPlusConnection = PokerPlusConnection(url: "test", userId: myUserId)
        Task {
            // 自身を observer に設定してから接続
            appState.pokerPlusConnection.observer = self
            await appState.pokerPlusConnection.connect()
            
            if let secretId = secretId {
                // すでにプレイ中のゲームがある時
                resumePlay(secretId: secretId) {
                    fatalError("resume play でエラーが発生しました")
                }
            } else {
                // まだプレイ中のゲームがない時
                // マッチングから
                appState.matching = MatchingState(gameId: .pokerPlus, seatCount: 4, message: "プレイヤーを募集しています...")
                Router().pushBasePage(pageId: .matching)
            }
        }
    }
    
    func onExit() {
        // observer 解除してから切断
        appState.pokerPlusConnection.observer = nil
        appState.pokerPlusConnection.disconnect()
    }
    
    func resumePlay(secretId: String, onError: @escaping (()->Void)) {
        
        let userId = appState.account.loginUser.id
        let req = PokerPlusLoadRoom.Request(user_id: userId, secret_id: secretId)
        print("\(PokerPlusLoadRoom.urlPath) にリクエストを送信します")
        CenterClient.forLocal.send(
            req,
            to: PokerPlusLoadRoom.API,
            onReceive: { res in
                DispatchQueue.main.async {
                    // Stateの作成
                    let pokerPlusSystemState = PokerPlusSystemState(
                        pokerPlusState: res.state,
                        players: res.players
                    )
                    appState.pokerPlusSystem = pokerPlusSystemState
                    // UIStateの作成
                    let pokerPlusPlayUiState = PokerPlusPlayUiStateBuilder().playUiState(from: pokerPlusSystemState)
                    appState.pokerPlusPlayUi = pokerPlusPlayUiState
                    
                    Router().setBasePages(stack: [.pokerPlusPlay])
                }
            },
            onCatch: {_ in
                fatalError("LoadGameに失敗")
            }
        )
    }
    
    // score list まで終了
    func didShowdown() {
        PokerPlusBetController().enableBet()
        
        DispatchQueue.main.async {
            appState.pokerPlusPlayUi.canExit = true
        }
    }
    
    func didShuffle() {
        PokerPlusPutController().enablePut()
    }
}

extension PokerPlusEventController: PokerPlusConnectionObserver {
    
    var userID: String {
        return appState.account.loginUser.id
    }
    
    // Push通知を受け取る
    func onReceive(announce: PokerPlusAnnounce) {
        let type = PokerPlusAnnounceId(rawValue: announce.announce_type)!
        switch type {
        case .matchComplete:
            PokerPlusMatchingController().onMatchComplete(announce: announce)
        case .betStart:
            let myUserId = appState.account.loginUser.id
            let mySeat = announce.players!.first(where: {$0.user_id == myUserId})!.seat
            let myStep = announce.masked_state!.sides.first(where: {$0.seat.rawValue == mySeat})!.playerStep
            DispatchQueue.main.async {
                switch myStep {
                case .bet:
                    appState.pokerPlusPlayUi.waitingOthers = false
                case .waitingShuffle:
                    appState.pokerPlusPlayUi.waitingOthers = true
                case .put:
                    appState.pokerPlusPlayUi.waitingOthers = false
                case .waitingShowdown:
                    appState.pokerPlusPlayUi.waitingOthers = true
                }
            }
            
            // MARK: - Bet開始だが、UIではショーダウンアニメーションから実施
            
            // システムStateを保存
            appState.pokerPlusSystem.pokerPlusState =  announce.masked_state!
            appState.pokerPlusSystem.players = announce.players!
            // ショーダウン開始
            PokerPlusShowdownController().startShowdown(
                animationList: announce.showdown_list!,
                scoreList: announce.score_list!
            )
        case .putStart:
            // システムStateを保存
            appState.pokerPlusSystem.pokerPlusState =  announce.masked_state!
            appState.pokerPlusSystem.players = announce.players!
            
            let myUserId = appState.account.loginUser.id
            let mySeat = announce.players!.first(where: {$0.user_id == myUserId})!.seat
            let myStep = announce.masked_state!.sides.first(where: {$0.seat.rawValue == mySeat})!.playerStep
            DispatchQueue.main.async {
                switch myStep {
                case .bet:
                    appState.pokerPlusPlayUi.waitingOthers = false
                case .waitingShuffle:
                    appState.pokerPlusPlayUi.waitingOthers = true
                case .put:
                    appState.pokerPlusPlayUi.waitingOthers = false
                case .waitingShowdown:
                    appState.pokerPlusPlayUi.waitingOthers = true
                }
            }
            // Put開始だが、UIではシャッフルから実施
            PokerPlusShaffleController().startShuffle(with: announce)
        case .playerPut:
            let seat = PokerPlusSeat(rawValue: announce.trigger_seat!)!
            PokerPlusPutController().onPlayerPut(at: seat)
        case .playerEnter:
            print("誰かが参加しました")
        case .playerExit:
            print("誰かが退出しました")
        }
    }
}
