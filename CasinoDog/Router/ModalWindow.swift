//
//
//

import SwiftUI

struct ModalWindow<Builder: ModalBuilder>: View {
    @StateObject var state: ModalState
    let builder: Builder
    
    var body: some View {
        if !state.queue.isEmpty {
            ZStack {
                Color.black.opacity(0.5)
                    .contentShape(Rectangle())
                    .edgesIgnoringSafeArea(.all)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                // 背景タップで閉じる
                //                            .onTapGesture {
                //                                if routing.modalQueue.first!.closeOnTapBackground() {
                //                                    RoutingController().deqModal()
                //                                }
                //                            }
                builder.contentView(state.queue.last!)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
            EmptyView()
        }
    }
}
