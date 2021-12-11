//
//
//

import SwiftUI

enum MachineID: String {
    case classic = "Classic"
    case free = "Free"
    case developers = "Developers"
    case v1m0 = "V1M0"
    
    func machine() -> SlotMachine {
        switch self {
        case .classic:
            return SlotClassicMachine()
        case .free:
            return SlotFreeMachine()
        case .developers:
            return SlotDevelopersMachine()
        case .v1m0:
            return SlotV1M1Machine()
        }
    }
}
