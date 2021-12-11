//
//
//

// 先頭のn要素を末尾へ移動させた配列を取得
extension Array {
    func broughtToTail(prefix couunt: Int) -> [Element] {
        let prefix = self.prefix(couunt)
        let suffix = self.suffix(self.count - couunt)
        return [Element](suffix + prefix)
    }
}
