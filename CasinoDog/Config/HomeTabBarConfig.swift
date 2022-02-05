//
//
//

import Foundation
import SwiftUI

let homeTabBarConfig = TabBarConfig(
    pageList: [
        .profile,
        .gameList,
        .slotList
    ],
    backColorOnSelected: .clear,
    backColorOnUnselected: .clear,
    imageUrls: [
        .profile: "sfsymbol://person.crop.circle",
        .gameList: "sfsymbol://play.fill",
        .slotList: "assets://" + ImageName.Slot.slotFlat.rawValue
    ],
    labelTexts: [
        .profile: "Profile",
        .gameList: "Game",
        .slotList: "Slot"
    ]
)
