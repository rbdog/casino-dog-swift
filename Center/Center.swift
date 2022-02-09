//
//
//

import Foundation

public let center = CenterServer()

public struct CenterServer {
    public let router = Router()
    public let partycakeServer = PartycakeServer()
    let userServer = UserServer()
    let dbServer = DBServer()
    let slotServer = SlotServer()
    
    public func onFirstLaunch() {
        // DBから先に初期化すること
        dbServer.onFirstLaunch()
        partycakeServer.onFirstLaunch()
        userServer.onFirstLaunch()
        slotServer.onFirstLaunch()
    }
    
    public func onLaunch() {
        dbServer.onLaunch()
        partycakeServer.onLaunch()
        userServer.onLaunch()
        slotServer.onLaunch()
    }
    
    public func deleteAll() {
        dbServer.deleteAllDatabase()
        partycakeServer.deleteAllMemory()
        userServer.deleteAllMemory()
        slotServer.deleteAllMemory()
    }
}
