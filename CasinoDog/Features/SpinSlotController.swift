//
//
//

import Foundation

struct SpinSlotController {
    func onSelectMachine(id: MachineId) {
        let slotState = SlotMachineState(machineID: id)
        DispatchQueue.main.async {
            appState.slotMachine = slotState
            Router().pushBasePage(pageId: .slot)
        }
    }
    
    func onSliderMax() {
        if appState.slotMachine.canStart {
            self.disableSlider()
            requestSpinSlot()
        }
    }
    
    func onStopSpin() {
        
    }
    
    func onTriad() {
        
    }
    
    func onTapTriadOK() {
        DispatchQueue.main.async {
            appState.slotMachine.triadAnimation = nil
        }
    }
    
    func enableSlider() {
        // スライダーを元に戻す
        DispatchQueue.main.async {
            appState.slotMachine.sliderValue = 0
            appState.slotMachine.canStart = true
        }
    }
    
    func disableSlider() {
        DispatchQueue.main.async {
            // スライダーをMaxにする
            appState.slotMachine.sliderValue = 1
            appState.slotMachine.canStart = false
        }
    }
    
    func requestSpinSlot() {
        SpinReelController(reelIndex: 0).start()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            SpinReelController(reelIndex: 1).start()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            SpinReelController(reelIndex: 2).start()
        }
        
        let request = SlotsSpinSlot.Request(
            user_id: appState.account.loginUser.id,
            machine_id: appState.slotMachine.machineID.rawValue
        )
        CenterClient.forLocal.send(
            request,
            to: SlotsSpinSlot.API,
            onReceive: { response in
                if let error = response.error {
                    fatalError(error.code + " " + error.message)
                }
                let reelAnimation0 = response.reel_animations[0]
                let reelAnimation1 = response.reel_animations[1]
                let reelAnimation2 = response.reel_animations[2]
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    SpinReelController(reelIndex: 0).stop(at: reelAnimation0.stop_index )
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                    SpinReelController(reelIndex: 1).stop(at: reelAnimation1.stop_index)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    SpinReelController(reelIndex: 2).stop(at: reelAnimation2.stop_index)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    
                    // 次のスロットを有効にする
                    self.enableSlider()
                    // Symbolコレクション を更新
                    var user = appState.account.loginUser!
                    user.symbol_pockets = response.new_pockets
                    // チップを更新
                    user.chips = response.new_chips
                    // AppStateを更新
                    appState.account.loginUser = user
                    
                    guard let animation = response.triad_animation else {
                        return
                    }
                    self.showTriad(animation: animation)
                    
                    Task {
                        // AppStateを保存
                        await StorageManager().saveAccountState()
                    }
                }
                
            },
            onCatch: {_ in
                fatalError("Slotの通信に失敗")
            }
        )
    }
    
    func showTriad(animation: SlotTriadAnimation) {
        DispatchQueue.main.async {
            appState.slotMachine.triadAnimation = animation
        }
    }
}
