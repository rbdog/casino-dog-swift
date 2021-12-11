//
//
//

import SwiftUI

struct HomeTabBar: View {
    @StateObject var state: TabWindowState
    let builder: HomeTabBuilder
    
    var body: some View {
        GeometryReader { proxy in
            HStack(spacing: 0) {
                ForEach(state.list, id: \.self) { pageId in
                    Button {
                        Router().selectHomeTab(pageId: pageId)
                    } label: {
                        VStack {
                            VStack {
                                builder.tabImage(pageId)
                                    .resizable()
                                    .renderingMode(.template)
                                    .foregroundColor(state.selectedId == pageId ? .plusAutoWhite : .plusAutoBlack)
                                    .aspectRatio(contentMode: .fit)
                                Text(builder.tabText(pageId))
                                    .foregroundColor(state.selectedId == pageId ? .plusAutoWhite : .plusAutoBlack)
                            }
                            Spacer()
                        }
                        .frame(maxWidth: proxy.size.width/CGFloat(state.list.count),
                               maxHeight: .infinity)
                        .padding()
                        .background(
                            (state.selectedId == pageId)
                            ? builder.tabBackColorOnSelected(pageId)
                            : builder.tabBackColorOnUnselected(pageId)
                        )
                    }
                    .buttonStyle(ScaleButtonStyle())
                    .zIndex((state.selectedId == pageId) ? 2 : 1)
                }
            }
            .background(
                Color.plusRed
                    .shadow(color: .black.opacity(0.5), radius: 4, x: 0, y: 0)
            )
        }
    }
}
