//
//
//

import SwiftUI

struct ScoreItem: View {
    @StateObject var scoreUiItem: PokerPlusScoreUiItem
    var body: some View {
        VStack(spacing: 5) {
            HStack {
                ImageProvider(uri: scoreUiItem.iconUrl).view()
                    .clipShape(Circle())
                    .frame(width: 30, height: 30)
                Text(scoreUiItem.nickname)
                    .foregroundColor(.white)
                Image(ImageName.Chip.flat.rawValue)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)

                AnimationReader(scoreUiItem.totalChips) { value in
                    Text(String(value))
                        .foregroundColor(.white)
                }

                Spacer()

                if scoreUiItem.isMyScore {
                    Button {
                        PokerPlusShowdownController().onTapScoreOK()
                    } label: {
                        Text("OK")
                            .font(.system(size: 18))
                            .foregroundColor(.white)
                            .frame(width: 100, height: 30)
                            .background(Color.plusBlue)
                            .cornerRadius(15)
                    }
                }
            }
            .frame(height: 40)
            GeometryReader { geometry in
                VStack {
                    HStack {
                        Image(ImageName.Chip.flat.rawValue)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 35, height: 35)
                            .shadow(color: Color.black.opacity(0.5), radius: 2, x: 1, y: 1)

                        Text(scoreUiItem.bonusChips.withSign)
                                .foregroundColor(.plusGold)

                        Spacer()
                        HStack(spacing: 0) {
                            Image(scoreUiItem.flatCardImageName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 60, height: 30)
                                .shadow(color: Color.black.opacity(0.5), radius: 2, x: 1, y: 1)
                            Image(scoreUiItem.flatOuterImageName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 60, height: 30)
                                .shadow(color: Color.black.opacity(0.5), radius: 2, x: 1, y: 1)
                            Image(scoreUiItem.flatInnerImageName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                                .shadow(color: Color.black.opacity(0.5), radius: 2, x: 1, y: 1)
                        }
                    }
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(width: geometry.size.width - 20,
                               height: 1, alignment: .center)
                    Text(scoreUiItem.comboName)
                        .foregroundColor(.white)
                }
                .padding(.all, 8)
                .background(Color.plusDarkGreen)
                .cornerRadius(10)
            }
        }
        .padding(.all, 8)
    }
}
