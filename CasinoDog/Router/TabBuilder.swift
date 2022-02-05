//
//
//

import Foundation
import SwiftUI

protocol TabBuilder {
    associatedtype Body : View
    func contentView(_ id: PageId) -> Self.Body
    func tabBackColorOnSelected(_ id: PageId) -> Color
    func tabBackColorOnUnselected(_ id: PageId) -> Color
    func tabImage(_ id: PageId) -> Image
    func tabText(_ id: PageId) -> String
}
