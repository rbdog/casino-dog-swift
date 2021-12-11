//
//
//

import SwiftUI

struct TabWindow<Builder: TabBuilder>: View {
    @StateObject var state: TabWindowState
    let builder: Builder
    
    var body: some View {
        builder.contentView(state.selectedId)
    }
}
