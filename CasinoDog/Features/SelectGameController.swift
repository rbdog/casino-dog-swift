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
        
        // 今は Partycake しかないので固定値
        let eventController = PartycakeEventController()
        eventController.play(secretId: nil)
    }
}
