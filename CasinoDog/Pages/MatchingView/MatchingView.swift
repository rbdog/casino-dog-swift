//
//
//

import SwiftUI

struct MatchingView: View {
    @StateObject var matching: MatchingState = appState.matching
    
    var body: some View {
        VStack {
            HStack {
                ClockView()
                    .frame(width: 50, height: 50)
                    .padding(8)
                Text("Poker+")
                    .font(.system(size: 20))
                    .padding(8)
            }
            .frame(maxWidth: .infinity, maxHeight: 80)
            .background(Color.plusBlue)
            
            Spacer()
            
            Text(matching.message)
            
            Spacer()
            
            VStack {
                ForEach(0..<matching.seatCount) { index in
                    if matching.players.count > index {
                        item(nickname: matching.players[index].nickname, iconUrl: matching.players[index].icon_url)
                    } else {
                        placeHolder()
                    }
                }
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Color.plusRed.ignoresSafeArea(.all)
        )
        .onAppear {
            PokerPlusMatchingController().onMatchingViewAppear()
        }
    }
    
    func item(nickname: String, iconUrl: String) -> some View {
        return HStack {
            ImageProvider(uri: iconUrl).view()
                .clipShape(Circle())
                .frame(width: 50, height: 50)
                .padding(.leading, 20)
            Text(nickname)
                .font(.system(size: 20))
                .foregroundColor(.black)
                .padding(8)
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width - 40, height: 80)
        .background(Color.white)
        .cornerRadius(12)
    }
    
    func placeHolder() -> some View  {
        return HStack {
            Text("募集中")
                .font(.system(size: 20))
        }
        .frame(width: UIScreen.main.bounds.width - 40, height: 80)
        .background(Color.gray)
        .cornerRadius(12)
    }
}
