//
//
//

import SwiftUI

struct EffectView: View {
    @StateObject var playUiState: PokerPlusPlayUiState = appState.pokerPlusPlayUi
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                if playUiState.spotlightMySide {
                    Spotlight(x: UIScreen.main.bounds.width/4,
                              y: 3 * UIScreen.main.bounds.height/4,
                              width: UIScreen.main.bounds.width/2,
                              height: UIScreen.main.bounds.height/2,
                              cornerRadius: 8)
                        .edgesIgnoringSafeArea(.all)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                VStack {
                    VStack {
                        HStack {
                            if playUiState.flatCardImageName != nil {
                                Image(playUiState.flatCardImageName!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 120, height: 60)
                                    .transition(.scale)
                            }
                            if playUiState.flatOuterImageName != nil {
                                Image(playUiState.flatOuterImageName!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 120, height: 60)
                                    .transition(.scale)
                            }
                            if playUiState.flatInnerImageName != nil {
                                Image(playUiState.flatInnerImageName!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 60, height: 60)
                                    .transition(.scale)
                            }
                        }
                        
                        if playUiState.comboName != nil {
                            AnimationReader(playUiState.comboNameWaveIndex) { value in
                                Text(playUiState.comboName!)
                                    .font(.system(size: 60, weight: .bold, design: .default))
                                    .minimumScaleFactor(0.1)
                                    .shine(.gold, withWaveIndex: value)
                                    .transition(.asymmetric(
                                        insertion: .move(edge: .leading),
                                        removal: .move(edge: .trailing)
                                    ))
                            }
                            .frame(width: proxy.size.width, height: 50)
                        }
                        
                    }
                    .frame(width: proxy.size.width, height: proxy.size.height/2)
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                if playUiState.cardEffectImageName != nil {
                    Image(playUiState.cardEffectImageName!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .blinkEffect(animating: true, opacity: 0.5...1, interval: 1)
                        .frame(width: playUiState.cardEffectImageSize, height: playUiState.cardEffectImageSize)
                }
            }
        }
    }
}
