//
//
//

import SwiftUI

struct TabWindow<Builder: TabBuilder>: View {
    @StateObject var state: TabState
    let builder: Builder
    
    var body: some View {
        builder.contentView(state.selectedId)
    }
}
