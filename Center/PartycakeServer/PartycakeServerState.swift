//
//
//

import Foundation

class PartycakeServerState {
    // WebSocket
    var speakerListeners: [String: PartycakeSpeakerLisner] = [:]
    // マッチング中のユーザーID
    var matchingUsers: [MatchingUser] = []
    // 起動中のPartycakeボットユーザー
    var activeBots: [PartycakeBot] = []
}
