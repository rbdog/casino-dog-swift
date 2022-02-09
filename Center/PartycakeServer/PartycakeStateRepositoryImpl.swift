//
//
//

struct PartycakeStateRepositoryImpl: PartycakeStateRepository {
    
    func saveState(_ state: PartycakeState) {
        let jsonValue = String(data: state.jsonData, encoding: .utf8)!
        let stateRealm = PartycakeStateRealm(
            stateId: state.id,
            value: jsonValue
        )
        try! center.dbServer.getConnection().write {
            center.dbServer.getConnection().add(stateRealm, update: .all)
        }
    }
    
    func loadState(id: String) -> PartycakeState {
        guard let stateRealm = center.dbServer.getConnection().object(ofType: PartycakeStateRealm.self, forPrimaryKey: id) else {
            fatalError("error: state not found")
        }
        let stateData = stateRealm.value.data(using: .utf8)!
        let state = PartycakeState(json: stateData)
        return state
    }
    
    func deleteState(id: String) {
        guard let stateRealm = center.dbServer.getConnection().object(ofType: PartycakeStateRealm.self, forPrimaryKey: id) else {
            fatalError("error: state not found")
        }
        try! center.dbServer.getConnection().write{
            center.dbServer.getConnection().delete(stateRealm)
        }
    }
}
