//
//
//

import SwiftUI

struct OldVersionModal: View {
    let message: String = "新しいバージョンがリリースされました🎉 お手数ですがアプリの更新をお願いします🙇‍♂️"
    var body: some View {
        VStack {
            Spacer()
            Text(message)
                .font(.system(size: 16))
                .foregroundColor(.black)
                .padding([.leading, .trailing], 20)
            Spacer()
        }
        .frame(width: 250, height: 200)
        .background(Color.plusAutoWhite)
        .cornerRadius(12)
    }
}
