//
//
//

import Foundation
import SwiftUI

struct ModalContent: View {
    let id: ModalId
    
    var body: some View {
        return Group {
            switch id {
            case .badNetwork:
                BadNetworkModal()
            case .oldVersion:
                OldVersionModal()
            }
        }
    }
}
