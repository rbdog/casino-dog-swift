//
//
//

import SwiftUI

enum MachineId: Int {
    case classic = 1
    case free = 2
    case developers = 3
    case v1 = 4
    
    func machine() -> SlotMachine {
        switch self {
        case .classic:
            return SlotClassicMachine()
        case .free:
            return SlotFreeMachine()
        case .developers:
            return SlotDevelopersMachine()
        case .v1:
            return SlotV1Machine()
        }
    }
}
