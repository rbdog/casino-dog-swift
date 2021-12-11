//
//
//

import SwiftUI

struct RollDiceView: View {
    @StateObject var onboarding: OnboardingState = appState.onboarding
    
    var body: some View {
        VStack {
            Text("CASINO DOG へようこそ☀️ \nサイコロを振ってください")
                .font(.system(size: 25))
                .foregroundColor(.white)
                .padding(20)
                .minimumScaleFactor(0.5)
            
            Spacer()
            
            // サイコロ領域
            HStack {
                Image(onboarding.faceImageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 70, height: 70)
                    .rotationEffect(.degrees(Double.random(in: 0...359)))
                    .shadow(color: .black.opacity(0.5), radius: 2, x: 2, y: 2)
            }
            .frame(width: 200,
                   height: 200)
            .background(Color.plusDarkGreen)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.white, lineWidth: 3)
            )
            
            Spacer()
            
            // ボタン領域
            VStack {
                if onboarding.canRoll {
                    Button {
                        OnboardingController().onTapRoll()
                    } label: {
                        Text("Roll")
                            .font(.system(size: 26))
                            .foregroundColor(.white)
                            .frame(width: 250, height: 50)
                            .background(Color.plusBlue)
                            .cornerRadius(10)
                    }
                    .buttonStyle(ScaleButtonStyle())
                    .padding(.top, 20)
                    
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity,
                   maxHeight: 150)
            .background(Color.white.opacity(0.5))
            
        }
    }
}
