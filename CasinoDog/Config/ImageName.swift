//
//
//

enum ImageName {
    enum Splash: String {
        case splash = "splash"
    }
    
    enum Cake: String {
        case inner = "partycake-inner"
        case outer = "partycake-outer"
    }
    
    enum Card: String {
        case spade1 = "card-spade1"
        case spade11 = "card-spade11"
        case spade12 = "card-spade12"
        case heart1 = "card-heart1"
        case heart11 = "card-heart11"
        case heart12 = "card-heart12"
        case diamond11 = "card-diamond11"
        case diamond12 = "card-diamond12"
        case diamond13 = "card-diamond13"
        case club11 = "card-club11"
        case club13 = "card-club13"
        case club12 = "card-club12"
        case partycakePutBox = "partycake-put-box"
        case back = "card-back"
    }
    
    enum Icon: String {
        case guest = "icon-guest"
        case bot1 = "icon-bot1"
        case bot2 = "icon-bot2"
        case bot3 = "icon-bot3"
        case bot4 = "icon-bot4"
        case bot5 = "icon-bot5"
        case bot6 = "icon-bot6"
        case bot7 = "icon-bot7"
        case bot8 = "icon-bot8"
        case bot9 = "icon-bot9"
        case bot10 = "icon-bot10"
        case bot11 = "icon-bot11"
    }
    
    enum Chip: String {
        case `default` = "chip"
        case flat = "chip-flat"
        case chip7 = "chip7"
        case chip5 = "chip5"
        case chip3 = "chip3"
    }
    
    enum Effect: String {
        case jack = "partycake-effect-j"
        case queen = "partycake-effect-q"
        case king = "partycake-effect-k"
    }
    
    enum Score {
        enum Card: String {
            case spade1 = "card-spade1-flat"
            case heart1 = "card-heart1-flat"
            case diamond13 = "card-diamond13-flat"
            case club13 = "card-club13-flat"
            case spade12 = "card-spade12-flat"
            case heart12 = "card-heart12-flat"
            case diamond12 = "card-diamond12-flat"
            case club12 = "card-club12-flat"
            case spade11 = "card-spade11-flat"
            case heart11 = "card-heart11-flat"
            case diamond11 = "card-diamond11-flat"
            case club11 = "card-club11-flat"
            case empty = "partycake-put-box"
            case back = "card-back"
        }
        enum Inner: String {
            case club = "partycake-inner-club-flat"
            case heart = "partycake-inner-heart-flat"
            case joker = "partycake-inner-joker-flat"
            case diamond = "partycake-inner-diamond-flat"
        }
        enum Outer: String {
            case diamond12 = "partycake-outer-diamond12-flat"
            case club11 = "partycake-outer-club11-flat"
            case spade13 = "partycake-outer-spade13-flat"
            case heart1 = "partycake-outer-heart1-flat"
        }
    }
    
    enum Dice: String {
        case face0 = "dice-face0"
        case face1 = "dice-face1"
        case face2 = "dice-face2"
        case face3 = "dice-face3"
        case face4 = "dice-face4"
        case face5 = "dice-face5"
        case face6 = "dice-face6"
    }
    
    enum Drink: String {
        case champagne = "drink-champagne"
        case beer = "drink-beer"
        case brandy = "drink-brandy"
        case cocktail = "drink-cocktail"
        case liqueur = "drink-liqueur"
        case spirits = "drink-spirits"
        case wine = "drink-wine"
    }
    
    enum Slot: String {
        case slotFlat = "slot-flat"
        case machineClassicFlat = "slot-machine-classic-flat"
        case machineFreeFlat = "slot-machine-free-flat"
        case machinePlangFlat = "slot-machine-plang-flat"
        case machineV1Flat = "slot-machine-v1-flat"
    }
    
    enum Game: String {
        case partycake = "game-partycake"
    }
    
    enum Symbol: String {
        case champagne = "symbol-champagne"
        case beer = "symbol-beer"
        case brandy = "symbol-brandy"
        case cocktail = "symbol-cocktail"
        case liqueur = "symbol-liqueur"
        case spirits = "symbol-spirits"
        case wine = "symbol-wine"
        
        case bell = "symbol-bell"
        case cherry = "symbol-cherry"
        case clover = "symbol-clover"
        case horseshoe = "symbol-horseshoe"
        case luckySeven = "symbol-lucky-seven"
        case slotFlat = "slot-flat"
        
        case plClag = "symbol-pl-clang"
        case plCPlusPlus = "symbol-pl-cplusplus"
        case plCSharp = "symbol-pl-csharp"
        case plDart = "symbol-pl-dart"
        case plGolang = "symbol-pl-golang"
        case plJava = "symbol-pl-java"
        case plJavaScript = "symbol-pl-javascript"
        case plKotlin = "symbol-pl-kotlin"
        case plPHP = "symbol-pl-php"
        case plPython = "symbol-pl-python"
        case plRuby = "symbol-pl-ruby"
        case plSwift = "symbol-pl-swift"
        case plTypeScript = "symbol-pl-typescript"
        
        case chip1 = "symbol-chip1"
        case chip2 = "symbol-chip2"
        case chip3 = "symbol-chip3"
        case chip10 = "symbol-chip10"
        case freeorange = "symbol-chip0"
        
        case appIcon = "symbol-appicon"
        case spade = "symbol-spade"
        case heart = "symbol-heart"
        case diamond = "symbol-diamond"
        case club = "symbol-club"
        case open = "symbol-open"
        case v1 = "symbol-v1"
    }
}
