//
//
//

import SwiftUI

struct Flip<Front: View, Back: View>: View {
    /// 0..<360
    let degree: Double
    let front: Front
    let back: Back

    init(degree: Double,
         front: Front,
         back: Back) {
        self.degree = degree
        self.front = front
        self.back = back
    }

    var body: some View {
        ZStack {
            AnimationReader(CGFloat(degree)) { value in
                if (value < 90) || (270 < value) {
                    front
                } else {
                    back
                }
            }
        }
        .rotation3DEffect(
            Angle(degrees: degree),
            axis: (x: 0, y: 10, z: 0)
        )
    }
}
