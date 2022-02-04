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
    
    var imageName: ImageName.Drink {
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
    
    var text: String {
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
        }
    }
}
