//
//
//

import SwiftUI

struct TermsOfServiceView: View {
    var body: some View {
        VStack {
            Text("利用規約")
                .font(.system(size: 30))
                .foregroundColor(.white)
                .padding(20)
            
            Spacer()
            
            Text("""
                 カジノドッグを遊んでいただきありがとうございます。
                 このアプリは個人情報を一切使用しません。
                 引き続き安心してご利用ください。
                 
                 なお、ゲーム内の獲得アイテムは今後のアップデートで変更、廃止される可能性があります。
                 アイテムの保証をアナウンスできるまでの間、ご不便をおかけしますが何卒ご了承ください
                 """)
                .font(.system(size: 18))
                .foregroundColor(.white)
                .padding(20)
            
            Spacer()
            
            if let url = URL(string: flavorConfig().termsOfServiceUrl) {
                Link("詳しくはこちら(Webサイト)", destination: url)
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
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.plusBlue)
                    .cornerRadius(10)
            }
            .frame(width: 200, height: 50)
            .padding(20)
        }
    }
}
