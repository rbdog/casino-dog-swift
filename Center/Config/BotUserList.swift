//
//
//

import Foundation

struct BotUserList {
    func botUsers() -> [BotUser] {
        return [
            .init(userId: "Bot1", nickname: "ディッキー", iconUrl: "assets://icon-bot1"),
            .init(userId: "Bot2", nickname: "ウーリー", iconUrl: "assets://icon-bot2"),
            .init(userId: "Bot3", nickname: "アントン", iconUrl: "assets://icon-bot3"),
            .init(userId: "Bot4", nickname: "アルバート", iconUrl: "assets://icon-bot4"),
            .init(userId: "Bot5", nickname: "マックス", iconUrl: "assets://icon-bot5"),
            .init(userId: "Bot6", nickname: "トフィー", iconUrl: "assets://icon-bot6"),
            .init(userId: "Bot7", nickname: "ハリー", iconUrl: "assets://icon-bot7"),
            .init(userId: "Bot8", nickname: "ベルナルド", iconUrl: "assets://icon-bot8"),
            .init(userId: "Bot9", nickname: "ベーター", iconUrl: "assets://icon-bot9"),
            .init(userId: "Bot10", nickname: "ヘルマン", iconUrl: "assets://icon-bot10"),
            .init(userId: "Bot11", nickname: "ロイ", iconUrl: "assets://icon-bot11")
        ]
    }
    
    func botUser(id: String) -> BotUser {
        let unknownBotUser = BotUser(userId: "Bot0", nickname: "不明なボット", iconUrl: "assets://icon-bot")
        return botUsers().first(where: {$0.userId == id}) ?? unknownBotUser
    }
}
