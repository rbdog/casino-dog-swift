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
    case chip0 = 12
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
    
    var imageName: ImageName.Symbol {
        switch self {
        case .champagne:
            return .champagne
        case .beer:
            return .beer
        case .brandy:
            return .brandy
        case .cocktail:
            return .cocktail
        case .liqueur:
            return .liqueur
        case .spirits:
            return .spirits
        case .wine:
            return .wine
        case .bell:
            return .bell
        case .cherry:
            return .cherry
        case .clover:
            return .clover
        case .horseshoe:
            return .horseshoe
        case .luckySeven:
            return .luckySeven
        case .chip0:
            return .freeorange
        case .chip1:
            return .chip1
        case .chip2:
            return .chip2
        case .chip3:
            return .chip3
        case .chip10:
            return .chip10
        case .plClag:
            return .plClag
        case .plCPlusPlus:
            return .plCPlusPlus
        case .plCSharp:
            return .plCSharp
        case .plDart:
            return .plDart
        case .plGolang:
            return .plGolang
        case .plJava:
            return .plJava
        case .plJavaScript:
            return .plJavaScript
        case .plKotlin:
            return .plKotlin
        case .plPHP:
            return .plPHP
        case .plPython:
            return .plPython
        case .plRuby:
            return .plRuby
        case .plSwift:
            return .plSwift
        case .plTypeScript:
            return .plTypeScript
        case .appIcon:
            return .appIcon
        case .spade:
            return .spade
        case .heart:
            return .heart
        case .diamond:
            return .diamond
        case .club:
            return .club
        case .open:
            return .open
        case .v1:
            return .v1
        }
    }
}
