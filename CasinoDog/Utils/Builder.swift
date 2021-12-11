//
//
//

import Foundation
import SwiftUI

protocol PageBuilder {
    associatedtype Body : View
    func emptyView() -> AnyView
    func contentView(_ id: PageId) -> Self.Body
}

protocol TabBuilder {
    associatedtype Body : View
    func contentView(_ id: PageId) -> Self.Body
    func tabBackColorOnSelected(_ id: PageId) -> Color
    func tabBackColorOnUnselected(_ id: PageId) -> Color
    func tabImage(_ id: PageId) -> Image
    func tabText(_ id: PageId) -> String
}

protocol ModalBuilder {
    associatedtype Body : View
    func contentView(_ id: ModalId) -> Self.Body
}
