//
//
//

import Foundation
import SwiftUI
import Center

class SelectGameController {
    
    func onTapPlay() {
        // TODO: - 選択したゲーム
        // TODO: - RESUME判別対応
        
        // 今は Poker+ しかないので固定値
        let eventController = PokerPlusEventController()
        eventController.play(secretId: nil)
    }
}
