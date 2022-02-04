//
//
//

import Foundation

struct PokerPlusScore: JSONSerializable {
    let user_id: String
    let old_total_chips: Int
    let bonus_chips: Int
    let put_card_id: Int
    let inner_id: Int
    let outer_id: Int
    let combo_name: String
}
