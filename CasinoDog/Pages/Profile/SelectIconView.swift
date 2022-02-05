//
//
//

import SwiftUI

let assetIconURLs: [String] = [
    "assets://icon-gold",
    "assets://icon-candy",
    "assets://icon-berry"
]

struct SelectIconView: View {
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 12) {
                
                ForEach(assetIconURLs, id: \.self) { url in
                    Button {
                        EditUserController().onSelectUserIconURL(url: url)
                    } label: {
                        URLImage(url: url)
                            .frame(width: 100, height: 100)
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                            .shadow(color: .black.opacity(0.5), radius: 2, x: 1, y: 1)
                    }
                }
                
            }
            .frame(width: UIScreen.main.bounds.width, height: 250)
            
        }
        .background(
            Color.plusAutoBlack
                .frame(width: UIScreen.main.bounds.width, height: 250)
                .cornerRadius(12)
        )
        .background(
            Color.plusAutoWhite.opacity(0.5)
                .edgesIgnoringSafeArea(.all)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        )
    }
}
