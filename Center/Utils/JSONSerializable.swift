//
//
//

import Foundation

protocol JSONSerializable: Codable {
    init(json: Data)
    var jsonData: Data { get }
}
extension JSONSerializable {
    init(json: Data) {
        self = try! JSONDecoder().decode(Self.self, from: json)
    }
    var jsonData: Data {
        return try! JSONEncoder().encode(self)
    }
}
