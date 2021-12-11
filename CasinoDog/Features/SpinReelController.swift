//
//
//

import SwiftUI

struct SpinReelController {
    
    let reelIndex: Int
    let reelDurationFast = 0.1
    let reelDurationSlow = 0.5
    
    func start() {
        print("回転をスタートします")
        appState.slotMachine!.reels[reelIndex].stopIndex = []
        loop()
    }
    
    // ストップするインデックスが設定されるまで回転し続ける
    func loop() {
        Task {
            await spinOneAsync()
            if canStop() {
                didStop()
            } else {
                loop()
            }
        }
    }
    
    func duration(newIndex: Int) -> Double {
        if appState.slotMachine.reels[reelIndex].stopIndex.contains(newIndex) {
            return reelDurationSlow
        } else {
            return reelDurationFast
        }
    }
    
    // シンボル1つ分回転する
    func spinOne(completion: @escaping () -> Void) {
        // 現在の index を取得
        let oldIndex = appState.slotMachine!.reels[reelIndex].index
        var newIndex = oldIndex + 1
        // index の限界を超えていた場合は内部保持のデータのみ 0 にする
        let maxIndex = appState.slotMachine!.reels[reelIndex].symbols.count - 1
        if newIndex > maxIndex {
            newIndex = 0
        }
        let size = appState.slotMachine.squreSize
        let oldOffset = CGFloat(oldIndex) * size!
        let newOffset = CGFloat(oldIndex + 1) * size!
        // 時間をかけて値を変化させる
        let duration = self.duration(newIndex: newIndex)
        DispatchQueue.main.async {
            appState.slotMachine.reels[reelIndex].index = newIndex
            appState.slotMachine.reels[reelIndex].offset = oldOffset
            withAnimation(.linear(duration: duration)) {
                appState.slotMachine.reels[reelIndex].offset = newOffset
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            completion()
        }
    }
    
    func spinOneAsync() async {
        await withCheckedContinuation { continuation in
            spinOne {
                continuation.resume()
            }
        }
    }
    
    func canStop() -> Bool {
        let index = appState.slotMachine!.reels[reelIndex].index
        return appState.slotMachine.reels[reelIndex].stopIndex.contains(index)
    }
    
    func stop(at index: [Int]) {
        print("Reel: \(reelIndex) は index: \(index) で止まります")
        DispatchQueue.main.async {
            appState.slotMachine!.reels[reelIndex].stopIndex = index
        }
    }
    
    func didStop() {
        // DO NOTHING
    }
}
