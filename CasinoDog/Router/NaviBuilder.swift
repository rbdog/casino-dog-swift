//
//
//

import Foundation
import SwiftUI

protocol NaviBuilder {
    associatedtype Body : View
    func emptyView() -> AnyView
    func contentView(_ id: PageId) -> Self.Body
}
