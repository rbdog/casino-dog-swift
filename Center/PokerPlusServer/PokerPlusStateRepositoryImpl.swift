//
//
//

struct PokerPlusStateRepositoryImpl: PokerPlusStateRepository {
    
    func saveState(_ state: PokerPlusState) {
        let jsonValue = String(data: state.jsonData, encoding: .utf8)!
        let stateRealm = PokerPlusStateRealm(
            stateId: state.id,
            value: jsonValue
        )
        try! center.dbServer.getConnection().write {
            center.dbServer.getConnection().add(stateRealm, update: .all)
        }
    }
    
    func loadState(id: String) -> PokerPlusState {
        guard let stateRealm = center.dbServer.getConnection().object(ofType: PokerPlusStateRealm.self, forPrimaryKey: id) else {
            fatalError("error: state not found")
        }
        let stateData = stateRealm.value.data(using: .utf8)!
        let state = PokerPlusState(json: stateData)
        return state
    }
    
    func deleteState(id: String) {
        guard let stateRealm = center.dbServer.getConnection().object(ofType: PokerPlusStateRealm.self, forPrimaryKey: id) else {
            fatalError("error: state not found")
        }
        try! center.dbServer.getConnection().write{
            center.dbServer.getConnection().delete(stateRealm)
        }
    }
}
