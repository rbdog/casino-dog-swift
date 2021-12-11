//
//
//

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
