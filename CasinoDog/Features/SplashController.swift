//
//
//

import Foundation
import SwiftUI
import Center

struct SplashController {
    
    func initSplashState() {
        let splashState = SplashState()
        appState.splash = splashState
    }
    
    func onSplashAppear() {
        
        Task {
            // Debug Only
//            center.deleteAll() // Center データ全削除
//            await StorageManager().deleteAllStorage() // 全ストレージデータ削除
            
            // 起動時の設定を取得できなかった場合はモーダルを表示して終了
            guard let splashConfig = await getSplashConfig() else {
                print("SplashConfig の 取得に失敗しました")
                Router().enqBaseModal(pageId: .badNetwork)
                return
            }
            // 最新バージョンでない場合はモーダルを表示して終了
            if !isLatest(lastest: splashConfig.latest_version, current: appVersion()) {
                print("最新バージョンではありませんでした")
                Router().enqBaseModal(pageId: .oldVersion)
                return
            }
            
            // ストレージに保存されたデータを読み込む
            await StorageManager().loadAccountState()
            
            // 初回起動かどうか
            if appState.account.loginUser == nil {
                print("初回起動です")
                // 初回起動 の場合は　Center にも知らせる
                center.onFirstLaunch()
            }
            
            // 毎回起動 を Center にも知らせる
            center.onLaunch()
            
            // ログインユーザーが作られていないかどうか
            if appState.account.loginUser == nil {
                print("ユーザーが見つからないのでオンボーディングへ進みます")
                // ユーザーが存在しない場合はオンボーディンングへ進んで終了
                let onboardingState = OnboardingState()
                appState.onboarding = onboardingState
                await scaleUpSplashAsync()
                Router().setBasePages(stack: [.onboarding], animated: false)
                return
            }
            
            // ログインユーザーがゲームに参加中かどうか
            if appState.account.keycard != nil {
                print("ゲーム画面から再開します")
                // TODO: - ゲームIDによって呼び分ける
                // 参加中のときはゲーム画面へ進んで終了
                let secretId = appState.account.keycard!.secret_id
                await scaleUpSplashAsync()
                PokerPlusEventController().play(secretId: secretId)
                return
            }
            
            print("ホーム画面へ進みます")
            // ホームへ進む
            await scaleUpSplashAsync()
            Router().setBasePages(stack: [.home], animated: false)
        }
    }
    
    // 拡大アニメーション
    func scaleUpSplash(completion: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + Splash.delaySec) {
            withAnimation(.easeIn(duration: Splash.durationSec)) {
                appState.splash.width = Splash.endWidth
                appState.splash.alpha = Splash.endAlpha
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + Splash.durationSec) {
                completion()
            }
        }
    }
    
    // 拡大アニメーション の async ラップ
    func scaleUpSplashAsync() async {
        await withCheckedContinuation { continuation in
            scaleUpSplash {
                continuation.resume()
            }
        }
    }
    
    func getSplashConfig() async -> SplashConfigResponse? {
        guard let url = URL(string: flavorConfig().splashConfigUrl) else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let splashConfig = SplashConfigResponse(json: data)
            return splashConfig
        } catch {
            return nil
        }
    }
    
    func isLatest(lastest: String, current: String) -> Bool {
        let lastest_split = lastest.components(separatedBy: ".")
        let current_split = current.components(separatedBy: ".")
        for (l, c) in zip(lastest_split, current_split) {
            if let lastInt = Int(l), let currentInt = Int(c) {
                if currentInt < lastInt {
                    return false
                }
                else if currentInt > lastInt {
                    print("開発版の先行バージョンです")
                    return true
                }
            } else {
                fatalError("不正なバージョンです")
            }
        }
        return true
    }
}

func appVersion() -> String {
    let key = "CFBundleShortVersionString"
    let version = Bundle.main.object(forInfoDictionaryKey: key) as? String
    return version ?? "不明なバージョン"
}
