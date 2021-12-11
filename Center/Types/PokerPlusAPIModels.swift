//
//
//

import Foundation

enum PokerPlusAPIModel {

    struct ShowdownAnimation: JSONSerializable {
        let seat: Int
        let put_card_id: Int
        let old_inner_offset: Int
        let new_inner_offset: Int?
        let old_outer_offset: Int
        let new_outer_offset: Int?
    }

    struct Score: JSONSerializable {
        let user_id: String
        let old_total_chips: Int
        let bonus_chips: Int
        let put_card_id: Int
        let inner_id: Int
        let outer_id: Int
        let combo_name: String
    }
    
    enum AnnounceType: Int {
        case matchComplete
        case betStart
        case putStart
        case playerPut
        case playerEnter
        case playerExit
    }

    struct Announce: JSONSerializable {
        let announce_type: Int
        let masked_state: PokerPlusState?
        let players: [Player]?
        let trigger_seat: Int?
        let showdown_list: [ShowdownAnimation]?
        let score_list: [Score]?
        let published_keycard: Keycard?
    }
}
