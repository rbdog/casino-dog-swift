//
//
//

import Foundation

class PokerPlusServerState {
    // WebSocket
    var speakerListeners: [String: PokerPlusSpeakerLisner] = [:]
    // マッチング中のユーザーID
    var matchingUsers: [MatchingUser] = []
    // 起動中のPokerPlusボットユーザー
    var activeBots: [PokerPlusBot] = []
}
