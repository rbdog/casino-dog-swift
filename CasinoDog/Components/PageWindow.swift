//
//
//

import SwiftUI

struct PageWindow<Builder: PageBuilder>: View {
    @StateObject var state: PageWindowState
    let builder: Builder
    
    var body: some View {
        return Group {
            if let latestPageId = state.stack.last {
                builder.contentView(latestPageId)
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing),
                        removal: .move(edge: .leading)
                    ))
            } else {
                builder.emptyView()
            }
        }
    }
}
