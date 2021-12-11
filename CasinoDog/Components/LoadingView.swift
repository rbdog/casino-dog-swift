//
//
//

import SwiftUI

struct LoadingView: View {
    let tasks: [LoadingTask]
    init(_ tasks: [LoadingTask]) {
        self.tasks = tasks
    }
    
    var body: some View {
        ZStack {
            if tasks.isEmpty {
                EmptyView()
            } else {
                ProgressView("Now Loading...")
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .frame(width: 160, height: 80)
                    .foregroundColor(.white)
                    .background(Color.plusAutoBlack.opacity(0.5))
                    .cornerRadius(12)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(edges: .all)
    }
}
