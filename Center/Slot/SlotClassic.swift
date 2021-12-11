//
//
//

struct SlotClassicMachine: SlotMachine {
    
    let _reels: [Reel] = [
        Reel(
            symbols: [
                .luckySeven,
                .cherry,
                .clover,
                .bell,
                .horseshoe,
                .cherry,
                .clover,
                .bell
            ]
        ),
        Reel(
            symbols: [
                .clover,
                .luckySeven,
                .bell,
                .cherry,
                .clover,
                .horseshoe,
                .bell,
                .cherry
            ]
        ),
        Reel(
            symbols: [
                .cherry,
                .bell,
                .horseshoe,
                .clover,
                .cherry,
                .bell,
                .horseshoe,
                .luckySeven
            ]
        )
    ]
    
    let _oddsTableRows: [PrizeOdds.Table.Row] = [
        PrizeOdds.Table.Row(
            prizeID: String(SymbolID.bell.rawValue),
            odds: 5,
            description: "ベル"
        ),
        PrizeOdds.Table.Row(
            prizeID: String(SymbolID.cherry.rawValue),
            odds: 5,
            description: "チェリー"
        ),
        PrizeOdds.Table.Row(
            prizeID: String(SymbolID.clover.rawValue),
            odds: 3,
            description: "クローバー"
        ),
        PrizeOdds.Table.Row(
            prizeID: String(SymbolID.horseshoe.rawValue),
            odds: 1,
            description: "ホースシュー"
        ),
        PrizeOdds.Table.Row(
            prizeID: String(SymbolID.luckySeven.rawValue),
            odds: 0.5,
            description: "ラッキーセブン"
        ),
        PrizeOdds.Table.Row(
            prizeID: "none",
            odds: 85.5,
            description: "はずれ"
        )
    ]
        
    func name() -> String {
        return "クラシック"
    }
    
    func spinChip() -> Int {
        return 20
    }
    
    func reels() -> [Reel] {
        return _reels
    }
    
    func oddsTableRows() -> [PrizeOdds.Table.Row] {
        return _oddsTableRows
    }
    
    func onTriad(symbolId: SymbolID, playingUserId: String) {
        let userRealm = UserRepository().read(whereID: playingUserId)
        let user = UserConverter().user(userRealm: userRealm)
        let hasEmptyPocket = UserSymbolController().userHasEmptyPocket(user: user, newSymbol: symbolId)
        
        if hasEmptyPocket {
            let updatedUser = UserSymbolController().userGetSymbol(user: user, newSymbol: symbolId)
            let updatedUserRealm = UserConverter().userRealm(user: updatedUser)
            UserRepository().update(user: updatedUserRealm)
        } else {
            print("空きスペースがありません")
        }
    }
    
    func triadDescription(symbolId: SymbolID, playingUserId: String) -> String {
        let userRealm = UserRepository().read(whereID: playingUserId)
        let user = UserConverter().user(userRealm: userRealm)
        let hasEmptyPocket = UserSymbolController().userHasEmptyPocket(user: user, newSymbol: symbolId)
        if hasEmptyPocket {
            return "シンボルを獲得しました"
        } else {
            return "空きスペースがありません"
        }
    }
}
