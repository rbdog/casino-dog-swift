//
//
//

import Foundation

enum SlotsSpinSlot: HTTPAPI {
    static var urlPath = "/slots/spin-slot"
    static var httpMethod = HTTP.Method.GET

    struct Request: HTTPRequestBody {
        let user_id: String
        let machine_id: Int
    }
    struct Response: HTTPResponseBody {
        let reel_animations: [SlotReelAnimation]
        let triad_animation: SlotTriadAnimation?
        let new_pockets: [SymbolPocket]
        let new_chips: Int
        let error: ErrorModel?
    }
}
