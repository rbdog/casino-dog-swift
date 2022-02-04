//
//
//

import Foundation
import SwiftUI

enum SlotsSpinSlot: HTTPAPI {
    static var urlPath = "/slots/spin-slot"
    static var httpMethod = HTTP.Method.GET
    
    struct Request: HTTPRequestBody {
        let user_id: String
        let machine_id: Int
    }
    struct Response: HTTPResponseBody {
        let reel_animations: [SlotReelAnimation]
        let triad_animation: SlotTriadAnimation?
        let new_pockets: [SymbolPocket]
        let new_chips: Int
        let error: ErrorModel?
    }
    
    static func run(request: Request) -> Response {
        
        let userRealm = UserRepository().read(whereID: request.user_id)
        let user = UserConverter().user(userRealm: userRealm)
        guard let machineID = MachineId(rawValue: request.machine_id) else {
            return Response(
                reel_animations: [],
                triad_animation: nil,
                new_pockets: user.symbol_pockets,
                new_chips: user.chips,
                error: ServiceError.slot001.apiModel
            )
        }
        
        // マシンインスタンスを取得
        let machine = machineID.machine()
        
        // もしユーザーの所持金が不足していたらエラーを返す
        let spinCost = machine.spinChip()
        if user.chips < spinCost {
            return Response(
                reel_animations: [],
                triad_animation: nil,
                new_pockets: user.symbol_pockets,
                new_chips: user.chips,
                error: ServiceError.slot002.apiModel
            )
        }
        
        // チップを払う
        var updatedUser = user
        updatedUser.chips = user.chips - spinCost
        let updatedUserRealm = UserConverter().userRealm(user: updatedUser)
        UserRepository().update(user: updatedUserRealm)
        
        // 回した結果を取得
        let prizeOdds = PrizeOdds(table: PrizeOdds.Table(rows: machine.oddsTableRows()))
        let symbolID = prizeOdds.randomRowWithOdds().prizeID
        
        if symbolID == "none" {
            // はずれ
            print("はずれ")
            var symbols: [SymbolId] = machine.reels().map({$0.symbols.randomElement()!})
            if Set(symbols).count <= 1 {
                // 偶然揃ってしまった場合は最後の要素だけ削ってやり直し
                var lastReelSymbols = machine.reels().last!.symbols
                lastReelSymbols.removeAll(where: {$0 == symbols.first!})
                
                symbols.removeLast()
                symbols.append(lastReelSymbols.randomElement()!)
            }
            
            let reelAnimations = machine.reels().enumerated().map({ reel -> SlotReelAnimation in
                let stopIndexes = reel.element.symbols.indexes(where: {$0 == symbols[reel.offset]})
                return .init(symbols: reel.element.symbols, stop_index: stopIndexes)
            })
            
            return Response(
                reel_animations: reelAnimations,
                triad_animation: nil,
                new_pockets: updatedUser.symbol_pockets,
                new_chips: updatedUser.chips,
                error: nil
            )
            
        } else {
            // あたり
            
            let triadSymbol = SymbolId(rawValue: Int(symbolID)!)!
            // 保存操作等の副作用あり
            machine.onTriad(symbolId: triadSymbol, playingUserId: user.id)
            let updatedUserRealm = UserRepository().read(whereID: user.id)
            let updatedUser = UserConverter().user(userRealm: updatedUserRealm)
            
            let description = machine.triadDescription(symbolId: triadSymbol, playingUserId: user.id)
            
            var reelAnimations: [SlotReelAnimation] = []
            for reel in machine.reels() {
                let indexes = reel.symbols.indexes(where: {$0 == triadSymbol})
                reelAnimations.append(.init(symbols: reel.symbols, stop_index: indexes))
            }
            
            let triadAnimation = SlotTriadAnimation(
                symbol: triadSymbol,
                image_url: triadSymbol.imageURL,
                title: triadSymbol.description,
                description: description
            )
            
            return Response(
                reel_animations: reelAnimations,
                triad_animation: triadAnimation,
                new_pockets: updatedUser.symbol_pockets,
                new_chips: updatedUser.chips,
                error: nil
            )
        }
    }
}
