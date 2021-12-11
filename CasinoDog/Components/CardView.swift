//
//
//

import SwiftUI

struct CardView: View {
    let imageName: String
    let degree: Double
    var body: some View {

        Flip(degree: degree,
             front:
                Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit),
             back:
                Image(ImageName.Card.back.rawValue)
                .resizable()
                .aspectRatio(contentMode: .fit)
        )
    }
}
