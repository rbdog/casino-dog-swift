//
//
//

enum MenuItemID {
    case developerMessage
    case lisense
    case termsOfService
    case debug
    
    static func availableList() -> [MenuItemID] {
        return [
            .developerMessage,
            .lisense,
            .termsOfService,
            .debug
        ]
    }
    
    func systemName() -> String {
        switch self {
        case .developerMessage:
            return "envelope"
        case .lisense:
            return "shield"
        case .termsOfService:
            return "paperclip"
        case .debug:
            return "hammer"
        }
    }
    
    func nickname() -> String {
        switch self {
        case .developerMessage:
            return "開発者者より"
        case .lisense:
            return "ライセンス"
        case .termsOfService:
            return "利用規約"
        case .debug:
            return "DEBUG"
        }
    }
}
