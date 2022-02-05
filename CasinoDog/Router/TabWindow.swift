//
//
//

import SwiftUI

struct TabWindow: View {
    @StateObject var state: TabState
    
    var body: some View {
        PageContent(id: state.selectedId)
    }
}
