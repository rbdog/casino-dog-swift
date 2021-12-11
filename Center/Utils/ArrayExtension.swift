//
//
//

// 重複する要素ががあるかないか
extension Array where Element: Hashable {
    var hasDuplicated: Bool {
        return Set(self).count != self.count
    }
}

// 配列を区切って二次元配列にする
extension Array {
    func split(by count: Int) -> [[Element]] {
        if self.isEmpty { return [] }
        var parent: [[Element]] = []
        for i in 1 ... self.count where (i % count) == 0 {
            parent.append(self[(i - count)...(i - 1)].map {$0})
        }
        if (self.count % count) != 0 { parent.append(self.suffix(self.count % count)) }
        return parent
    }
}

// 要素数チェックをしながらオプショナル型で取り出す
extension Array {
    /// Optional<Elemnt> として取り出す
    subscript (at index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

// 先頭のn要素を末尾へ移動させた配列を取得
extension Array {
    func broughtToTail(prefix couunt: Int) -> [Element] {
        let prefix = self.prefix(couunt)
        let suffix = self.suffix(self.count - couunt)
        return [Element](suffix + prefix)
    }
}

// 転置行列
extension Array where Element: RandomAccessCollection, Element.Index == Int {
    func transpose() -> [[Element.Element]] {
        return self.isEmpty ? [] : (0...(self.first!.endIndex - 1))
            .map { i -> [Element.Element] in self.map { $0[i] } }
    }
}

// 条件に一致する要素のインデックスを全て取得
extension Array {
    func indexes(where condition: (_ element: Element) -> Bool) -> [Int] {
        let indexes = self.enumerated().filter({condition($0.element)}).map{$0.offset}
        return indexes
    }
}
