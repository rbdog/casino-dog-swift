//
//
//

import Foundation
import SwiftUI

class PartycakeEventController {
    
    func play(secretId: String?) {
        // Connection オブイェクトを生成
        let myUserId = appState.account.loginUser.id
        appState.partycakeConnection = PartycakeConnection(url: "test", userId: myUserId)
        Task {
            // 自身を observer に設定してから接続
            appState.partycakeConnection.observer = self
            await appState.partycakeConnection.connect()
            
            if let secretId = secretId {
                // すでにプレイ中のゲームがある時
                resumePlay(secretId: secretId) {
                    fatalError("resume play でエラーが発生しました")
                }
            } else {
                // まだプレイ中のゲームがない時
                // マッチングから
                appState.matching = MatchingState(gameId: .partycake, seatCount: 4, message: "プレイヤーを募集しています...")
                Router().pushBasePage(pageId: .matching)
            }
        }
    }
    
    func onExit() {
        // observer 解除してから切断
        appState.partycakeConnection.observer = nil
        appState.partycakeConnection.disconnect()
    }
    
    func resumePlay(secretId: String, onError: @escaping (()->Void)) {
        
        let userId = appState.account.loginUser.id
        let req = PartycakeLoadRoom.Request(user_id: userId, secret_id: secretId)
        print("\(PartycakeLoadRoom.urlPath) にリクエストを送信します")
        CenterClient.forLocal.send(
            req,
            to: PartycakeLoadRoom.API,
            onReceive: { res in
                DispatchQueue.main.async {
                    // Stateの作成
                    let partycakeSystemState = PartycakeSystemState(
                        partycakeState: res.state,
                        players: res.players
                    )
                    appState.partycakeSystem = partycakeSystemState
                    // UIStateの作成
                    let partycakePlayUiState = PartycakePlayUiStateBuilder().playUiState(from: partycakeSystemState)
                    appState.partycakePlayUi = partycakePlayUiState
                    
                    Router().setBasePages(stack: [.partycakePlay])
                }
            },
            onCatch: {_ in
                fatalError("LoadGameに失敗")
            }
        )
    }
    
    // score list まで終了
    func didShowdown() {
        PartycakeBetController().enableBet()
        
        DispatchQueue.main.async {
            appState.partycakePlayUi.canExit = true
        }
    }
    
    func didShuffle() {
        PartycakePutController().enablePut()
    }
}

extension PartycakeEventController: PartycakeConnectionObserver {
    
    var userID: String {
        return appState.account.loginUser.id
    }
    
    // Push通知を受け取る
    func onReceive(announce: PartycakeAnnounce) {
        let type = PartycakeAnnounceId(rawValue: announce.announce_type)!
        switch type {
        case .matchComplete:
            PartycakeMatchingController().onMatchComplete(announce: announce)
        case .betStart:
            let myUserId = appState.account.loginUser.id
            let mySeat = announce.players!.first(where: {$0.user_id == myUserId})!.seat
            let myStep = announce.masked_state!.sides.first(where: {$0.seat.rawValue == mySeat})!.playerStep
            DispatchQueue.main.async {
                switch myStep {
                case .bet:
                    appState.partycakePlayUi.waitingOthers = false
                case .waitingShuffle:
                    appState.partycakePlayUi.waitingOthers = true
                case .put:
                    appState.partycakePlayUi.waitingOthers = false
                case .waitingShowdown:
                    appState.partycakePlayUi.waitingOthers = true
                }
            }
            
            // MARK: - Bet開始だが、UIではショーダウンアニメーションから実施
            
            // システムStateを保存
            appState.partycakeSystem.partycakeState =  announce.masked_state!
            appState.partycakeSystem.players = announce.players!
            // ショーダウン開始
            PartycakeShowdownController().startShowdown(
                animationList: announce.showdown_list!,
                scoreList: announce.score_list!
            )
        case .putStart:
            // システムStateを保存
            appState.partycakeSystem.partycakeState =  announce.masked_state!
            appState.partycakeSystem.players = announce.players!
            
            let myUserId = appState.account.loginUser.id
            let mySeat = announce.players!.first(where: {$0.user_id == myUserId})!.seat
            let myStep = announce.masked_state!.sides.first(where: {$0.seat.rawValue == mySeat})!.playerStep
            DispatchQueue.main.async {
                switch myStep {
                case .bet:
                    appState.partycakePlayUi.waitingOthers = false
                case .waitingShuffle:
                    appState.partycakePlayUi.waitingOthers = true
                case .put:
                    appState.partycakePlayUi.waitingOthers = false
                case .waitingShowdown:
                    appState.partycakePlayUi.waitingOthers = true
                }
            }
            // Put開始だが、UIではシャッフルから実施
            PartycakeShaffleController().startShuffle(with: announce)
        case .playerPut:
            let seat = PartycakeSeat(rawValue: announce.trigger_seat!)!
            PartycakePutController().onPlayerPut(at: seat)
        case .playerEnter:
            print("誰かが参加しました")
        case .playerExit:
            print("誰かが退出しました")
        }
    }
}
