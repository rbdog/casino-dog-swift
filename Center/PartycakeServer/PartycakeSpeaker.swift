//
// WebSocket
//

import Foundation

/// 自分よりも早く通知を受け取ったプレイヤーが行動して,通知の順番が逆になることがあるため注意
public protocol PartycakeSpeakerLisner {
    var userID: String { get }
    func onReceive(announce: Data)
}

public class PartycakeSpeaker {

    public func connect(listener: PartycakeSpeakerLisner) {
        center.partycakeServer.state.speakerListeners[listener.userID] = listener
    }

    public func disconnect(userID: String) {
        center.partycakeServer.state.speakerListeners[userID] = nil
    }

    func speak(to userIDs: [String], announce: PartycakeAnnounce) {
        for id in userIDs {
            center.partycakeServer.state.speakerListeners[id]?.onReceive(announce: announce.jsonData)
        }
    }
}
