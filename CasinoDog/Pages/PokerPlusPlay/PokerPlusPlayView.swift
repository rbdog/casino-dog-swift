//
//
//

import SwiftUI

struct PartycakePlayView: View {
    @StateObject var playUiState: PartycakePlayUiState = appState.partycakePlayUi
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                if (playUiState.focusTarget == .all) {
                    Header()
                        .frame(width: UIScreen.main.bounds.width , height: 40)
                }
                ZStack {
                    GeometryReader { proxy in
                        HStack(spacing: 0) {
                            // Left Players
                            if (playUiState.focusTarget == .all) {
                                VStack {
                                    Spacer()
                                    PlayerView(playUiSide: playUiState.sides.first(where: {$0.seat == .s4})!)
                                        .frame(width: 50, height: proxy.size.height/2 - 40)
                                    
                                    Spacer()
                                    PlayerView(playUiSide: playUiState.sides.first(where: {$0.seat == .s3})!)
                                        .frame(width: 50, height: proxy.size.height/2 - 40)
                                    
                                    Spacer()
                                }
                                .offset(x: (playUiState.focusTarget == .all) ? 0 : -50, y: 0)
                                .zIndex(10)
                                
                            }
                            
                            // Board
                            Board()

                            // Right Players
                            if (playUiState.focusTarget == .all) {
                                VStack {
                                    Spacer()
                                    PlayerView(playUiSide: playUiState.sides.first(where: {$0.seat == .s1})!)
                                        .frame(width: 50, height: proxy.size.height/2 - 40)

                                    Spacer()
                                    PlayerView(playUiSide: playUiState.sides.first(where: {$0.seat == .s2})!)
                                        .frame(width: 50, height: proxy.size.height/2 - 40)

                                    Spacer()
                                }
                                .offset(x: (playUiState.focusTarget == .all) ? 0 : 50, y: 0)
                                .zIndex(10)
                            }
                        }
                    }

                }
                if (playUiState.focusTarget == .all) {
                    Dock()
                        .frame(width: UIScreen.main.bounds.width - 60, height: 100)
                        .disabled(playUiState.dockIsLocked)
                }
            }
            if appState.partycakeScoreUi != nil {
                ScoreListView()
            }
            if playUiState.waitingOthers {
                VStack {
                    Text("他のプレイヤーを待っています...")
                        .foregroundColor(.white)
                        .padding(8)
                        .frame(width: 300, height: 70)
                        .background(Color.plusBlack)
                        .cornerRadius(8)
                        .blinkEffect(animating: true, opacity: 0.5...1.0, interval: 2)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    Color.clear
                        .contentShape(Rectangle())
                )
            }
        }
        .background(
            RadialGradient(gradient: Gradient(colors: [.init(hex: 0x008800), .black]), center: .center, startRadius: 2, endRadius: UIScreen.main.bounds.height)
                .ignoresSafeArea(.all)
        )
    }
}
