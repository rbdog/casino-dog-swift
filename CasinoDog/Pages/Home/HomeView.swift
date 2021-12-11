//
//
//

import SwiftUI

struct HomeView: View {

    @StateObject var homeTab: HomeState = appState.home
    let builder = HomeTabBuilder()
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                VStack(spacing: 0) {
                    // メインコンテンツ
                    TabWindow(state: appState.routing.homeTabWindowState, builder: builder)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    // タブバー
                    HomeTabBar(state: appState.routing.homeTabWindowState, builder: builder)
                        .frame(maxWidth: proxy.size.width, maxHeight: proxy.size.height/8)
                }
                .edgesIgnoringSafeArea(.bottom)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .onAppear {
                    CenterClient.forLocal.fetchProfile {
                        Task {
                            await StorageManager().saveAccountState()
                        }
                    }
                }
                
                // メニュー
                if homeTab.showMenu {
                    MenuListView()
                        .background(Color.clear.edgesIgnoringSafeArea(.all))
                }
            }
            .background(
                // 背景
                Color.plusAutoWhite.edgesIgnoringSafeArea(.all)
            )
        }
    }
}
