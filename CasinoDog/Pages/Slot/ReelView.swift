//
//
//

import SwiftUI

struct ReelView: View {
    @StateObject var reel: ReelState

    var body: some View {
        GeometryReader { proxy in
            ScrollViewReader { _ in
                ScrollView {
                    VStack(spacing: 0) {
                        // ループ用に一番下の画像を先頭にも置いておく
                        SymbolView(state: .init(imageName: reel.symbols.last!.imageName.rawValue))
                            .frame(width: proxy.size.width, height: proxy.size.width)
                            .id(-1)
                        // 画像を縦に並べる
                        ForEach(reel.symbols.indices) { index in
                            SymbolView(state: .init(imageName: reel.symbols[index].imageName.rawValue))
                                .frame(width: proxy.size.width, height: proxy.size.width)
                                .id(index)
                        }
                        // ループ用に一番上の画像を末尾にも置いておく
                        SymbolView(state: .init(imageName: reel.symbols.first!.imageName.rawValue))
                            .frame(width: proxy.size.width, height: proxy.size.width)
                            .id(99)
                        // ループ用に2番目の画像も末尾にも置いておく
                        SymbolView(state: .init(imageName: reel.symbols[1].imageName.rawValue))
                            .frame(width: proxy.size.width, height: proxy.size.width)
                            .id(100)
                    }
                    // 上下で+3個分縦長にする
                    .frame(
                        width: proxy.size.width,
                        height: proxy.size.width * CGFloat(reel.symbols.count + 3)
                    )
                    .offset(x: 0, y: -reel.offset)
                }
                .background(Color.white)
            }
            .onAppear {
                appState.slotMachine.squreSize = proxy.size.width
            }
        }
        .disabled(true)
    }
}
