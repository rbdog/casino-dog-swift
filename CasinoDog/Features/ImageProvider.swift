//
//
//

import Foundation
import SwiftUI

struct ImageProvider {
    
    enum SourceLocation {
        case assets(name: String)
        case network(url: String)
        case sfsymbol(systemName: String)
    }
    
    let uri: String
    let location: SourceLocation
    
    init(uri: String) {
        self.uri = uri
        let components = uri.components(separatedBy: "://")
        let scheme = components.first
        let sourcePath = components.last
        switch scheme {
        case "assets":
            self.location = .assets(name: sourcePath!)
        case "http", "https":
            self.location = .network(url: sourcePath!)
        case "sfsymbol":
            self.location = .sfsymbol(systemName: sourcePath!)
        default:
            fatalError("未知の画像指定方法です")
        }
    }
    
    func view() -> AnyView {
        switch self.location {
        case .network(url: let url):
            return AnyView (
                AsyncImage(url: URL(string: url))
            )
        case .assets(name: let name):
            return AnyView(
                Image(name)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            )
        case .sfsymbol(systemName: let systemName):
            return AnyView(
                Image(systemName: systemName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            )
        }
    }
}