//
//
//

import Foundation

struct User: JSONSerializable {

    /// ID
    let id: String

    /// email adress
    let mail: String

    /// Free public name
    var nickname: String
    
    /// URL of the user icon
    var icon_url: String

    /// Number of all the chips user has.
    var chips: Int

    /// Symbols
    var symbol_pockets: [SymbolPocket]
    
    /// greeting, self-introduction
    let self_intro: String

    /// Created at this date
    /// yyyy-MM-dd HH:mm:ss+HH
    let created_at: Date

    /// Updated at this date
    /// yyyy-MM-dd HH:mm:ss+HH
    let updated_at: Date
}
