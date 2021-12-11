//
//
//

import Foundation

struct Machine: Identifiable {
    let id: MachineID
    let name: String
    let miniImageUrl: String
    let accentColorHex: String
    let baseColorHex: String
    let borderColorHex: String
    let reels: [Reel]
    let spinCost: Int
    let memberSymbols: [Symbol]
}

struct Reel {
    let symbols: [Symbol]
}
