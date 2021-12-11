//
//
//

import SwiftUI

struct Spotlight: View {
    let x: CGFloat
    let y: CGFloat
    let width: CGFloat
    let height: CGFloat
    let cornerRadius: CGFloat
    
    var body: some View {
        Rectangle()
            .fill(Color.black.opacity(0.6))
            .mask(
                Rectangle()
                    .cornerRadius(cornerRadius)
                    .frame(width: width, height: height)
                    .position(x: x, y: y)
                    .background(Color.white)
                    .compositingGroup()
                    .luminanceToAlpha()
            )
            .frame(maxWidth: .infinity,  maxHeight: .infinity)
    }
}
