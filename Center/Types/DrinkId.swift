//
//
//

enum DrinkId: Int, JSONSerializable {
    case champagne = 0
    case beer = 1
    case brandy = 2
    case cocktail = 3
    case liqueur = 4
    case spirits = 5
    case wine = 6
    
    var symbol: SymbolId {
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
