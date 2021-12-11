//
//
//

enum SymbolID: Int, JSONSerializable {
    // Drink
    case champagne = 10000
    case beer = 10001
    case brandy = 10002
    case cocktail = 10003
    case liqueur = 10004
    case spirits = 10005
    case wine = 10006
    
    // Classic
    case bell = 20001
    case cherry = 20002
    case clover = 20003
    case horseshoe = 20004
    case luckySeven = 20005
    
    // Free
    case freeorange = 21001
    case chip1 = 21002
    case chip2 = 21003
    case chip3 = 21004
    case chip10 = 21005
    
    // Developer
    case plClag = 30001
    case plCPlusPlus = 30002
    case plCSharp = 30003
    case plDart = 30004
    case plGolang = 30005
    case plJava = 30006
    case plJavaScript = 30007
    case plKotlin = 30008
    case plPHP = 30009
    case plPython = 30010
    case plRuby = 30011
    case plSwift = 30012
    case plTypeScript = 30013
    
    // V1
    case appIcon = 31001
    case spade = 31002
    case heart = 31003
    case diamond = 31004
    case club = 31005
    case open = 31006
    case v1 = 31007
    
    var description: String {
        switch self {
        case .champagne:
            return "シャンパン"
        case .beer:
            return "ビール"
        case .brandy:
            return "ブランデー"
        case .cocktail:
            return "カクテル"
        case .liqueur:
            return "リキュール"
        case .spirits:
            return "スピリッツ"
        case .wine:
            return "ワイン"
        case .bell:
            return "ベル"
        case .cherry:
            return "チェリー"
        case .clover:
            return "クローバー"
        case .horseshoe:
            return "ホースシュー"
        case .luckySeven:
            return "ラッキーセブン"
        case .freeorange:
            return "フリーオレンジ"
        case .chip1:
            return "チップ1枚"
        case .chip2:
            return "チップ2枚"
        case .chip3:
            return "チップ3枚"
        case .chip10:
            return "チップ10枚"
        case .plClag:
            return "C言語"
        case .plCPlusPlus:
            return "C++言語"
        case .plCSharp:
            return "C#言語"
        case .plDart:
            return "Dart言語"
        case .plGolang:
            return "Go言語"
        case .plJava:
            return "Java言語"
        case .plJavaScript:
            return "JavaScript言語"
        case .plKotlin:
            return "Kotlin言語"
        case .plPHP:
            return "PHP言語"
        case .plPython:
            return "Python言語"
        case .plRuby:
            return "Ruby言語"
        case .plSwift:
            return "Swift言語"
        case .plTypeScript:
            return "TypeScript言語"
        case .appIcon:
            return "アプリアイコン"
        case .spade:
            return "スペード"
        case .heart:
            return "ハート"
        case .diamond:
            return "ダイヤ"
        case .club:
            return "クラブ"
        case .open:
            return "Open"
        case .v1:
            return "バージョン1.0.0"
        }
    }
    
    var imageURL: String {
        switch self {
        case .champagne:
            return "assets://symbol-champagne"
        case .beer:
            return "assets://symbol-beer"
        case .brandy:
            return "assets://symbol-brandy"
        case .cocktail:
            return "assets://symbol-cocktail"
        case .liqueur:
            return "assets://symbol-liqueur"
        case .spirits:
            return "assets://symbol-spirits"
        case .wine:
            return "assets://symbol-wine"
        case .bell:
            return "assets://symbol-bell"
        case .cherry:
            return "assets://symbol-cherry"
        case .clover:
            return "assets://symbol-clover"
        case .horseshoe:
            return "assets://symbol-horseshoe"
        case .luckySeven:
            return "assets://symbol-lucky-seven"
        case .freeorange:
            return "assets://symbol-freeorange"
        case .chip1:
            return "assets://symbol-chip1"
        case .chip2:
            return "assets://symbol-chip2"
        case .chip3:
            return "assets://symbol-chip3"
        case .chip10:
            return "assets://symbol-chip10"
        case .plClag:
            return "assets://symbol-pl-clang"
        case .plCPlusPlus:
            return "assets://symbol-pl-cplusplus"
        case .plCSharp:
            return "assets://symbol-pl-csharp"
        case .plDart:
            return "assets://symbol-pl-dart"
        case .plGolang:
            return "assets://symbol-pl-golang"
        case .plJava:
            return "assets://symbol-pl-java"
        case .plJavaScript:
            return "assets://symbol-pl-javascript"
        case .plKotlin:
            return "assets://symbol-pl-kotlin"
        case .plPHP:
            return "assets://symbol-pl-php"
        case .plPython:
            return "assets://symbol-pl-python"
        case .plRuby:
            return "assets://symbol-pl-ruby"
        case .plSwift:
            return "assets://symbol-pl-swift"
        case .plTypeScript:
            return "assets://symbol-pl-typescript"
        case .appIcon:
            return "assets://symbol-appicon"
        case .spade:
            return "assets://symbol-spade"
        case .heart:
            return "assets://symbol-heart"
        case .diamond:
            return "assets://symbol-diamond"
        case .club:
            return "assets://symbol-club"
        case .open:
            return "assets://symbol-open"
        case .v1:
            return "assets://symbol-v1"
        }
    }
}
