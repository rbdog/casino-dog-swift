//
//
//

import Foundation
import SwiftUI

struct HomeTabBuilder: TabBuilder {
    
    func tabBackColorOnSelected(_ id: PageId) -> Color {
        switch id {
        case .profile:
            return .clear
        case .gameList:
            return .clear
        case .slotList:
            return .clear
        default:
            fatalError("無効なページです")
        }
    }
    
    func tabBackColorOnUnselected(_ id: PageId) -> Color {
        switch id {
        case .profile:
            return .clear
        case .gameList:
            return .clear
        case .slotList:
            return .clear
        default:
            fatalError("無効なページです")
        }
    }
    
    func tabImage(_ id: PageId) -> Image {
        switch id {
        case .profile:
            return Image(systemName: "person.crop.circle")
        case .gameList:
            return Image(systemName: "play.fill")
        case .slotList:
            return Image(ImageName.Slot.slotFlat.rawValue)
        default:
            fatalError("無効なページです")
        }
    }
    
    func tabText(_ id: PageId) -> String {
        switch id {
        case .profile:
            return "Profile"
        case .gameList:
            return "Game"
        case .slotList:
            return "Slot"
        default:
            fatalError("無効なページです")
        }
    }
    
    func contentView(_ id: PageId) -> some View {
        return Group {
            switch id {
            case .profile:
                ProfileView()
            case .gameList:
                GameListView()
            case .slotList:
                SlotListView()
            default:
                fatalError("無効なページです")
            }
        }
    }
}
