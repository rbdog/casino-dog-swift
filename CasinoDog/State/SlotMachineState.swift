//
//
//

import SwiftUI

final class SlotMachineState: ObservableObject, JSONSerializable {
    
    let machineID: MachineID
    let reels: [ReelState]
    var squreSize: CGFloat!
    @Published var canStart: Bool = true
    @Published var sliderValue: CGFloat
    @Published var triadEffect: SlotsAPIModel.TriadEffect?
    
    // カスタムエンコード
    enum CodingKeys: String, CodingKey {
        case machineID
        case reels
        case squreSize
        case canStart
        case sliderValue
        case triadEffect
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        machineID = try container.decode(MachineID.self, forKey: .machineID)
        reels = try container.decode([ReelState].self, forKey: .reels)
        squreSize = try container.decode(CGFloat.self, forKey: .squreSize)
        canStart = try container.decode(Bool.self, forKey: .canStart)
        sliderValue = try container.decode(CGFloat.self, forKey: .sliderValue)
        triadEffect = try container.decode(SlotsAPIModel.TriadEffect?.self, forKey: .triadEffect)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(machineID, forKey: .machineID)
        try container.encode(reels, forKey: .reels)
        try container.encode(squreSize, forKey: .squreSize)
        try container.encode(canStart, forKey: .canStart)
        try container.encode(sliderValue, forKey: .sliderValue)
        try container.encode(triadEffect, forKey: .triadEffect)
    }
    
    init(machineID: MachineID,
         sliderValue: CGFloat = 0,
         triadEffect: SlotsAPIModel.TriadEffect? = nil) {
        let machine = MachineList().machines.first(where: {$0.id == machineID})!
        self.machineID = machineID
        self.reels = machine.reels.map{ReelState(symbols: $0.symbols)}
        self.sliderValue = sliderValue
        self.triadEffect = triadEffect
    }
}

final class ReelState: ObservableObject, JSONSerializable {
    let symbols: [Symbol]
    @Published var offset: CGFloat = 0
    var index: Int = 0
    var stopIndex: [Int] = []
    
    // カスタムエンコード
    enum CodingKeys: String, CodingKey {
        case symbols
        case offset
        case index
        case stopIndex
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        symbols = try container.decode([Symbol].self, forKey: .symbols)
        offset = try container.decode(CGFloat.self, forKey: .offset)
        index = try container.decode(Int.self, forKey: .index)
        stopIndex = try container.decode([Int].self, forKey: .stopIndex)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(symbols, forKey: .symbols)
        try container.encode(offset, forKey: .offset)
        try container.encode(index, forKey: .index)
        try container.encode(stopIndex, forKey: .stopIndex)
    }
    
    init(symbols: [Symbol],
         offset: CGFloat = 0,
         index: Int = 0,
         stopIndex: [Int] = []) {
        self.symbols = symbols
        self.offset = offset
        self.index = index
        self.stopIndex = stopIndex
    }
    
}
