//
//
//

import Foundation

enum Flavor: Int {
    case develop
    // case staging
    // case production
}

func flavor() -> Flavor {
    return .develop
}
