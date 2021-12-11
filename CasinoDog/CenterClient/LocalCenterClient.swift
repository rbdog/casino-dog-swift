//
//
//

import Foundation
import Center

class LocalCenterClient {
    /// 送信
    /// - Parameters:
    ///   - apiRequest: リクエスト
    ///   - onSuccess: レスポンス取得成功時の処理
    ///   - onError: 個別エラー処理
    func send<T: HTTPAPI>(
        _ requestBody: T.Request,
        to api: T.Type,
        onReceive: @escaping (_ response: T.Response) -> Void,
        onCatch: @escaping (Error) -> Void
    ) {
        let resData = Center.Router().route(T.httpMethod.rawValue,
                                     T.urlPath,
                                     request: requestBody.jsonData)
        onReceive(T.Response(json: resData))
    }
}

extension LocalCenterClient {
    func fetchProfile(completion: @escaping () -> Void) {
        let loadUserRequest = UsersLoadUser.Request(user_id: appState.account.loginUser.id)
        CenterClient.forLocal.send(
            loadUserRequest,
            to: UsersLoadUser.API,
            onReceive: { loadUserResponse in
                let newUser = loadUserResponse.user
                appState.account.loginUser = newUser
                completion()
            },
            onCatch: { error in
                fatalError("プロフィールの取得に失敗しました")
            }
        )
    }
}
