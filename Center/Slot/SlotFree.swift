//
//
//

struct SlotFreeMachine: SlotMachine {
    
    let _reels: [Reel] = [
        Reel(
            id: .freeL,
            symbols: [
                .chip2,
                .chip0,
                .chip1,
                .chip0,
                .chip0,
                .chip3,
                .chip10,
                .chip0
            ]
        ),
        Reel(
            id: .freeC,
            symbols: [
                .chip0,
                .chip10,
                .chip0,
                .chip3,
                .chip1,
                .chip0,
                .chip0,
                .chip2
            ]
        ),
        Reel(
            id: .freeR,
            symbols: [
                .chip0,
                .chip2,
                .chip10,
                .chip0,
                .chip1,
                .chip0,
                .chip3,
                .chip0
            ]
        )
    ]
    
    let _oddsTableRows: [PrizeOdds.Table.Row] = [
        PrizeOdds.Table.Row(
            prizeID: String(SymbolId.chip10.rawValue),
            odds: 3,
            description: "チップ10枚"
        ),
        PrizeOdds.Table.Row(
            prizeID: String(SymbolId.chip3.rawValue),
            odds: 10,
            description: "チップ3枚"
        ),
        PrizeOdds.Table.Row(
            prizeID: String(SymbolId.chip2.rawValue),
            odds: 15,
            description: "チップ2枚"
        ),
        PrizeOdds.Table.Row(
            prizeID: String(SymbolId.chip1.rawValue),
            odds: 30,
            description: "チップ1枚"
        ),
        PrizeOdds.Table.Row(
            prizeID: "none",
            odds: 42,
            description: "はずれ"
        )
    ]
    
    func name() -> String {
        return "Free"
    }
    
    func spinChip() -> Int {
        return 0
    }
    
    func reels() -> [Reel] {
        return _reels
    }
    
    func oddsTableRows() -> [PrizeOdds.Table.Row] {
        return _oddsTableRows
    }
    
    func onTriad(symbolId: SymbolId, playingUserId: String) {
        var chipDiff = 0
        switch symbolId {
        case .chip1:
            chipDiff = 1
        case .chip2:
            chipDiff = 2
        case .chip3:
            chipDiff = 3
        case .chip10:
            chipDiff = 10
        default:
            break
        }
        let userRealm = UserRepository().read(whereID: playingUserId)
        let user = UserConverter().user(userRealm: userRealm)
        var updatedUser = user
        updatedUser.chips = user.chips + chipDiff
        let updatedUserRealm = UserConverter().userRealm(user: updatedUser)
        UserRepository().update(user: updatedUserRealm)
        return
    }
    
    func triadDescription(symbolId: SymbolId, playingUserId: String) -> String {
        var discription = "残念!ハズレ!"
        switch symbolId {
        case .chip1:
            discription = "チップ1枚獲得!"
        case .chip2:
            discription = "やった!チップ2枚獲得!"
        case .chip3:
            discription = "ラッキー!チップ3枚獲得!"
        case .chip10:
            discription = "おめでとう!チップ10枚獲得!"
        default:
            break
        }
        return discription
    }
}
