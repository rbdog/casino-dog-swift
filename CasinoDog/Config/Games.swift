//
//
//

import Foundation

let games: [Game] = [
    Game(
        id: .partycake,
        title: "ポーカー+",
        imageUrl: "assets://game-partycake",
        playCost: 20,
        minPlayerCount: 4,
        maxPlayerCount: 4
    ),
    Game(
        id: .comingSoon,
        title: "???",
        imageUrl: "assets://game-coming-soon",
        playCost: 99999,
        minPlayerCount: 99,
        maxPlayerCount: 99
    ),
]

func game(id: GameId) -> Game {
    return games.first(where: {$0.id == id})!
}
