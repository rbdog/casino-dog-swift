//
//
//

import SwiftUI
import Center

struct StorageManager {
    let accountStateKey = "AccountStateKey"
    
    func loadAccountState() async {
        await MainActor.run {
            guard let accountStateString = UserDefaults.standard.string(forKey: accountStateKey) else {
                print("保存済みのアカウントデータが見つかりませんでした")
                return
            }
            print("前回保存したアカウントデータが見つかりました")
            let data = accountStateString.data(using: .utf8)!
            appState.account = AccountState(json: data)
        }
    }
    
    func saveAccountState() async {
        await MainActor.run {
            let accountStateString = String(data: appState.account.jsonData, encoding: .utf8)!
            UserDefaults.standard.set(accountStateString, forKey: accountStateKey)
            print("アカウントデータをローカルに保存しました")
        }
    }
    
    func deleteAllStorage() async {
        // Storage
        await MainActor.run {
            if let bundleID = Bundle.main.bundleIdentifier {
                UserDefaults.standard.removePersistentDomain(forName: bundleID)
            }
            UserDefaults.standard.synchronize()
            print("ストレージを全て削除しました")
        }
    }
    
    func deleteAllMemory() {
        // 表示中の画面がクラッシュしないように、先に画面を削除
        Router().setBaseModals(queue: [], animated: false)
        Router().setOnboardingPage(stack: [.rollDice], animated: false)
        Router().setBasePages(stack: [])
        appState.splash = SplashState()
        appState.onboarding = nil
        appState.home = HomeState()
        appState.account = AccountState()
        appState.editUser = EditUserState()
        appState.gameList = GameListState()
        appState.matching = nil
        appState.partycakeSystem = nil
        appState.partycakePlayUi = nil
        appState.partycakeScoreUi = nil
        appState.slotList = SlotListState()
        appState.slotMachine = nil
    }
}
