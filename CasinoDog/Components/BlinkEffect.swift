//
//
//

import SwiftUI

struct BlinkEffect: ViewModifier {
    @State var isOn: Bool = false
    let opacityRange: ClosedRange<Double>
    let interval: Double
    
    init(opacity: ClosedRange<Double>, interval: Double) {
        self.opacityRange = opacity
        self.interval = interval
    }
    
    func body(content: Content) -> some View {
        content
            .opacity(isOn ? opacityRange.lowerBound : opacityRange.upperBound)
            .animation(Animation.linear(duration: interval).repeatForever(), value: isOn)
            .onAppear(perform: {
                isOn = true
            })
    }
}

extension View {
    func blinkEffect(animating: Bool, opacity: ClosedRange<Double> = 0.1...1, interval: Double = 0.6) -> some View {
        if animating {
            return AnyView(modifier(BlinkEffect(opacity: opacity, interval: interval)))
        } else {
            return AnyView(self)
        }
    }
}
