//
//
//

enum SymbolId: Int, JSONSerializable {
    // Drink
    case champagne = 0
    case beer = 1
    case brandy = 2
    case cocktail = 3
    case liqueur = 4
    case spirits = 5
    case wine = 6
    
    // Classic
    case bell = 7
    case cherry = 8
    case clover = 9
    case horseshoe = 10
    case luckySeven = 11
    
    // Free
    case freeorange = 12
    case chip1 = 13
    case chip2 = 14
    case chip3 = 15
    case chip10 = 16
    
    // Developer
    case plClag = 17
    case plCPlusPlus = 18
    case plCSharp = 19
    case plDart = 20
    case plGolang = 21
    case plJava = 22
    case plJavaScript = 23
    case plKotlin = 24
    case plPHP = 25
    case plPython = 26
    case plRuby = 27
    case plSwift = 28
    case plTypeScript = 29
    
    // V1
    case appIcon = 30
    case spade = 31
    case heart = 32
    case diamond = 33
    case club = 34
    case open = 35
    case v1 = 36
    
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
