//
//
//

import SwiftUI
import Center

protocol PartycakeConnectionObserver {
    func onReceive(announce: PartycakeAnnounce)
}

final class PartycakeConnection {
    var isConnected: Bool = false
    let userId: String
    let url: String
    var observer: PartycakeConnectionObserver?
    
    func connect() async {
        // WebSocket 開始
        center.partycakeServer.speaker.connect(listener: self)
        isConnected = true
    }
    
    func disconnect() {
        // WebSocket 切断
        center.partycakeServer.speaker.disconnect(userID: userID)
        isConnected = false
    }
    
    init(url: String, userId: String) {
        self.url = url
        self.userId = userId
    }
}

extension PartycakeConnection: PartycakeSpeakerLisner {
    
    var userID: String {
        return appState.account.loginUser.id
    }
    
    // Push通知を受け取る
    func onReceive(announce: Data) {
        let announce = PartycakeAnnounce(json: announce)
        if let observer = observer {
            observer.onReceive(announce: announce)
        } else {
            print("Observer が見つかりませんでした")
        }
    }
    
}
