//
//
//

struct KeycardRealmRepository {
    func saveKeycards(_ keycards: [KeycardRealm]) {
        try! center.dbServer.getConnection().write {
            center.dbServer.getConnection().add(keycards, update: .all)
        }
    }
    
    func loadKeycard(userId: String) -> KeycardRealm? {
        let results = center.dbServer.getConnection().objects(KeycardRealm.self).filter("user_id = '\(userId)'")
        if let keycard = Array(results).first {
            return keycard
        }
        return nil
    }
    
    func loadKeycard(userId: String, secretId: String) -> KeycardRealm {
        let con = center.dbServer.getConnection()
        let results = con.objects(KeycardRealm.self).filter("user_id = '\(userId)' AND secret_id = '\(secretId)'")
        if let keycard = Array(results).first {
            return keycard
        }
        fatalError("キーカードが見つかりませんでした")
    }
    
    func loadKeycards(stateId: String) -> [KeycardRealm] {
        let results = center.dbServer.getConnection().objects(KeycardRealm.self).filter("state_id = '\(stateId)'")
        return Array(results)
    }
    
    func loadAllKeycards() -> [KeycardRealm] {
        let results = center.dbServer.getConnection().objects(KeycardRealm.self)
        return Array(results)
    }
    
    func deleteKeycard(userId: String, secretId: String) {
        let keycard = loadKeycard(userId: userId, secretId: secretId)
        try! center.dbServer.getConnection().write{
            center.dbServer.getConnection().delete(keycard)
        }
    }
    
    func deleteKeycards(stateId: String) {
        let keycards = loadKeycards(stateId: stateId)
        try! center.dbServer.getConnection().write{
            center.dbServer.getConnection().delete(keycards)
        }
    }
}
