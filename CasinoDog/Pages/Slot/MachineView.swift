//
//
//

import SwiftUI

struct MachineView: View {
    @StateObject var machine: SlotMachineState = appState.slotMachine
    
    func baseColor() -> Color {
        let machine = MachineList().machine(id: machine.machineID)
        return Color(hexString: machine.baseColorHex)
    }
    
    func accentColor() -> Color {
        let machine = MachineList().machine(id: machine.machineID)
        return Color(hexString: machine.accentColorHex)
    }
    
    func borderColor() -> Color {
        let machine = MachineList().machine(id: machine.machineID)
        return Color(hexString: machine.borderColorHex)
    }
    
    var body: some View {
        
        GeometryReader { proxy in
            ZStack {
                // 背景
                VStack(spacing: 0) {
                    baseColor()
                    accentColor()
                }
                .cornerRadius(12)
                .shadow(radius: 10)
                
                // 前面
                VStack {
                    // スロット名
                    Text(MachineList().machine(id: machine.machineID).name)
                        .font(.system(size: 30))
                        .foregroundColor(borderColor())
                        .minimumScaleFactor(0.5)
                    
                    // リール部分
                    ZStack {
                        HStack(spacing: 0) {
                            ForEach(machine.reels.indices) { index in
                                ReelView(reel: appState.slotMachine.reels[index])
                                // 縦にシンボル3つ分で並べる
                                    .frame(width: (proxy.size.width - 40)/3,
                                           height: proxy.size.width - 40)
                                // 見せる部分だけを改めて切り取る
                                    .frame(width: (proxy.size.width - 40)/3,
                                           height: 2 * (proxy.size.width - 40)/3)
                                    .clipped()
                                    .border(baseColor(), width: 3)
                                
                            }
                        }
                        // 影をつけて奥行きを表現
                        VStack {
                            LinearGradient(colors: [.black.opacity(0.7), .white.opacity(0)], startPoint: .top, endPoint: .bottom)
                                .frame(width: proxy.size.width - 40,
                                       height: (proxy.size.width - 40)/7)
                            Spacer()
                            LinearGradient(colors: [.white.opacity(0), .black.opacity(0.7)], startPoint: .top, endPoint: .bottom)
                                .frame(width: proxy.size.width - 40,
                                       height: (proxy.size.width - 40)/7)
                        }
                    }
                    .frame(width: (proxy.size.width - 40)/3,
                           height: 2 * (proxy.size.width - 40)/3)
                    
                    // スライドバー部分
                    Slider(
                        thumbColor: borderColor(),
                        minTrackColor: borderColor(),
                        maxTrackColor: baseColor(),
                        value: $machine.sliderValue,
                        valueController: machine.sliderValue
                    )
                        .padding(20)
                        .onChange(of: machine.sliderValue, perform: { _ in
                            if 0.9 < machine.sliderValue {
                                SpinSlotController().onSliderMax()
                            }
                        })
                        .disabled(!machine.canStart)
                }
                .frame(maxHeight: .infinity)
                
            }
        }
        
    }
}
