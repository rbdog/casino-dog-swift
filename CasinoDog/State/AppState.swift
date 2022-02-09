//
//
//

import SwiftUI

let appState: AppState = AppState()

final class AppState {
    
    // ページ遷移
    var routing: RoutingState
    
    // ローディング
    var loading: LoadingState
    
    // スプラッシュ
    var splash: SplashState!
    
    // オンボーディング
    var onboarding: OnboardingState!
    
    // ホームタブ
    var home: HomeState
    
    // アカウント
    var account: AccountState
    
    // ユーザー編集
    var editUser: EditUserState
    
    // ゲーム一覧
    var gameList: GameListState
    
    // マッチング
    var matching: MatchingState!
    
    // Partycake
    var partycakeSystem: PartycakeSystemState!
    
    var partycakePlayUi: PartycakePlayUiState!
    
    var partycakeScoreUi: PartycakeScoreUiState!
    
    var partycakeConnection: PartycakeConnection!
    
    // スロット一覧
    var slotList: SlotListState
    
    // スロットマシン
    var slotMachine: SlotMachineState!
    
    init(
        pageRoute: RoutingState,
        loading: LoadingState,
        splash: SplashState?,
        onboarding: OnboardingState?,
        homeTab: HomeState,
        account: AccountState,
        editUser: EditUserState,
        gameList: GameListState,
        matching: MatchingState?,
        partycakeSystem: PartycakeSystemState?,
        partycakePlayUi: PartycakePlayUiState?,
        partycakeScoreUi: PartycakeScoreUiState?,
        slotList: SlotListState,
        slotMachine: SlotMachineState?
    ) {
        self.routing = pageRoute
        self.loading = loading
        self.splash = splash
        self.onboarding = onboarding
        self.home = homeTab
        self.account = account
        self.editUser = editUser
        self.gameList = gameList
        self.matching = matching
        self.partycakeSystem = partycakeSystem
        self.partycakePlayUi = partycakePlayUi
        self.partycakeScoreUi = partycakeScoreUi
        self.slotList = slotList
        self.slotMachine = slotMachine
    }
    
    init() {
        self.routing = RoutingState()
        self.loading = LoadingState()
        self.splash = SplashState()
        self.onboarding = nil
        self.home = HomeState()
        self.account = AccountState()
        self.editUser = EditUserState()
        self.gameList = GameListState()
        self.matching = nil
        self.partycakeSystem = nil
        self.partycakePlayUi = nil
        self.partycakeScoreUi = nil
        self.slotList = SlotListState()
        self.slotMachine = nil
    }
    
}
