//
//
//

import Foundation
import SwiftUI
import Center

struct PartycakePutController {
    
    func enablePut() {
        DispatchQueue.main.async {
            appState.partycakePlayUi.dockIsLocked = false
        }
    }
    
    func put(card: CardId) {
        DispatchQueue.main.async {
            withAnimation {
                appState.partycakePlayUi.dockHandCards.removeAll(where: {$0 == appState.partycakePlayUi.dockSelectedCard})
            }
            appState.partycakePlayUi.dockSelectedCard = nil
            appState.partycakePlayUi.waitingOthers = true
            appState.partycakePlayUi.dockIsLocked = true
        }
        
        let myUserId = appState.account.loginUser.id
        let secretId = appState.account.keycard!.secret_id
        let request = PartycakePutAction.Request(
            user_id: myUserId,
            secret_id: secretId,
            card_id: card.rawValue
        )
        
        CenterClient.forLocal.send(
            request,
            to: PartycakePutAction.API,
            onReceive: { response in
                print(response, self)
            },
            onCatch: { _ in
                fatalError("Put に失敗しました")
            }
        )
    }
    
    func onPlayerPut(at seat: PartycakeSeat) {
        // 裏面のカードをセット
        DispatchQueue.main.async {
            appState.partycakePlayUi.sides.first(where: {$0.seat == seat})!.putCardDegree = 180
            withAnimation(.easeOut(duration: 0.5)) {
                appState.partycakePlayUi.sides.first(where: {$0.seat == seat})!.putCard = .back
            }
        }
    }
}
