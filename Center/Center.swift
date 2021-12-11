//
//
//

import Foundation

public let center = CenterServer()

public struct CenterServer {
    public let router = Router()
    public let pokerPlusServer = PokerPlusServer()
    let userServer = UserServer()
    let dbServer = DBServer()
    let slotServer = SlotServer()
    
    public func onFirstLaunch() {
        // DBから先に初期化すること
        dbServer.onFirstLaunch()
        pokerPlusServer.onFirstLaunch()
        userServer.onFirstLaunch()
        slotServer.onFirstLaunch()
    }
    
    public func onLaunch() {
        dbServer.onLaunch()
        pokerPlusServer.onLaunch()
        userServer.onLaunch()
        slotServer.onLaunch()
    }
    
    public func deleteAll() {
        dbServer.deleteAllDatabase()
        pokerPlusServer.deleteAllMemory()
        userServer.deleteAllMemory()
        slotServer.deleteAllMemory()
    }
}
