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
    
    let basePageBuilder = BasePageBuilder()
    let baseModalBuilder = BaseModalBuilder()
    @StateObject var loading: LoadingState = appState.loading
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                PageWindow(state: appState.routing.basePageWindowState, builder: basePageBuilder)
                ModalWindow(state: appState.routing.baseModalWindowState, builder: baseModalBuilder)
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
