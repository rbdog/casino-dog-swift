//
//
//

import Foundation

enum SlotsSpinSlot: HTTPAPI {
    static var urlPath = "/slots/spin-slot"
    static var httpMethod = HTTP.Method.GET

    struct Request: HTTPRequestBody {
        let user_id: String
        let machine_id: String
    }
    struct Response: HTTPResponseBody {
        let slot_animation: SlotsAPIModel.SlotAnimation
        let new_pockets: [SymbolPocket]
        let new_chips: Int
        let error: ErrorModel?
    }
}
