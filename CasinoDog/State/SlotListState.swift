//
//
//

import SwiftUI

final class SlotListState: ObservableObject, JSONSerializable {
    
    @Published var machineIDList: [MachineID]
    
    // カスタムエンコード
    enum CodingKeys: String, CodingKey {
        case machineIDList
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        machineIDList = try container.decode([MachineID].self, forKey: .machineIDList)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(machineIDList, forKey: .machineIDList)
    }
    
    init(machineIDList: [MachineID] = [
        .classic,
        .free,
        .developers,
        .v1m0
    ]) {
        self.machineIDList = machineIDList
    }
    
}
