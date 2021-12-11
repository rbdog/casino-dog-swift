//
//
//

// スペース埋め、ゼロ埋め、左寄せ
extension String {
    func filled(to count: Int, with pad: String = " ", isLeading: Bool = false) -> String {
        let main = String(self.prefix(count))
        let pads = String(repeating: pad, count: count - main.count)
        return isLeading ? (main + pads) : (pads + main)
    }
}

// n文字ごとに区切る
extension String {
    func split(by count: Int) -> [String] {
        let arrayValue = Array(self)
        if arrayValue.isEmpty { return [] }
        var parent: [[Element]] = []
        for i in 1 ... arrayValue.count where (i % count) == 0 {
            parent.append(arrayValue[(i - count)...(i - 1)].map {$0})
        }
        if (arrayValue.count % count) != 0 {
            parent.append(arrayValue.suffix(arrayValue.count % count))
        }
        return parent.map({String($0)})
    }
}
