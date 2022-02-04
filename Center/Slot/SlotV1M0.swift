//
//
//

struct SlotV1Machine: SlotMachine {
    
    let _reels: [Reel] = [
        Reel(
            id: .v1L,
            symbols: [
                .diamond,
                .club,
                .appIcon,
                .spade,
                .open,
                .heart,
                .v1,
                .heart
            ]
        ),
        Reel(
            id: .v1C,
            symbols: [
                .diamond,
                .v1,
                .spade,
                .appIcon,
                .club,
                .heart,
                .open,
                .spade
            ]
        ),
        Reel(
            id: .v1R,
            symbols: [
                .spade,
                .v1,
                .open,
                .club,
                .diamond,
                .heart,
                .appIcon,
                .diamond
            ]
        )
    ]
    
    let _oddsTableRows: [PrizeOdds.Table.Row] = [
        PrizeOdds.Table.Row(
            prizeID: String(SymbolId.spade.rawValue),
            odds: 3,
            description: "スペード"
        ),
        PrizeOdds.Table.Row(
            prizeID: String(SymbolId.heart.rawValue),
            odds: 3,
            description: "ハート"
        ),
        PrizeOdds.Table.Row(
            prizeID: String(SymbolId.diamond.rawValue),
            odds: 3,
            description: "ダイヤ"
        ),
        PrizeOdds.Table.Row(
            prizeID: String(SymbolId.club.rawValue),
            odds: 3,
            description: "クラブ"
        ),
        PrizeOdds.Table.Row(
            prizeID: String(SymbolId.v1.rawValue),
            odds: 1,
            description: "v1.0.0"
        ),
        PrizeOdds.Table.Row(
            prizeID: String(SymbolId.open.rawValue),
            odds: 1,
            description: "Open"
        ),
        PrizeOdds.Table.Row(
            prizeID: String(SymbolId.appIcon.rawValue),
            odds: 0.5,
            description: "アプリアイコン"
        ),
        PrizeOdds.Table.Row(
            prizeID: "none",
            odds: 85.5,
            description: "はずれ"
        )
    ]
    
    func name() -> String {
        return "バージョン1.0リリース記念"
    }
    
    func spinChip() -> Int {
        return 5
    }
    
    func reels() -> [Reel] {
        return _reels
    }
    
    func oddsTableRows() -> [PrizeOdds.Table.Row] {
        return _oddsTableRows
    }
    
    func onTriad(symbolId: SymbolId, playingUserId: String) {
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
    
    func triadDescription(symbolId: SymbolId, playingUserId: String) -> String {
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
