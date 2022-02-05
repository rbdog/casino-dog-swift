//
//
//

import SwiftUI

struct ModalWindow: View {
    @StateObject var state: ModalState
    
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
                ModalContent(id: state.queue.last!)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
            EmptyView()
        }
    }
}
