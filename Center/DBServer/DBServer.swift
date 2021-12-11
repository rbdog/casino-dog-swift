//
//
//

import Foundation
import RealmSwift

struct DBServer {
    
    let state = DBServerState()
    
    func onFirstLaunch() {
        
    }
    
    func onLaunch() {
        
    }
    
    func getConnection() -> Realm {
        state.accessCount += 1
        
//        if state.realm == nil {
            let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
            state.realm = try! Realm(
                configuration: config
            )
//        }
        return state.realm
    }
    
    func deleteAllDatabase() {
        let con = getConnection()
        try! con.write {
            con.deleteAll()
        }
    }
}
