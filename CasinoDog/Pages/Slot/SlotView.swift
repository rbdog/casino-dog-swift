//
//
//

import SwiftUI

struct SlotView: View {
    @StateObject var machine: SlotMachineState = appState.slotMachine!
    @StateObject var account: AccountState = appState.account
    
    var body: some View {
        
        GeometryReader { proxy in
            ZStack {
                VStack {
                    HStack {
                        // Exit
                        if machine.canStart {
                            Button {
                                Router().popBasePage()
                            } label: {
                                Text("Exit")
                                    .font(.system(size: 16))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: 100, maxHeight: .infinity)
                                    .background(.red)
                                    .cornerRadius(10)
                                    .padding(.leading, 8)
                            }
                            .padding(.trailing, 8)
                        }
                        // 左上にスペース
                        Spacer()
                        // 右上にチップ数
                        ChipCountView(count: account.loginUser.chips)
                            .frame(width: 0.9 * proxy.size.width/2)
                            .padding(.trailing, 8)
                    }
                    .frame(width: proxy.size.width, height: 40)
                    
                    Spacer()
                    
                    ZStack {
                        Image("ribbon-price")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: (proxy.size.width - 100)/4)
                        HStack {
                            Image("chip")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: (proxy.size.width - 100)/8)
                            Text(String(MachineList().machine(id: machine.machineID).spinCost))
                                .foregroundColor(.white)
                                .font(.system(size: (proxy.size.width - 100)/10))
                        }
                    }
                    .frame(height: 70)
                    
                    Color.clear
                        .frame(width: 1, height: 10)
                    
                    MachineView()
                        .frame(width: proxy.size.width - 100, height: 5 * (proxy.size.width - 100)/4)
                        
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
            }
            .background(
                RadialGradient(gradient: Gradient(colors: [.plusBlue, .black]), center: .center, startRadius: 2, endRadius: 650)
            )
            
            if machine.triadAnimation != nil {
                TriadEffectView()
                    .edgesIgnoringSafeArea(.all)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.5))
            }
        }
    }
}
