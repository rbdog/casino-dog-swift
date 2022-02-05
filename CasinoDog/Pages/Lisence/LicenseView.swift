//
//
//

import SwiftUI

struct LicenseView: View {    
    var body: some View {
        VStack {
            Text("ライセンス・著作権")
                .font(.system(size: 30))
                .foregroundColor(.white)
                .padding(20)
            
            Spacer()
            
            Text("""
                 ライセンスはとりあえず何もなし！自由です＼(^o^)／
                 アプリの名前や画像を使ったり、よく似たゲームを作るのも全部無許可で大丈夫です
                 同じ内容で商標登録されたり、このゲームの開発が出来なくなるような事だけはご控えくださるようお願いしますm(_ _)m
                 """)
                .font(.system(size: 22))
                .foregroundColor(.white)
            
            Spacer()
            
            Button {
                Router().popBasePage()
            } label: {
                Text("戻る")
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                    .frame(maxWidth: 100, maxHeight: .infinity)
                    .background(Color.plusBlue)
                    .cornerRadius(10)
                    .padding(.leading, 8)
            }
            .padding(.trailing, 8)
            .frame(width: 200, height: 50)
        }
    }
}
