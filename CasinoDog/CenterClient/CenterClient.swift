//
//
//

import Foundation

struct CenterClient: HTTPClient {
    let baseURL = "http://0.0.0.0:3000/"
    private init () {}
}

extension CenterClient {
    enum Model {}

    static let `default` = CenterClient()
    static let forLocal = LocalCenterClient()
}
