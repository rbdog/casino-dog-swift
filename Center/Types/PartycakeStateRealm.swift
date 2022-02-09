//
//
//

import Foundation
import RealmSwift

final class PartycakeStateRealm: Object {

    /// State ID
    /// UUID
    @objc dynamic var state_id: String = ""

    /// Game State Json
    @objc dynamic var value: String = ""

    override static func primaryKey() -> String? {
        return "state_id"
    }

    convenience required init(
        stateId: String,
        value: String
    ) {
        self.init()
        self.state_id = stateId
        self.value = value
    }
}
