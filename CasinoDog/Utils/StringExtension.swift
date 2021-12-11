//
//
//

import Foundation

extension String {
    func padding(to count: Int, with pad: String = " ", isTrailing: Bool = true) -> String {
        let main = String(self.prefix(count))
        let pads = String(repeating: pad, count: count - main.count)
        return isTrailing ? (pads + main) : (main + pads)
    }
}
