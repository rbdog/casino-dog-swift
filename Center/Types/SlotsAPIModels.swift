//
//
//

import Foundation

enum SlotsAPIModel {
    struct SlotAnimation: JSONSerializable {
        let reel_animations: [ReelAnimation]
        let triad_effect: TriadEffect?
    }

    struct ReelAnimation: JSONSerializable {
        let symbols: [SymbolID]
        let stop_index: [Int]
    }
    
    struct TriadEffect: JSONSerializable {
        let symbol: SymbolID
        let image_url: String
        let title: String
        let description: String
    }
}
