//
//
//

import SwiftUI

struct SlotListItemView: View {
    @StateObject var state: State
    
    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 0) {
                ZStack {
                    URLImage(url: MachineList().machine(id: state.machineID).miniImageUrl)
                        .frame(width: proxy.size.width * (3.5/10.0))
                        .shadow(color: .black.opacity(0.5), radius: 2, x: 2, y: 2)
                    
                    VStack {
                        HStack {
                            Text(MachineList().machine(id: state.machineID).name)
                                .font(.system(size: proxy.size.width * (0.6/10.0)))
                                .padding([.leading, .trailing], 8)
                                .padding([.top, .bottom], 4)
                                .background(state.labelColor)
                                .foregroundColor(state.textColor)
                                .cornerRadius(50)
                                .padding(.leading, 8)
                                .shadow(color: .black.opacity(0.5), radius: 2, x: 2, y: 2)
                            
                            Spacer()
                        }
                        .padding(.top, 8)
                        
                        Spacer()
                        
                        HStack {
                            Spacer()
                            
                            ZStack {
                                Image("ribbon-price")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: proxy.size.width * (3/10.0))
                                HStack {
                                    Image("chip")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: proxy.size.width * (0.6/10.0))
                                    Text(String(MachineList().machine(id: state.machineID).spinCost))
                                        .font(.system(size: proxy.size.width * (0.6/10.0)))
                                        .foregroundColor(.white)
                                }
                            }
                            .frame(width: proxy.size.width * (3.5/10.0))
                            .padding(.trailing, 8)
                            .shadow(color: .black.opacity(0.5), radius: 2, x: 2, y: 2)
                        }
                        .padding(.bottom, 8)
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                }
                .frame(width: proxy.size.width, height: proxy.size.width * (5.0/10.0))
                .background(
                    RadialGradient(gradient: Gradient(colors: [.plusBlue, .black]), center: .center, startRadius: 2, endRadius: 650)
                )
                
                
                HStack {
                    HStack {
                        ForEach(0..<MachineList().machine(id: state.machineID).memberSymbols.count) { index in
                            Image(MachineList().machine(id: state.machineID).memberSymbols[index].imageName.rawValue)
                                .resizable()
                                .renderingMode(.template)
                                .shine(.gold)
                                .aspectRatio(contentMode: .fit)
                        }
                    }
                    .padding(4)
                }
                .frame(maxWidth: .infinity,
                       maxHeight: .infinity)
                .background(state.labelColor)
                
            }
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.5), radius: 2, x: 2, y: 2)
        }
    }
}

extension SlotListItemView {
    final class State: ObservableObject {
        let labelColor: Color = .plusAutoBlack
        let backgroundColor: Color = Color(hex: 0x0068b7)
        let textColor: Color = .plusAutoWhite
        
        let machineID: MachineId
        init(machineID: MachineId) {
            self.machineID = machineID
        }
    }
}
