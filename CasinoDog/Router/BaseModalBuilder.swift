//
//
//

import Foundation
import SwiftUI

struct BaseModalBuilder: ModalBuilder {    
    func contentView(_ id: ModalId) -> some View {
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
