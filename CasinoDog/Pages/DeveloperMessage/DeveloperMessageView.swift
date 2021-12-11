//
//
//

import SwiftUI

struct DeveloperMessageView: View {
    var body: some View {
        VStack {
            
            Text("ゲーム開発者より")
                .font(.system(size: 30))
                .foregroundColor(.white)
                .padding(20)
            
            Spacer()
            
            Text("""
                 このような小さなアプリに興味を持っていただき、インストールしていただき、遊んでいただいてありがとうございます。🥲
                 まだまだ開発途中の部分もありますが、できるだけユーザー様の意見を取り入れながら少しずつ進化していきます。
                 何か気づいたバグや実装してほしい機能があれば、気軽にtwitterで連絡してください。💌
                 これからも皆様に楽しんでいただける要素を追加していきますので、今後のバージョンアップにもご期待ください。
                 一緒に開発してくれる協力者の方も募集中です。是非、よろしくお願いいたします。
                 
                 開発者 Twitter: @Rubydog725
                 """)
                .font(.system(size: 18))
                .foregroundColor(.white)
            
            Spacer()
            
            if let url = URL(string: flavorConfig().developerTwitterUrl) {
                Link("Twitterはこちらから", destination: url)
                    .frame(width: UIScreen.main.bounds.width - 40,
                           height: 50)
                    .background(Color.white)
                    .cornerRadius(8)
            }
            
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
