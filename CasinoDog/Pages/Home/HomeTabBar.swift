//
//
//

import SwiftUI

struct HomeTabBar: View {
    @StateObject var state: TabState
    let config: TabBarConfig
    
    var body: some View {
        GeometryReader { proxy in
            HStack(spacing: 0) {
                ForEach(config.pageList, id: \.self) { pageId in
                    Button {
                        Router().selectHomeTab(pageId: pageId)
                    } label: {
                        VStack {
                            VStack {
                                URLImage(url: config.imageUrls[pageId]!, mode: .template)
                                    .foregroundColor(state.selectedId == pageId ? .plusAutoWhite : .plusAutoBlack)
                                Text(config.labelTexts[pageId]!)
                                    .foregroundColor(state.selectedId == pageId ? .plusAutoWhite : .plusAutoBlack)
                            }
                            Spacer()
                        }
                        .frame(maxWidth: proxy.size.width/CGFloat(config.pageList.count),
                               maxHeight: .infinity)
                        .padding()
                        .background(
                            (state.selectedId == pageId)
                            ? config.backColorOnSelected
                            : config.backColorOnUnselected
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
