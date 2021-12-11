//
//
//

enum Symbol: Int, JSONSerializable {
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
        case .freeorange:
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
