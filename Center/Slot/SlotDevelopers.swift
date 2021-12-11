//
//
//

struct SlotDevelopersMachine: SlotMachine {
    
    let _reels: [Reel] = [
        Reel(
            symbols: [
                .plClag,
                .plCPlusPlus,
                .plCSharp,
                .plDart,
                .plGolang,
                .plJava,
                .plJavaScript,
                .plKotlin,
                .plPHP,
                .plPython,
                .plRuby,
                .plSwift,
                .plTypeScript
            ]
        ),
        Reel(
            symbols: [
                .plTypeScript,
                .plSwift,
                .plRuby,
                .plPython,
                .plPHP,
                .plKotlin,
                .plJavaScript,
                .plJava,
                .plGolang,
                .plDart,
                .plCSharp,
                .plCPlusPlus,
                .plClag
            ]
        ),
        Reel(
            symbols: [
                .plSwift,
                .plPython,
                .plTypeScript,
                .plKotlin,
                .plDart,
                .plJavaScript,
                .plCPlusPlus,
                .plGolang,
                .plClag,
                .plJava,
                .plCSharp,
                .plRuby,
                .plPHP
            ]
        )
    ]
    
    let _oddsTableRows: [PrizeOdds.Table.Row] = [
        PrizeOdds.Table.Row(
            prizeID: String(SymbolID.plSwift.rawValue),
            odds: 1.0,
            description: "Swift言語"
        ),
        PrizeOdds.Table.Row(
            prizeID: String(SymbolID.plPython.rawValue),
            odds: 1.0,
            description: "Python言語"
        ),
        PrizeOdds.Table.Row(
            prizeID: String(SymbolID.plTypeScript.rawValue),
            odds: 1.0,
            description: "TypeScript言語"
        ),
        PrizeOdds.Table.Row(
            prizeID: String(SymbolID.plKotlin.rawValue),
            odds: 1.0,
            description: "Kotlin言語"
        ),
        PrizeOdds.Table.Row(
            prizeID: String(SymbolID.plDart.rawValue),
            odds: 1.0,
            description: "Dart言語"
        ),
        PrizeOdds.Table.Row(
            prizeID: String(SymbolID.plJavaScript.rawValue),
            odds: 1.0,
            description: "JavaScript言語"
        ),
        PrizeOdds.Table.Row(
            prizeID: String(SymbolID.plCPlusPlus.rawValue),
            odds: 1.0,
            description: "C++言語"
        ),
        PrizeOdds.Table.Row(
            prizeID: String(SymbolID.plGolang.rawValue),
            odds: 1.0,
            description: "Go言語"
        ),
        PrizeOdds.Table.Row(
            prizeID: String(SymbolID.plClag.rawValue),
            odds: 1.0,
            description: "C言語"
        ),
        PrizeOdds.Table.Row(
            prizeID: String(SymbolID.plJava.rawValue),
            odds: 1.0,
            description: "Java言語"
        ),
        PrizeOdds.Table.Row(
            prizeID: String(SymbolID.plCSharp.rawValue),
            odds: 1.0,
            description: "C#言語"
        ),
        PrizeOdds.Table.Row(
            prizeID: String(SymbolID.plRuby.rawValue),
            odds: 1.0,
            description: "Ruby言語"
        ),
        PrizeOdds.Table.Row(
            prizeID: String(SymbolID.plPHP.rawValue),
            odds: 1.0,
            description: "PHP言語"
        ),
        PrizeOdds.Table.Row(
            prizeID: "none",
            odds: 87.0,
            description: "はずれ"
        )
    ]
    
    func name() -> String {
        return "デベロッパーズ"
    }
    
    func spinChip() -> Int {
        return 10
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
