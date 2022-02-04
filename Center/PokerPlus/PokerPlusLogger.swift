/*
 [!] Task for Dealer
 [?] Task for Player
 
 [-] Only Dealer can see
 [#] Dealer and the Player can see
 [+] Dealer and the All Players can see
 */

import SwiftUI

class PokerPlusLogger {

    var b1: String = "___"
    var b2: String = "___"
    var b3: String = "___"
    var b4: String = "___"

    var c1: String = "___"
    var c2: String = "___"
    var c3: String = "___"
    var c4: String = "___"

    var p1: String = "__"
    var p2: String = "__"
    var p3: String = "__"
    var p4: String = "__"

    var i1: String = "_"
    var i2: String = "_"
    var i3: String = "_"
    var i4: String = "_"

    var o1: String = "__"
    var o2: String = "__"
    var o3: String = "__"
    var o4: String = "__"

    var x1: String = "__ __ __"
    var x2: String = "__ __ __"
    var x3: String = "__ __ __"
    var x4: String = "__ __ __"

    func load(state: PokerPlusState) {
        
        guard let side1 = state.sides.first(where: {$0.seat == .s1}),
              let side2 = state.sides.first(where: {$0.seat == .s2}),
              let side3 = state.sides.first(where: {$0.seat == .s3}),
              let side4 = state.sides.first(where: {$0.seat == .s4}) else {
                  return
              }

        if let level = side1.betLevel {
            self.b1 = asciiBetLevel(level)
        } else {
            self.b1 = "   "
        }
        if let level = side2.betLevel {
            self.b2 = asciiBetLevel(level)
        } else {
            self.b2 = "   "
        }
        if let level = side3.betLevel {
            self.b3 = asciiBetLevel(level)
        } else {
            self.b3 = "   "
        }
        if let level = side4.betLevel {
            self.b4 = asciiBetLevel(level)
        } else {
            self.b4 = "   "
        }

        self.c1 = String(side1.chips).filled(to: 3)
        self.c2 = String(side2.chips).filled(to: 3)
        self.c3 = String(side3.chips).filled(to: 3, isLeading: true)
        self.c4 = String(side4.chips).filled(to: 3, isLeading: true)

        self.i1 = asciiInner(at: side1.seat, on: state.wheel)
        self.i2 = asciiInner(at: side2.seat, on: state.wheel)
        self.i3 = asciiInner(at: side3.seat, on: state.wheel)
        self.i4 = asciiInner(at: side4.seat, on: state.wheel)

        self.o1 = asciiOuter(at: side1.seat, on: state.wheel)
        self.o2 = asciiOuter(at: side2.seat, on: state.wheel)
        self.o3 = asciiOuter(at: side3.seat, on: state.wheel)
        self.o4 = asciiOuter(at: side4.seat, on: state.wheel)

        self.x1 = asciiHandCards(side1.handCardIds).filled(to: 8)
        self.x2 = asciiHandCards(side2.handCardIds).filled(to: 8)
        self.x3 = asciiHandCards(side3.handCardIds).filled(to: 8, isLeading: true)
        self.x4 = asciiHandCards(side4.handCardIds).filled(to: 8, isLeading: true)

        if let card = side1.putCardId {
            self.p1 = asciiCard(card)
        } else {
            self.p1 = "  "
        }
        if let card = side2.putCardId {
            self.p2 = asciiCard(card)
        } else {
            self.p2 = "  "
        }
        if let card = side3.putCardId {
            self.p3 = asciiCard(card)
        } else {
            self.p3 = "  "
        }
        if let card = side4.putCardId {
            self.p4 = asciiCard(card)
        } else {
            self.p4 = "  "
        }
    }

    func asciiLog() -> [String] {
        let texts = [
            "+-----------------------------------------------+",
            "| \(c4) : \(b4)             |             \(b1) : \(c1) |",
            "| \(x4)     +-----------------+     \(x1) |",
            "|              |    +-------+    |              |",
            "|           \(p4) | \(o4) | \(i4) | \(i1) | \(o1) | \(p1)           |",
            "|--------------|----|---+---|----|--------------|",
            "|           \(p3) | \(o3) | \(i3) | \(i2) | \(o2) | \(p2)           |",
            "|              |    +-------+    |              |",
            "| \(x3)     +-----------------+     \(x2) |",
            "| \(c3) : \(b3)             |             \(b2) : \(c2) |",
            "+-----------------------------------------------+"
        ]
        return texts
    }

    func printAsciiLog(with sideLogs: [String] = []) {
        let texts = self.asciiLog()
        for (index, text) in texts.enumerated() {
            print(text, " ", sideLogs[at: index] ?? "")
        }
    }
    
    func asciiCard(_ card: CardId) -> String {
        switch card {
        case .back:
            return "??"
        case .spade1:
            return "♠1"
        case .spade2:
            return "♠︎2"
        case .spade3:
            return "♠︎3"
        case .spade4:
            return "♠︎4"
        case .spade5:
            return "♠︎5"
        case .spade6:
            return "♠︎6"
        case .spade7:
            return "♠︎7"
        case .spade8:
            return "♠︎8"
        case .spade9:
            return "♠︎9"
        case .spade10:
            return "♠︎X"
        case .spade11:
            return "♠︎J"
        case .spade12:
            return "♠︎Q"
        case .spade13:
            return "♠︎K"
        case .heart1:
            return "♥1"
        case .heart2:
            return "♥2"
        case .heart3:
            return "♥3"
        case .heart4:
            return "♥4"
        case .heart5:
            return "♥5"
        case .heart6:
            return "♥6"
        case .heart7:
            return "♥7"
        case .heart8:
            return "♥8"
        case .heart9:
            return "♥9"
        case .heart10:
            return "♥X"
        case .heart11:
            return "♥J"
        case .heart12:
            return "♥Q"
        case .heart13:
            return "♥K"
        case .diamond1:
            return "♦1"
        case .diamond2:
            return "♦2"
        case .diamond3:
            return "♦3"
        case .diamond4:
            return "♦4"
        case .diamond5:
            return "♦5"
        case .diamond6:
            return "♦6"
        case .diamond7:
            return "♦7"
        case .diamond8:
            return "♦8"
        case .diamond9:
            return "♦9"
        case .diamond10:
            return "♦X"
        case .diamond11:
            return "♦J"
        case .diamond12:
            return "♦Q"
        case .diamond13:
            return "♦K"
        case .club1:
            return "♣1"
        case .club2:
            return "♣2"
        case .club3:
            return "♣3"
        case .club4:
            return "♣4"
        case .club5:
            return "♣5"
        case .club6:
            return "♣6"
        case .club7:
            return "♣7"
        case .club8:
            return "♣8"
        case .club9:
            return "♣9"
        case .club10:
            return "♣X"
        case .club11:
            return "♣J"
        case .club12:
            return "♣Q"
        case .club13:
            return "♣K"
        case .blackJocker:
            return "ZB"
        case .whiteJocker:
            return "ZW"
        }
    }
    
    func asciiBetLevel(_ level: PokerPlusBetLevel) -> String {
        switch level {
        case .min:
            return "Min"
        case .mid:
            return "Mid"
        case .max:
            return "Max"
        }
    }
    
    func asciiInner(at seat: PokerPlusSeat, on wheel: PokerPlusWheel) -> String {
        let seatOffset = seat.rawValue - 1
        var innerIndex = seatOffset - wheel.innerOffset
        if innerIndex < 0 {
            innerIndex += wheel.innerPartIds.count
        }
        let innerId = wheel.innerPartIds[innerIndex]
        switch innerId {
        case .club:
            return "♣"
        case .diamond:
            return "♦"
        case .heart:
            return "♥"
        case .joker:
            return "Z"
        }
    }
    
    func asciiOuter(at seat: PokerPlusSeat, on wheel: PokerPlusWheel) -> String {
        let seatOffset = seat.rawValue - 1
        var outerIndex = seatOffset - wheel.outerOffset
        if outerIndex < 0 {
            outerIndex += wheel.outerPartIds.count
        }
        let outerId = wheel.outerPartIds[outerIndex]
        switch outerId {
        case .heart1:
            return "♥1"
        case .diamond12:
            return "♦Q"
        case .club11:
            return "♣J"
        case .spade13:
            return "♠︎K"
        }
    }
    
    func asciiHandCards(_ cards: [CardId]) -> String {
        let text = cards.map({asciiCard($0)}).joined(separator: " ")
        return text
    }
}
