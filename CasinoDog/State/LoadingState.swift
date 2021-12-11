//
//
//

import SwiftUI

final class LoadingState: ObservableObject, JSONSerializable {
    @Published var loadingTasks: [LoadingTask]
    // カスタムエンコード
    enum CodingKeys: String, CodingKey {
        case loadingTasks
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        loadingTasks = try container.decode([LoadingTask].self, forKey: .loadingTasks)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(loadingTasks, forKey: .loadingTasks)
    }
    
    init(loadingTasks: [LoadingTask] = []) {
        self.loadingTasks = loadingTasks
    }
}

extension LoadingState {
    func updateLoading(isLoading: Bool) {
        self.loadingTasks = loadingTasks
    }
}
