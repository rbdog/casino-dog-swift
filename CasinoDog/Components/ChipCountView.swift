//
//
//

import SwiftUI

struct ChipCountView: View {
    let count: Int
    var body: some View {

        GeometryReader { proxy in
            HStack {
                Image(ImageName.Chip.default.rawValue)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .padding(proxy.size.height * 0.1)
                Spacer()
                Text(String(count))
                    .font(.system(size: 80))
                    .foregroundColor(.plusAutoWhite)
                    .minimumScaleFactor(0.1)
                    .padding(proxy.size.height * 0.2)
            }
            .background(Color.plusAutoBlack.opacity(0.5))
            .cornerRadius(100)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .shadow(color: .black.opacity(0.5), radius: 2, x: 2, y: 2)

    }
}
