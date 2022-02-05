//
//
//

import SwiftUI
import Center

// WARNING: アプリを全てリセットする
func resetApp() {
    center.deleteAll() // Center データ全削除
    StorageManager().deleteAllMemory() // メモリデータを削除
    Task {
        await StorageManager().deleteAllStorage() // 全ストレージデータ削除
        Router().setBasePages(stack: [.splash])
    }
}

@main
struct CasinoDogApp: App {
    
    @StateObject var loading: LoadingState = appState.loading
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                NaviWindow(state: appState.routing.baseNaviState)
                ModalWindow(state: appState.routing.baseModalState)
                LoadingView(loading.loadingTasks)
            }
            .background(
                Color.plusDarkGreen
                    .ignoresSafeArea(.all)
            )
            .disabled(!loading.loadingTasks.isEmpty)
        }
    }
}
