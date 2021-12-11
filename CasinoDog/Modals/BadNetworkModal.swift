//
//
//

import SwiftUI

struct BadNetworkModal: View {
    let message: String = "通信に失敗しました😢 通信をONにするか、しばらく後でお試しください。"
    var body: some View {
        VStack {
            Spacer()
            Text(message)
                .font(.system(size: 16))
                .foregroundColor(.black)
                .padding([.leading, .trailing], 20)
            Spacer()
            Button {
                Router().deqBaseModal()
            } label: {
                Text("OK")
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                    .frame(width: 100, height: 50)
                    .background(Color.plusBlue)
                    .cornerRadius(10)
                    .padding(.leading, 8)
            }
            .padding(.bottom, 20)
        }
        .frame(width: 250, height: 200)
        .background(Color.plusAutoWhite)
        .cornerRadius(12)
    }
}
