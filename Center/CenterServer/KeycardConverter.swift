//
//
//

import Foundation

struct KeycardConverter {
    func keycard(keycardRealm: KeycardRealm) -> Keycard {
        let keycard = Keycard(
            id: keycardRealm._id,
            game_id: keycardRealm.game_id,
            user_id: keycardRealm.user_id,
            user_type: keycardRealm.user_type,
            secret_id: keycardRealm.secret_id,
            state_id: keycardRealm.state_id,
            seat: keycardRealm.seat
        )
        return keycard
    }
    
    func keycardRealm(keycard: Keycard) -> KeycardRealm {
        let keycardRealm = KeycardRealm(
            _id: keycard.id,
            gameID: keycard.game_id,
            userID: keycard.user_id,
            userType: keycard.user_type,
            stateID: keycard.state_id,
            seat: keycard.seat
        )
        return keycardRealm
    }
}
