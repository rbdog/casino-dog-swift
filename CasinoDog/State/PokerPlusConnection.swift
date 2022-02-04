//
//
//

import SwiftUI
import Center

protocol PokerPlusConnectionObserver {
    func onReceive(announce: PokerPlusAnnounce)
}

final class PokerPlusConnection {
    var isConnected: Bool = false
    let userId: String
    let url: String
    var observer: PokerPlusConnectionObserver?
    
    func connect() async {
        // WebSocket 開始
        center.pokerPlusServer.speaker.connect(listener: self)
        isConnected = true
    }
    
    func disconnect() {
        // WebSocket 切断
        center.pokerPlusServer.speaker.disconnect(userID: userID)
        isConnected = false
    }
    
    init(url: String, userId: String) {
        self.url = url
        self.userId = userId
    }
}

extension PokerPlusConnection: PokerPlusSpeakerLisner {
    
    var userID: String {
        return appState.account.loginUser.id
    }
    
    // Push通知を受け取る
    func onReceive(announce: Data) {
        let announce = PokerPlusAnnounce(json: announce)
        if let observer = observer {
            observer.onReceive(announce: announce)
        } else {
            print("Observer が見つかりませんでした")
        }
    }
    
}
