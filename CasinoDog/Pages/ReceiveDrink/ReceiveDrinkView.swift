//
//
//

import SwiftUI

struct ReceiveDrinkView: View {
    @StateObject var onboarding: OnboardingState = appState.onboarding
    
    var body: some View {
        VStack {
            Text("おめでとうございます🎉 \nドリンクをお受け取りください🥳")
                .font(.system(size: 25))
                .foregroundColor(.white)
                .padding(20)
                .minimumScaleFactor(0.5)
            
            Spacer()
            // ドリンクの領域
            VStack(spacing: 0) {
                HStack {
                    Image(onboarding.drink!.imageName.rawValue)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .shadow(color: .black.opacity(0.5), radius: 2, x: 2, y: 2)
                }
                .frame(maxWidth: .infinity,
                       maxHeight: .infinity)
                .background(Color.white.opacity(0.5))
                
                HStack {
                    Image(onboarding.stopDiceFace!.imageName.rawValue)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                        .shadow(radius: 3)
                        .padding(.leading, 20)
                    Spacer()
                    Text(onboarding.drink!.text)
                        .font(.system(size: 36))
                        .foregroundColor(Color.white)
                    Spacer()
                }
                .frame(width: UIScreen.main.bounds.width - 20,
                       height: 60)
                .background(Color.plusDarkGreen)
            }
            .frame(width: UIScreen.main.bounds.width - 40,
                   height: 300)
            .background(Color.plusDarkGreen)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.white, lineWidth: 2)
            )
            
            Spacer()
            
            // ボタンの領域
            VStack {
                Button {
                    OnboardingController().onTapReceive()
                } label: {
                    Text("Receive")
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
            .frame(maxWidth: .infinity,
                   maxHeight: 150)
            .background(Color.white.opacity(0.5))
            
        }
        .frame(maxWidth: .infinity,
               maxHeight: .infinity)
    }
}
