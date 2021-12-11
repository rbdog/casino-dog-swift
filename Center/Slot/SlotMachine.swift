//
//
//

import Foundation

protocol SlotMachine {
    func name() -> String
    func spinChip() -> Int
    func reels() -> [Reel]
    func oddsTableRows() -> [PrizeOdds.Table.Row]
    func onTriad(symbolId: SymbolID, playingUserId: String)
    func triadDescription(symbolId: SymbolID, playingUserId: String) -> String
}

extension SlotMachine {
    static func test(machine: SlotMachine) {
        PrizeOdds(table: .init(rows: machine.oddsTableRows())).test(times: 10000)
    }
}
