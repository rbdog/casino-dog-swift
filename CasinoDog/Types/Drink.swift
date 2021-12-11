//
//
//

enum Drink: Int, JSONSerializable {
    case champagne = 100
    case beer = 101
    case brandy = 102
    case cocktail = 103
    case liqueur = 104
    case spirits = 105
    case wine = 106
    
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
    
    var symbol: Symbol {
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
