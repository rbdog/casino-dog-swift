//
//
//

import SwiftUI

final class SplashState: ObservableObject, JSONSerializable {
    @Published var width: CGFloat
    @Published var alpha: Double
    
    // カスタムエンコード
    enum CodingKeys: String, CodingKey {
        case width
        case alpha
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        width = try container.decode(CGFloat.self, forKey: .width)
        alpha = try container.decode(Double.self, forKey: .alpha)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(width, forKey: .width)
        try container.encode(alpha, forKey: .alpha)
    }
    
    init(width: CGFloat = UIScreen.main.bounds.width,
         alpha: Double = 1) {
        self.width = width
        self.alpha = alpha
    }
}
