//
//
//

import Foundation

struct PokerPlusAnnounce: JSONSerializable {
    let announce_type: Int
    let masked_state: PokerPlusState?
    let players: [Player]?
    let trigger_seat: Int?
    let showdown_list: [PokerPlusShowdownAnimation]?
    let score_list: [PokerPlusScore]?
    let published_keycard: Keycard?
}
