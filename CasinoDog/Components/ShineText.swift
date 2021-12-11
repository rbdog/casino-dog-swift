//
//
//

import SwiftUI

private struct ShineText<Content: View>: View {

    let waveIndex: Int
    let colors: [Color]
    let content: () -> Content

    init(waveIndex: Int, colors: [Color], @ViewBuilder content: @escaping () -> Content) {
        self.waveIndex = waveIndex
        self.colors = colors
        self.content = content
    }

    var body: some View {
        linearGradient(
            of: self.colors.broughtToTail(
                prefix: waveIndex.looped(in: 0...(self.colors.count - 1))
            )
        )
        .mask(content())
    }

    func linearGradient(of cls: [Color]) -> LinearGradient {
        return LinearGradient(
            gradient: Gradient(colors: cls),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}

enum ShineTextColor {
    case gold
    case silver
    case bronze
    var colors: [Color] {
        switch self {
        case .gold: return [
            .white,
            Color(hex: 0xDBB400),
            Color(hex: 0xEFAF00),
            Color(hex: 0xF5D100),
            Color(hex: 0xE0CA82),
            Color(hex: 0xD1AE15),
            Color(hex: 0xDBB400)
        ]
        case .silver: return [
            .white,
            Color(hex: 0x70706F),
            Color(hex: 0x7D7D7A),
            Color(hex: 0xB3B6B5),
            Color(hex: 0x8E8D8D),
            Color(hex: 0xB3B6B5),
            Color(hex: 0xA1A2A3)
        ]
        case .bronze: return [
            .white,
            Color(hex: 0x804A00),
            Color(hex: 0x9C7A3C),
            Color(hex: 0xB08D57),
            Color(hex: 0x895E1A),
            Color(hex: 0x804A00),
            Color(hex: 0xB08D57)
        ]}
    }
}

extension View {
    func shine(_ color: ShineTextColor, withWaveIndex index: Int) -> some View {
        ShineText(waveIndex: index, colors: color.colors) {
            self
        }
    }
}
