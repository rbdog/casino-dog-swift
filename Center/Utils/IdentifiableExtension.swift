//
//
//

extension Identifiable where Self: CaseIterable {
    init?(id: ID) {
        var instance: Self?
        for `case` in Self.allCases where `case`.id == id {
            instance = `case`
        }
        if let `case` = instance {
            self = `case`
        } else {
            return nil
        }
    }
}
