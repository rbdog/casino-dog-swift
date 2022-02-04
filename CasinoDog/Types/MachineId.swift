//
//
//

import SwiftUI

// サーバーサイドと統一

enum MachineId: Int, JSONSerializable {
    case classic = 1
    case free = 2
    case developers = 3
    case v1 = 4
}
