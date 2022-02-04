//
// WebSocket
//

import Foundation

/// 自分よりも早く通知を受け取ったプレイヤーが行動して,通知の順番が逆になることがあるため注意
public protocol PokerPlusSpeakerLisner {
    var userID: String { get }
    func onReceive(announce: Data)
}

public class PokerPlusSpeaker {

    public func connect(listener: PokerPlusSpeakerLisner) {
        center.pokerPlusServer.state.speakerListeners[listener.userID] = listener
    }

    public func disconnect(userID: String) {
        center.pokerPlusServer.state.speakerListeners[userID] = nil
    }

    func speak(to userIDs: [String], announce: PokerPlusAnnounce) {
        for id in userIDs {
            center.pokerPlusServer.state.speakerListeners[id]?.onReceive(announce: announce.jsonData)
        }
    }
}
