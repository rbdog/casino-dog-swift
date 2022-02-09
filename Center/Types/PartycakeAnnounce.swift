//
//
//

import Foundation

struct PartycakeAnnounce: JSONSerializable {
    let announce_type: Int
    let masked_state: PartycakeState?
    let players: [Player]?
    let trigger_seat: Int?
    let showdown_list: [PartycakeShowdownAnimation]?
    let score_list: [PartycakeScore]?
    let published_keycard: Keycard?
}
