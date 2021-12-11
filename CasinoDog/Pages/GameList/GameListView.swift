//
//
//

import SwiftUI

struct GameListView: View {
    @StateObject var gameList: GameListState = appState.gameList
    @StateObject var loginUser: AccountState = appState.account

    var body: some View {

        GeometryReader { proxy in
            VStack {
                HStack {
                    // 左上にスペース
                    Spacer()
                    // 右上にチップ数
                    ChipCountView(count: loginUser.loginUser.chips)
                        .frame(width: 0.9 * proxy.size.width/2)
                        .padding(.trailing, 8)
                }
                .frame(width: proxy.size.width, height: 40)
                

                Spacer()
                
                ScrollView(.horizontal) {
                
                VStack {

                ZStack {
                    Image("ribbon-price")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 60)
                    HStack {
                        Image("chip")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 30)
                        Text("30")
                            .foregroundColor(.white)
                            .font(.system(size: 30))
                    }
                }
                .frame(height: 70)
                .shadow(color: .black.opacity(0.5), radius: 2, x: 2, y: 2)
                
                Image(ImageName.Game.pokerPlus.rawValue)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, alignment: .center)
                    .shadow(color: .black.opacity(0.5), radius: 2, x: 2, y: 2)
                }
                .frame(width: UIScreen.main.bounds.width - 40, height: 400)
                }
                .frame(width: UIScreen.main.bounds.width - 40, height: 400)
                .background(Color.plusDarkGreen)
                .cornerRadius(12)
                
                Spacer()
                
                Button {
                    SelectGameController().onTapPlay()
                }
                label: {
                    Text("Play")
                        .font(.system(size: 26))
                        .foregroundColor(.white)
                        .frame(width: 250, height: 50)
                        .background(Color.plusBlue)
                        .cornerRadius(10)
                }
                .buttonStyle(ScaleButtonStyle())
                .shadow(color: .black.opacity(0.5), radius: 2, x: 2, y: 2)

                Spacer()
            }
            .frame(maxWidth:UIScreen.main.bounds.width)

        }

    }
}
