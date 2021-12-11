//
//
//

import Foundation

public enum HTTP {
    public enum Method: String {
        case GET
        case POST
        case PUT
        case PATCH
        case DELETE
    }
}

protocol HTTPRequestBody: JSONSerializable {}

protocol HTTPResponseBody: JSONSerializable {}

protocol HTTPAPI {
    static var urlPath: String { get }
    static var httpMethod: HTTP.Method { get }
    associatedtype Request: HTTPRequestBody
    associatedtype Response: HTTPResponseBody
    static func run(request: Request) -> Response
}

extension HTTPAPI {
    static var API: Self.Type { return Self.self }
    static func response(to request: Data) -> Data {
        let req = Request(json: request)
        return run(request: req).jsonData
    }
}
