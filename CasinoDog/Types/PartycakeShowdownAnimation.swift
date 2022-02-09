//
//
//

import Foundation

struct PartycakeShowdownAnimation: JSONSerializable {
    let seat: Int
    let put_card_id: Int
    let old_inner_offset: Int
    let new_inner_offset: Int?
    let old_outer_offset: Int
    let new_outer_offset: Int?
}
