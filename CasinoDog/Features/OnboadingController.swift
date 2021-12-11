//
//
//

import SwiftUI

// FIXME: - 場所変更
var timer: Timer?

struct OnboardingController {
    
    func onTapRoll() {
        DispatchQueue.main.async {
            appState.onboarding.canRoll = false
        }
        
        var count = 3.0
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { (timer) in
            count -= 0.1
            
            DispatchQueue.main.async {
                var diceFace = self.randomDiceFace()
                appState.onboarding.faceImageName = diceFace.imageName.rawValue
                
                if count < 0 {
                    timer.invalidate()
                    
                    var drink = self.drink(for: diceFace)
                    if self.hasFace0() {
                        appState.onboarding.faceImageName = DiceFace.zero.imageName.rawValue
                        drink = .champagne
                        diceFace = .zero
                    }
                    
                    self.onGetDrink(diceFace: diceFace, drink: drink)
                }
            }
        })
    }
    
    func onTapReceive() {
        // ホームへ
        Router().setBasePages(stack: [.home])
    }
    
    func randomDiceFace() -> DiceFace {
        return DiceFace.nomalCases.randomElement()!
    }
    
    private func hasFace0() -> Bool {
        let random = Int.random(in: 0...99)
        return random == 0
    }

    func drink(`for` face: DiceFace) -> Drink {
        switch face {
        case .zero: return .champagne
        case .one: return .beer
        case .two: return .brandy
        case .three: return .cocktail
        case .four: return .liqueur
        case .five: return .spirits
        case .six: return .wine
        }
    }
    
    func onGetDrink(diceFace: DiceFace, drink: Drink) {
        
        DispatchQueue.main.async {
            appState.onboarding.drink = drink
            appState.onboarding.stopDiceFace = diceFace
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            
            // ユーザー登録リクエスト
            let createUserRequest = UsersCreateUser.Request(nickname: "ゲスト", mail: "casinodog.guest@example.com", drink: drink.rawValue)
            CenterClient.forLocal.send(
                createUserRequest,
                to: UsersCreateUser.API,
                onReceive: { createUserResponse in
                    
                    // 登録できたユーザをデコード
                    let guestUser = createUserResponse.user
                    
                    DispatchQueue.main.async {
                        // Stateをアップデート
                        appState.account.loginUser = guestUser
                        Task {
                            // Stateを保存
                            await StorageManager().saveAccountState()
                            // ドリンク受け取りViewへ
                            DispatchQueue.main.async {
                                withAnimation(.easeOut(duration: 0.5)) {
                                    Router().pushOnboadingPage(.receiveDrink)
                                }
                            }
                        }
                    }
                    
                },
                onCatch: {_ in
                    fatalError("ユーザー作成に失敗")
                }
            )
        }
    }
}
