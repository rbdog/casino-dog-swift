//
//
//

import Foundation

struct Machine: Identifiable {
    let id: MachineId
    let name: String
    let miniImageUrl: String
    let accentColorHex: String
    let baseColorHex: String
    let borderColorHex: String
    let reels: [ReelId]
    let spinCost: Int
    let memberSymbols: [SymbolId]
}
