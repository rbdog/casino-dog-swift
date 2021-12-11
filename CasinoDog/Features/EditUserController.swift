//
//
//

struct EditUserController {
    func onTapUserIcon() {
        appState.editUser.mode = .edittingIcon
    }
    
    func onSelectUserIconURL(url: String) {
        
        appState.editUser.mode = .noEditting
        
        let request = UsersUpdateUser.Request(
            user_id: appState.account.loginUser.id,
            nickname: nil,
            icon_url: url
        )
        print("アイコン変更リクエストを送信します")
        CenterClient.forLocal.send(
            request,
            to: UsersUpdateUser.API,
            onReceive: { response in
                
                print("アイコン変更のレスポンスを受け取りました")
                
                var user = appState.account.loginUser!
                user.icon_url = url
                appState.account.loginUser = user
                
                Task {
                    await StorageManager().saveAccountState()
                }
            },
            onCatch: { err in
                fatalError("アイコンURL変更に失敗しました")
            }
        )
    }
    
    func onTapNickname() {
        appState.editUser.nickname = appState.account.loginUser.nickname
        appState.editUser.mode = .edittingNickname
    }
    
    func onUpdateUser() {
        let newName = appState.editUser.nickname
        appState.editUser.mode = .noEditting
        if newName.isEmpty {
            return
        }
        
        let request = UsersUpdateUser.Request(
            user_id: appState.account.loginUser.id,
            nickname: newName,
            icon_url: nil
        )
        CenterClient.forLocal.send(
            request,
            to: UsersUpdateUser.API,
            onReceive: { response in
                var user = appState.account.loginUser!
                user.nickname = newName
                appState.account.loginUser = user
                Task {
                    await StorageManager().saveAccountState()
                }
            },
            onCatch: { err in
                fatalError("ニックネーム変更に失敗しました")
            }
        )
    }
}
