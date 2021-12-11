//
//
//

import Foundation
import RealmSwift

final class UserRealm: Object {

    /// ID
    /// UUID
    @objc dynamic var id: String = ""

    /// email adress
    /// varchar(255), ex: "foo@example.com"
    @objc dynamic var mail: String = ""

    /// Free public name
    /// varchar(10)
    @objc dynamic var nickname: String = "NewUser"
    
    /// URL of the user icon
    /// varchar(8190), ex: "https://example.com/foo.png"
    @objc dynamic var icon_url: String = "assets://icon-guest"

    /// Number of all the chips user has.
    /// int
    @objc dynamic var chip: Int = 0

    /// Symbols CSV
    /// varchar(10000) JSON
    @objc dynamic var symbol_pockets: String = ""
    
    /// greeting, self-introduction
    /// varchar(100)
    @objc dynamic var self_intro: String = "Hello Casino+. I just set up a new account."

    /// Created at this date
    /// yyyy-MM-dd HH:mm:ss+HH
    @objc dynamic var created_at: Date = Date()

    /// Updated at this date
    /// yyyy-MM-dd HH:mm:ss+HH
    @objc dynamic var updated_at: Date = Date()

    override static func primaryKey() -> String? {
        return "id"
    }

    convenience required init(id: String,
                              createdAt: Date,
                              updatedAt: Date,
                              mail: String,
                              nickname: String,
                              chip: Int,
                              iconURL: String,
                              selfIntro: String,
                              symbol_pockets: String) {

        self.init()
        self.id = id
        self.created_at = createdAt
        self.updated_at = updatedAt
        self.mail = mail
        self.nickname = nickname
        self.chip = chip
        self.icon_url = iconURL
        self.self_intro = selfIntro
        self.symbol_pockets = symbol_pockets
    }
}
