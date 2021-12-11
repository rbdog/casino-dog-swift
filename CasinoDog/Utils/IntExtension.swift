//
//
//

import Foundation

extension Int {
    var withSign: String {
        if self < 0 {
            return String(self)
        } else if 0 < self {
            return "+" + String(self)
        } else {
            return String(self)
        }
    }
}

extension Int {

    /// looped value in range
    func looped(in range: ClosedRange<Self>) -> Self {
        let min = range.lowerBound
        let max = range.upperBound
        if self < min {
            return max - ((min - self - 1) % (max - min))
        } else if max < self {
            return min + ((self - max - 1) % (max - min))
        } else {
            return self
        }
    }
}
