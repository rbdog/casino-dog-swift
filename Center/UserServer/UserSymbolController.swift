//
//
//

import Foundation

struct UserSymbolController {
    
    func userHasEmptyPocket(user: User, newSymbol: SymbolId) -> Bool {
        let pockets: [SymbolPocket] = user.symbol_pockets
        if let pocketIndex = pockets.firstIndex(where: {$0.symbol_id == newSymbol.rawValue}) {
            // すでに所持していた場合
            let oldPocket = pockets[pocketIndex]
            if  oldPocket.count >= 99 {
                // 99 個以上の場合
                return false
            } else {
                // 99 個未満の場合
                return true
            }
        } else {
            // まだ持っていない時
            if pockets.firstIndex(where: {$0.count == 0}) != nil {
                // 空のポケットを見つけた
                return true
            } else {
                return false
            }
        }
    }
    
    func userGetSymbol(user: User, newSymbol: SymbolId) -> User {
        var pockets: [SymbolPocket] = user.symbol_pockets
        
        if let pocketIndex = pockets.firstIndex(where: {$0.symbol_id == newSymbol.rawValue}) {
            // すでに所持していた場合
            let oldPocket = pockets[pocketIndex]
            if  oldPocket.count >= 99 {
                // 99 個以上の場合
                fatalError("ポケットがいっぱいです")
            } else {
                // 99 個未満の場合
                let newPocket = SymbolPocket(
                    symbol_id: oldPocket.symbol_id, count: oldPocket.count + 1
                )
                pockets[pocketIndex] = newPocket
            }
        } else {
            // まだ持っていない時
            if let emptyIndex = pockets.firstIndex(where: {$0.count == 0}) {
                // 空のポケットを見つけた
                let newPocket = SymbolPocket(
                    symbol_id: newSymbol.rawValue, count: 1
                )
                pockets[emptyIndex] = newPocket
            } else {
                fatalError("コレクションがいっぱいです")
            }
        }

        var newUser = user
        newUser.symbol_pockets = pockets
        return newUser
    }
}
