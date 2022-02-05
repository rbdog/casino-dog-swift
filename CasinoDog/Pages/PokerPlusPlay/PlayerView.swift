//
//
//

import SwiftUI

struct PlayerView: View {
    @StateObject var playUiSide: PokerPlusPlayUiSide
    
    func borderColor() -> Color {
        // シートは固定なので、初回計算のみ
        let myUserId = appState.account.loginUser.id
        let mySeat = appState.pokerPlusSystem.players.first(where: {$0.user_id == myUserId})!.seat
        if playUiSide.seat.rawValue == mySeat {
            return .plusBlue
        } else {
            return .clear
        }
    }
    
    var body: some View {
        
        GeometryReader { proxy in
            VStack(spacing: 0) {
                Text(String(playUiSide.chips))
                    .font(.system(size: 16))
                    .foregroundColor(.plusGold)
                
                URLImage(url: playUiSide.playerIconUrl)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(borderColor(), lineWidth: 2))
                    .frame(width: proxy.size.width * 0.9, height: proxy.size.width * 0.9)
                
                BetBox(playUiSide: playUiSide)
                    .frame(height: 12)
                
                Spacer()
                
                GeometryReader { nameProxy in
                    ZStack {
                        Text(playUiSide.playerNickname)
                            .foregroundColor(.white)
                            .frame(width: nameProxy.size.height, height: nameProxy.size.width)
                            .rotationEffect(Angle(degrees: (
                                playUiSide.seat == .s3 || playUiSide.seat == .s4
                            ) ? 90 : -90))
                    }
                    .frame(width: nameProxy.size.width, height: nameProxy.size.height)
                }
                
                Spacer()
            }
            .background(
                EmptyView()
                    .background(Color.white.opacity(0.5))
                    .mask(
                        (playUiSide.seat == .s3 || playUiSide.seat == .s4)
                        ? CornerRounded(color: Color.white.opacity(0.5),
                                        tl: 0,
                                        tr: 12,
                                        bl: 0,
                                        br: 12)
                        : CornerRounded(color: Color.white.opacity(0.5),
                                        tl: 12,
                                        tr: 0,
                                        bl: 12,
                                        br: 0)
                    )
            )
            
        }
        
    }
}
