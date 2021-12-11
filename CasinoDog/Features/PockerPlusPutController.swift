//
//
//

import Foundation
import SwiftUI
import Center

struct PokerPlusPutController {
    
    func enablePut() {
        DispatchQueue.main.async {
            appState.pokerPlusPlayUi.dockIsLocked = false
        }
    }
    
    func put(card: CardID) {
        DispatchQueue.main.async {
            withAnimation {
                appState.pokerPlusPlayUi.dockHandCards.removeAll(where: {$0 == appState.pokerPlusPlayUi.dockSelectedCard})
            }
            appState.pokerPlusPlayUi.dockSelectedCard = nil
            appState.pokerPlusPlayUi.waitingOthers = true
            appState.pokerPlusPlayUi.dockIsLocked = true
        }
        
        let myUserId = appState.account.loginUser.id
        let secretId = appState.account.keycard!.secret_id
        let request = PokerPlusPutAction.Request(
            user_id: myUserId,
            secret_id: secretId,
            card_id: card.rawValue
        )
        
        CenterClient.forLocal.send(
            request,
            to: PokerPlusPutAction.API,
            onReceive: { response in
                print(response, self)
            },
            onCatch: { _ in
                fatalError("Put に失敗しました")
            }
        )
    }
    
    func onPlayerPut(at seat: PokerPlusSeat) {
        // 裏面のカードをセット
        DispatchQueue.main.async {
            appState.pokerPlusPlayUi.sides.first(where: {$0.seat == seat})!.putCardDegree = 180
            withAnimation(.easeOut(duration: 0.5)) {
                appState.pokerPlusPlayUi.sides.first(where: {$0.seat == seat})!.putCard = .back
            }
        }
    }
}
