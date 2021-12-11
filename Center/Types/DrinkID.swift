//
//
//

enum DrinkID: Int, JSONSerializable {
    case champagne = 100
    case beer = 101
    case brandy = 102
    case cocktail = 103
    case liqueur = 104
    case spirits = 105
    case wine = 106
    
    var symbol: SymbolID {
        switch self {
        case .champagne: return .champagne
        case .beer: return .beer
        case .brandy: return .brandy
        case .cocktail: return .cocktail
        case .liqueur: return .liqueur
        case .spirits: return .spirits
        case .wine: return .wine
        }
    }
}
