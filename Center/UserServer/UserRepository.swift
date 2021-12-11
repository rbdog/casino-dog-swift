//
//
//

struct UserRepository {
    /// CREATE
    func create(user: UserRealm) {
        try! center.dbServer.getConnection().write {
            center.dbServer.getConnection().add(user)
        }
    }

    /// READ by User ID
    func read(whereID id: String) -> UserRealm {
        guard let user = center.dbServer.getConnection().object(ofType: UserRealm.self, forPrimaryKey: id) else {
            fatalError("error: user not found")
        }
        return user
    }
    
    /// READ some
    func read(whereIDs ids: [String]) -> [UserRealm] {
        var users: [UserRealm] = []
        for id in ids {
            let results = center.dbServer.getConnection().objects(UserRealm.self).filter("id = '\(id)'")
            if let user = Array(results).first {
                users.append(user)
            }
        }
        return users
    }

    /// UPDATE
    func update(user: UserRealm) {
        // TODO: - 上限設定を厳しくする
        if user.chip > 99999 {
            let limitedUser = UserRealm(
                id: user.id,
                createdAt: user.created_at,
                updatedAt: user.updated_at,
                mail: user.mail,
                nickname: user.nickname,
                chip: 99999,
                iconURL: user.icon_url,
                selfIntro: user.self_intro,
                symbol_pockets: user.symbol_pockets
            )
            try! center.dbServer.getConnection().write {
                center.dbServer.getConnection().add(limitedUser, update: .all)
            }
        } else {
            try! center.dbServer.getConnection().write {
                center.dbServer.getConnection().add(user, update: .all)
            }
        }
    }
    
    func saveUsers(_ users: [UserRealm]) {
        try! center.dbServer.getConnection().write {
            center.dbServer.getConnection().add(users, update: .all)
        }
    }

    /// DELETE
    func delete(user: UserRealm) {
        fatalError("未実装")
    }
}
