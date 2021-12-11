//
//
//

import SwiftUI
import Center

struct DebugView: View {
    @State var showAlert: Bool = false
    
    var body: some View {
        VStack {
            Text("ここはスタッフ用の画面です")
                .font(.system(size: 20))
                .foregroundColor(.white)
                .padding(12)
            
            Button {
                showAlert = true
            } label: {
                Text("このゲームのデータを全て削除")
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.red)
                    .cornerRadius(10)
                    .padding(.leading, 8)
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("本当に削除しますか？"),
                    message: Text("この操作は取り消せません"),
                    primaryButton: .default(Text("No"), action: {
                        showAlert = false
                    }),
                    secondaryButton: .destructive(Text("Yes"), action: {
                        showAlert = false
                        // デバッグ用
                        
                        resetApp()
                    })
                )
            }
            .padding(.trailing, 8)
            .frame(maxWidth: 400, maxHeight: 80)
            
            Text("""
                 万が一に備えたアプリリセットのため、しばらくの期間は一般開放されていますが、操作には十分ご注意ください
                 """)
                .font(.system(size: 18))
                .foregroundColor(.white)
                .padding(20)
            
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
                    .padding(.leading, 8)
            }
            .padding(.trailing, 8)
            .frame(maxWidth: 200, maxHeight: 80)
            
            Spacer()
        }
    }
}
