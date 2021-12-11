//
//
//

import SwiftUI

struct Slider: UIViewRepresentable {
    
    final class Coordinator: NSObject {
        // The class property value is a binding: It’s a reference to the SwiftUISlider
        // value, which receives a reference to a @State variable value in ContentView.
        var value: Binding<CGFloat>
        
        // Create the binding when you initialize the Coordinator
        init(value: Binding<CGFloat>) {
            self.value = value
        }
        
        // Create a valueChanged(_:) action
        @objc func valueChanged(_ sender: UISlider) {
            self.value.wrappedValue = CGFloat(sender.value)
        }
    }
    
    var thumbColor: Color
    var minTrackColor: Color
    var maxTrackColor: Color
    
    @Binding var value: CGFloat
    var valueController: CGFloat {
        didSet {
            self.$value.wrappedValue = self.valueController
        }
    }
    
    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider(frame: .zero)
        slider.thumbTintColor = UIColor(thumbColor)
        slider.minimumTrackTintColor = UIColor(minTrackColor)
        slider.maximumTrackTintColor = UIColor(maxTrackColor)
        slider.value = Float(value)
        
        slider.addTarget(
            context.coordinator,
            action: #selector(Coordinator.valueChanged(_:)),
            for: .valueChanged
        )
        
        return slider
    }
    
    func updateUIView(_ uiView: UISlider, context: Context) {
        // Coordinating data between UIView and SwiftUI view
        uiView.value = Float(self.value)
    }
    
    func makeCoordinator() -> Slider.Coordinator {
        Coordinator(value: $value)
    }
}
