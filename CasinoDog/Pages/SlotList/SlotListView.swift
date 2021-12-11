//
//
//

import SwiftUI

struct SlotListView: View {
    @StateObject var slotList: SlotListState = appState.slotList
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                HStack {
                    // 左上にスペース
                    Spacer()
                    // 右上にチップ数
                    ChipCountView(count: appState.account.loginUser.chips)
                        .frame(width: 0.9 * proxy.size.width/2)
                        .padding(.trailing, 8)
                }
                .frame(width: proxy.size.width, height: 40)
                
                HStack {
                    Text("Slot")
                        .font(.system(size: 40))
                        .foregroundColor(.plusAutoBlack)
                        .minimumScaleFactor(0.5)
                        .padding(.leading, 20)
                    Spacer()
                }
                .frame(width: proxy.size.width, height: 50)
                
                ScrollView {
                    VStack(spacing: 30) {
                        
                        Color.clear
                            .frame(width: 1, height: 12)
                        
                        ForEach(0..<slotList.machineIDList.count) { index in
                            Button {
                                SpinSlotController().onSelectMachine(id: slotList.machineIDList[index])
                            } label: {
                                SlotListItemView(state: SlotListItemView.State(machineID: slotList.machineIDList[index]))
                                    .frame(width: UIScreen.main.bounds.width - 40,
                                           height: (UIScreen.main.bounds.width - 40) * (6.0/10.0))
                            }
                        }
                        
                        Color.clear
                            .frame(width: 1, height: 12)
                    }
                }
            }
        }
    }
}
