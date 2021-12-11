//
//
//

import Foundation

enum HTTP {
    enum Method: String {
        case GET
        case POST
        case PUT
        case PATCH
        case DELETE
    }
}

protocol HTTPRequestBody: JSONSerializable {
    // 設計として各リクエストに必ず定義させたい項目があればここに書く
    // <例> let timeoutSec: Int { get }
}

protocol HTTPResponseBody: JSONSerializable {
    // 設計として各レスポンスに必ず定義させたい項目があればここに書く
    // <例> let message: String { get }
}

protocol HTTPAPI {
    static var urlPath: String { get }
    static var httpMethod: HTTP.Method { get }
    associatedtype Request: HTTPRequestBody
    associatedtype Response: HTTPResponseBody
}

extension HTTPAPI {
    static var API: Self.Type { return Self.self }
}

protocol HTTPClient {
    typealias CustomHeader = (value: String, field: String)
    var baseURL: String { get }
    var headers: [CustomHeader] { get }
}
extension HTTPClient {
    /// ヘッダーに付加したい情報
    var headers: [CustomHeader] {
        return [(value: "application/json", field: "Content-Type")]
    }
    /// 送信
    /// - Parameters:
    ///   - apiRequest: リクエスト
    ///   - onSuccess: レスポンス取得成功時の処理
    ///   - onError: 個別エラー処理
    func send<T: HTTPAPI>(_ requestBody: T.Request,
                          to api: T.Type,
                          onReceive: @escaping (_ response: T.Response) -> Void,
                          onCatch: @escaping (Error) -> Void) {

        var urlRequest = URLRequest(url: URL(string: baseURL + T.urlPath)!)
        urlRequest.httpMethod = T.httpMethod.rawValue
        // GET 以外の場合のみ body を設定
        if T.httpMethod != .GET {
            urlRequest.httpBody = requestBody.jsonData
        }
        // ヘッダー属性を付加
        for header in headers {
            urlRequest.addValue(header.value, forHTTPHeaderField: header.field)
        }
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            if let error = error {
                onCatch(error)
            } else {
                let responseBody = T.Response(json: data!)
                onReceive(responseBody)
            }
        }
        // 実行
        task.resume()
    }
}
