//
//
//

import SwiftUI

struct SymbolView: View {
    @StateObject var state: State
    var body: some View {
        Image(state.imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding()
            .shine(.gold)
    }
}

extension SymbolView {
    final class State: ObservableObject {
        let imageName: String
        init (imageName: String) {
            self.imageName = imageName
        }
    }
}
