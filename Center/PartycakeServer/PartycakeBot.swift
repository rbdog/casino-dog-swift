//
//
//

import Foundation

class PartycakeBot {
    
    let userId: String
    var secretId: String
    
    init(userId: String,
         secretId: String) {
        self.userId = userId
        self.secretId = secretId
        print("BotPlayerが起動しました: \(self.userId)")
    }
    
    deinit {
        print("BotPlayerが停止しました: \(self.userId)")
    }
    
    func listenSpeaker() {
        center.partycakeServer.speaker.connect(listener: self)
    }
    
    func unlistenSpeaker() {
        center.partycakeServer.speaker.disconnect(userID: userId)
    }
    
    func requestBet(level: PartycakeBetLevel) {
        let request = PartycakeBetAction.Request(
            user_id: userId,
            secret_id: secretId,
            level: level.rawValue
        )
        print("\(userId) はBetリクエストを送信します")
        let resData = center.router.route(PartycakeBetAction.httpMethod.rawValue,
                                          PartycakeBetAction.urlPath,
                                          request: request.jsonData)
        _ = PartycakeBetAction.Response(json: resData)
    }
    
    func selectBetLevel(at seat: PartycakeSeat, state: PartycakeState) -> PartycakeBetLevel {
        var selection: [PartycakeBetLevel] = [.min, .mid, .max]
        let myChips = state.sides.first(where: {$0.seat == seat})!.chips
        
        while(selection.count > 0) {
            let level = selection.randomElement()!
            if myChips >= PartycakeRule().betCost(of: level) {
                // チップが足りる
                return level
            } else {
                // チップが足りない時は,除外してからやり直し
                selection.removeAll(where: {$0 == level})
            }
        }
        fatalError("チップが足りないのにベットしようとしました")
    }
    
    func requestExitRoom() {
        let request = PartycakeExitRoom.Request(
            user_id: userId,
            secret_id: secretId
        )
        print("\(self.userId) はExitRoomリクエストを送信します")
        let resData = Router().route(PartycakeExitRoom.httpMethod.rawValue,
                                     PartycakeExitRoom.urlPath,
                                     request: request.jsonData)
        _ = PartycakeExitRoom.Response(json: resData)
    }
    
    func requestPut(card: CardId) {
        let request = PartycakePutAction.Request(
            user_id: userId,
            secret_id: secretId,
            card_id: card.rawValue
        )
        print("\(self.userId) はPutリクエストを送信します")
        let resData = Router().route(PartycakePutAction.httpMethod.rawValue,
                                     PartycakePutAction.urlPath,
                                     request: request.jsonData)
        _ = PartycakePutAction.Response(json: resData)
    }
    
    func selectPutCard(at seat: PartycakeSeat, state: PartycakeState) -> CardId {
        let mySide = state.sides.first(where: {$0.seat == seat})!
        let cards = mySide.handCardIds
        let card = cards.randomElement()!
        return card
    }
    
    func startBet(at seat: PartycakeSeat, in state: PartycakeState) {
        let myChips = state.sides.first(where: {$0.seat == seat})!.chips
        if myChips < PartycakeRule().betCost(of: .min) {
            // チップが足りない場合は部屋を抜ける
            requestExitRoom()
            return
        }
        
        // 数秒間考えてからBetする
        let thinkingTime = (20...70).randomElement()!
        let doubleTime = Double(thinkingTime)/Double(10)
        DispatchQueue.main.asyncAfter(deadline: .now() + doubleTime) {
            [weak self] in
            guard let self = self else {
                print("すでに停止されたボットです")
                return
            }
            let level = self.selectBetLevel(at: seat, state: state)
            self.requestBet(level: level)
        }
    }
    
    func startPut(at seat: PartycakeSeat, in state: PartycakeState) {
        // 数秒間考えてからPutする
        let thinkingTime = (20...70).randomElement()!
        let doubleTime = Double(thinkingTime)/Double(10)
        DispatchQueue.main.asyncAfter(deadline: .now() + doubleTime) {
            [weak self] in
            guard let self = self else {
                print("すでに停止されたボットです")
                return
            }
            let card = self.selectPutCard(at: seat, state: state)
            self.requestPut(card: card)
        }
    }
    
    func resume(at seat: PartycakeSeat, in state: PartycakeState) {
        let mySide = state.sides.first(where: {$0.seat == seat})!
        switch mySide.playerStep {
        case .bet:
            startBet(at: seat, in: state)
        case .waitingShuffle:
            break
        case .put:
            startPut(at: seat, in: state)
        case .waitingShowdown:
            break
        }
    }

}

extension PartycakeBot: PartycakeSpeakerLisner {
    var userID: String {
        return userId
    }
    
    func onReceive(announce: Data) {
        let announce = PartycakeAnnounce(json: announce)
        let type = PartycakeAnnounceId(rawValue: announce.announce_type)!
        switch type {
        case .matchComplete:
            let state = announce.masked_state!
            let modelUsers = announce.players!
            let rawSeat = modelUsers.first(where: {$0.user_id == userId})!.seat
            let seat = PartycakeSeat(rawValue: rawSeat)!
            startBet(at: seat, in: state)
        case .betStart:
            let state = announce.masked_state!
            let modelUsers = announce.players!
            let rawSeat = modelUsers.first(where: {$0.user_id == userId})!.seat
            let seat = PartycakeSeat(rawValue: rawSeat)!
            startBet(at: seat, in: state)
        case .putStart:
            let state = announce.masked_state!
            let modelUsers = announce.players!
            let rawSeat = modelUsers.first(where: {$0.user_id == userId})!.seat
            let seat = PartycakeSeat(rawValue: rawSeat)!
            startPut(at: seat, in: state)
        case .playerPut:
            break
        case .playerEnter:
            break
        case .playerExit:
            break
        }
    }
}
