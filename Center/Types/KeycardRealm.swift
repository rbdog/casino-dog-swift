//
//
//

import Foundation
import RealmSwift

final class KeycardRealm: Object {

    /// ID
    /// UUID
    @objc dynamic var _id: String = ""
    
    /// Game ID
    /// UUID
    @objc dynamic var game_id: String = ""

    /// User ID
    /// UUID
    @objc dynamic var user_id: String = ""
    
    /// User Type
    /// Int
    @objc dynamic var user_type: Int = 0

    /// Secret ID
    /// UUID
    @objc dynamic var secret_id: String = ""
    
    /// State ID
    /// UUID
    @objc dynamic var state_id: String = ""
    
    /// Seat
    /// Int
    @objc dynamic var seat: Int = 0
    
    override static func primaryKey() -> String? {
        return "_id"
    }

    convenience required init(
        _id: String,
        gameID: String,
        userID: String,
        userType: Int,
        stateID: String,
        seat: Int
    ) {
        self.init()
        self._id = _id
        self.game_id = gameID
        self.user_id = userID
        self.user_type = userType
        self.secret_id = UUID().uuidString
        self.state_id = stateID
        self.seat = seat
    }
}
