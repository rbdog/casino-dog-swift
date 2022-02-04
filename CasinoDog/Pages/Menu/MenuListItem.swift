//
//
//

import SwiftUI

struct MenuItemView: View {
    let id: MenuItemId
    
    var body: some View {
        Button {
            Router().onTapMenuItem(itemID: id)
        } label: {
            HStack {
                Image(systemName: id.systemName())
                    .foregroundColor(.white)
                    .imageScale(.large)
                    .frame(width: 32.0)
                Text(id.nickname())
                    .foregroundColor(.white)
                    .font(.headline)
                Spacer()
            }
            .padding(.leading, 32)
            .padding([.top, .bottom], 15)
        }
    }
}
