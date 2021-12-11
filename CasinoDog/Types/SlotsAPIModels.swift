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
        let symbols: [Symbol]
        let stop_index: [Int]
    }
    
    struct TriadEffect: JSONSerializable {
        let symbol: Symbol
        let image_url: String
        let title: String
        let description: String
    }
}
