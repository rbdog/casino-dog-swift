//
//
//

import SwiftUI

// サーバーサイドと統一

enum MachineID: String, JSONSerializable {
    case classic = "Classic"
    case free = "Free"
    case developers = "Developers"
    case v1m0 = "V1M0"
}
