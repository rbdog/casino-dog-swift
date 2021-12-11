//
//
//

import Foundation

struct Keycard: JSONSerializable {

    /// ID
    let id: String
    
    /// Game ID
    let game_id: String

    /// User ID
    let user_id: String
    
    /// User Type
    let user_type: Int

    /// Secret ID
    let secret_id: String
    
    /// State ID
    let state_id: String
    
    /// Seat
    let seat: Int
}
