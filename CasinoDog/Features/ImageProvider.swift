//
//
//

import Foundation
import SwiftUI

struct URLImage: View {
    enum SourceLocation {
        case assets(name: String)
        case network(url: String)
        case sfsymbol(systemName: String)
    }
    
    let url: String
    let location: SourceLocation
    let mode: Image.TemplateRenderingMode
    
    init(url: String, mode: Image.TemplateRenderingMode = .original) {
        self.url = url
        self.mode = mode
        let components = url.components(separatedBy: "://")
        let scheme = components.first
        let sourcePath = components.last
        switch scheme {
        case "assets":
            self.location = .assets(name: sourcePath!)
        case "http", "https":
            self.location = .network(url: url)
        case "sfsymbol":
            self.location = .sfsymbol(systemName: sourcePath!)
        default:
            fatalError("未知の画像指定方法です")
        }
    }
    
    var body: some View {
        return Group {
            switch self.location {
            case .network(url: let url):
                AsyncImage(url: URL(string: url)) { image in
                    image.resizable() // 1行で指定しないと、別のTypeとしてみなされる
                        .renderingMode(mode)
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
            case .assets(name: let name):
                Image(name)
                    .resizable()
                    .renderingMode(mode)
                    .aspectRatio(contentMode: .fit)
            case .sfsymbol(systemName: let systemName):
                Image(systemName: systemName)
                    .resizable()
                    .renderingMode(mode)
                    .aspectRatio(contentMode: .fit)
            }
        }
    }
}
