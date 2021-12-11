//
//
//

import Foundation

extension Double {
    init?(_ int: Int?) {
        guard let int = int else { return nil }
        self = Double(int)
    }
}
