//
//
//

struct SlotV1M1Machine: SlotMachine {
    
    let _reels: [Reel] = [
        Reel(
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
            prizeID: String(SymbolID.spade.rawValue),
            odds: 3,
            description: "スペード"
        ),
        PrizeOdds.Table.Row(
            prizeID: String(SymbolID.heart.rawValue),
            odds: 3,
            description: "ハート"
        ),
        PrizeOdds.Table.Row(
            prizeID: String(SymbolID.diamond.rawValue),
            odds: 3,
            description: "ダイヤ"
        ),
        PrizeOdds.Table.Row(
            prizeID: String(SymbolID.club.rawValue),
            odds: 3,
            description: "クラブ"
        ),
        PrizeOdds.Table.Row(
            prizeID: String(SymbolID.v1.rawValue),
            odds: 1,
            description: "v1.0.0"
        ),
        PrizeOdds.Table.Row(
            prizeID: String(SymbolID.open.rawValue),
            odds: 1,
            description: "Open"
        ),
        PrizeOdds.Table.Row(
            prizeID: String(SymbolID.appIcon.rawValue),
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
