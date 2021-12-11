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
    
    // Poker+
    var pokerPlusSystem: PokerPlusSystemState!
    
    var pokerPlusPlayUi: PokerPlusPlayUiState!
    
    var pokerPlusScoreUi: PokerPlusScoreUiState!
    
    var pokerPlusConnection: PokerPlusConnection!
    
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
        pokerPlusSystem: PokerPlusSystemState?,
        pokerPlusPlayUi: PokerPlusPlayUiState?,
        pokerPlusScoreUi: PokerPlusScoreUiState?,
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
        self.pokerPlusSystem = pokerPlusSystem
        self.pokerPlusPlayUi = pokerPlusPlayUi
        self.pokerPlusScoreUi = pokerPlusScoreUi
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
        self.pokerPlusSystem = nil
        self.pokerPlusPlayUi = nil
        self.pokerPlusScoreUi = nil
        self.slotList = SlotListState()
        self.slotMachine = nil
    }
    
}
