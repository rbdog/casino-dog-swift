//
//
//

import Foundation
import SwiftUI

// TODO: - サーバーから取得する
struct MachineList {
    
    func machine(id: MachineId) -> Machine {
        return machines.first(where: {$0.id == id})!
    }
    
    let reels: [Reel] = [
        Reel(
            id: .classicL,
            symbols: [
                .luckySeven,
                .cherry,
                .clover,
                .bell,
                .horseshoe,
                .cherry,
                .clover,
                .bell
            ]
        ),
        Reel(
            id: .classicC,
            symbols: [
                .clover,
                .luckySeven,
                .bell,
                .cherry,
                .clover,
                .horseshoe,
                .bell,
                .cherry
            ]
        ),
        Reel(
            id: .classicR,
            symbols: [
                .cherry,
                .bell,
                .horseshoe,
                .clover,
                .cherry,
                .bell,
                .horseshoe,
                .luckySeven
            ]
        ),
        Reel(
            id: .freeL,
            symbols: [
                .chip2,
                .freeorange,
                .chip1,
                .freeorange,
                .freeorange,
                .chip3,
                .chip10,
                .freeorange
            ]
        ),
        Reel(
            id: .freeC,
            symbols: [
                .freeorange,
                .chip10,
                .freeorange,
                .chip3,
                .chip1,
                .freeorange,
                .freeorange,
                .chip2
            ]
        ),
        Reel(
            id: .freeR,
            symbols: [
                .freeorange,
                .chip2,
                .chip10,
                .freeorange,
                .chip1,
                .freeorange,
                .chip3,
                .freeorange
            ]
        ),
        Reel(
            id: .developerL,
            symbols: [
                .plClag,
                .plCPlusPlus,
                .plCSharp,
                .plDart,
                .plGolang,
                .plJava,
                .plJavaScript,
                .plKotlin,
                .plPHP,
                .plPython,
                .plRuby,
                .plSwift,
                .plTypeScript
            ]
        ),
        Reel(
            id: .developerC,
            symbols: [
                .plTypeScript,
                .plSwift,
                .plRuby,
                .plPython,
                .plPHP,
                .plKotlin,
                .plJavaScript,
                .plJava,
                .plGolang,
                .plDart,
                .plCSharp,
                .plCPlusPlus,
                .plClag
            ]
        ),
        Reel(
            id: .developerR,
            symbols: [
                .plSwift,
                .plPython,
                .plTypeScript,
                .plKotlin,
                .plDart,
                .plJavaScript,
                .plCPlusPlus,
                .plGolang,
                .plClag,
                .plJava,
                .plCSharp,
                .plRuby,
                .plPHP
            ]
        ),
        Reel(
            id: .v1L,
            symbols: [
                .diamond,
                .club,
                .appIcon,
                .spade,
                .open,
                .heart,
                .v1,
                .heart
            ]
        ),
        Reel(
            id: .v1C,
            symbols: [
                .diamond,
                .v1,
                .spade,
                .appIcon,
                .club,
                .heart,
                .open,
                .spade
            ]
        ),
        Reel(
            id: .v1R,
            symbols: [
                .spade,
                .v1,
                .open,
                .club,
                .diamond,
                .heart,
                .appIcon,
                .diamond
            ]
        ),
    ]
    
    let machines: [Machine] = [
        Machine(
            id: .classic,
            name: "クラシック",
            miniImageUrl: "assets://" + ImageName.Slot.machineClassicFlat.rawValue,
            accentColorHex: Color.plusRed.hexString(),
            baseColorHex: Color.plusBlack.hexString(),
            borderColorHex: Color.plusGold.hexString(),
            reels: [
                .classicL,
                .classicC,
                .classicR,
            ],
            spinCost: 20,
            memberSymbols: [
                .cherry,
                .bell,
                .clover,
                .horseshoe,
                .luckySeven,
            ]
        ), // classic
        Machine(
            id: .free,
            name: "Free",
            miniImageUrl: "assets://" + ImageName.Slot.machineFreeFlat.rawValue,
            accentColorHex: Color.plusLightGreen.hexString(),
            baseColorHex: Color.plusDarkGreen.hexString(),
            borderColorHex: Color.plusBlack.hexString(),
            reels: [
                .freeL,
                .freeC,
                .freeR
            ],
            spinCost: 0,
            memberSymbols: [
                .chip1,
                .chip2,
                .chip3,
                .chip10
            ]
        ), // free
        Machine(
            id: .developers,
            name: "デベロッパーズ",
            miniImageUrl: "assets://" + ImageName.Slot.machinePlangFlat.rawValue,
            accentColorHex: "#595959",
            baseColorHex: "#202020",
            borderColorHex: Color.plusLightGreen.hexString(),
            reels: [
                .developerL,
                .developerC,
                .developerR,
            ],
            spinCost: 10,
            memberSymbols: [
                .plClag,
                .plCPlusPlus,
                .plCSharp,
                .plDart,
                .plGolang,
                .plJava,
                .plJavaScript,
                .plKotlin,
                .plPHP,
                .plPython,
                .plRuby,
                .plSwift,
                .plTypeScript
            ]
        ), // developers
        Machine(
            id: .v1,
            name: "バージョン1.0リリース記念",
            miniImageUrl: "assets://" + ImageName.Slot.machineV1Flat.rawValue,
            accentColorHex: Color.plusBlue.hexString(),
            baseColorHex: "#191970",
            borderColorHex: Color.plusGold.hexString(),
            reels: [
                .v1L,
                .v1C,
                .v1R,
            ],
            spinCost: 5,
            memberSymbols: [
                .spade,
                .heart,
                .diamond,
                .club,
                .v1,
                .open,
                .appIcon
            ]
        )
    ]
}
