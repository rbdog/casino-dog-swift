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
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        return try! encoder.encode(self)
    }
    var prettyRrintedJSON: String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try! encoder.encode(self)
        let string = String(data: data, encoding: .utf8)!
        return string
    }
}
