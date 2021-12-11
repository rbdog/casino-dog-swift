//
//
//

import SwiftUI

struct ClockView: View {
    @State var timer: Timer?
    @State var degree: Double = 0
    var body: some View {
        ZStack{
            Image("clock-base")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Image("clock-hand")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .rotationEffect(Angle(degrees: degree))
        }
        .onAppear {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                tick(duration: 1)
            }
        }
    }
    
    let animation = Animation.spring(
        response: 0.4, // 値が小さいほど早い
        dampingFraction: 0.5, // バネを止めようとする力 0-1
        blendDuration: 0.1 // 次のアニメーションと被った時の移行時間
    )
    
    func tick(duration: Double) {
        if degree >= 360 {
            degree = 0
        }
        withAnimation(animation) {
            degree += 90
        }
    }
}
