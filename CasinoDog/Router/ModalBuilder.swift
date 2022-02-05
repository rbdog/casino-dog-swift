//
//
//

import Foundation
import SwiftUI

protocol ModalBuilder {
    associatedtype Body : View
    func contentView(_ id: ModalId) -> Self.Body
}
