//
//
//

import SwiftUI

struct MenuListView: View {
    var body: some View {
        GeometryReader { proxy in
            HStack {
                Spacer()
                
                VStack {
                    Color.clear
                        .frame(width: 1, height: proxy.safeAreaInsets.top + 30)
                    HStack {
                        // 左上にスペース
                        Spacer()
                        // 右上にメニューボタン
                        Button {
                            Router().onCloseMenu()
                        } label: {
                            Image(systemName: "arrowshape.turn.up.backward")
                                .foregroundColor(.white)
                                .imageScale(.large)
                                .frame(width: 32.0)
                                .padding(.trailing, 8)
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width - 100,
                           height: 40)
                    
                    Spacer()
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("CASINO DOG")
                                .font(.system(size: 30))
                                .foregroundColor(.white)
                            Text(appVersion())
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                                
                        }
                        .padding(.leading, 32)
                        Spacer()
                    }
                    
                    Spacer()
                    
                    ForEach(0..<MenuItemID.availableList().count) { index in
                        MenuItemView(id: MenuItemID.availableList()[index])
                    }
                    
                    Spacer()
                    
                    Color.clear
                        .frame(width: 1, height: 20)
                }
                .frame(width: UIScreen.main.bounds.width - 100,
                       height: UIScreen.main.bounds.height)
                .background(Color.plusDarkGreen)
            }
            .background(
                Color.black.opacity(0.5)
                    .onTapGesture {
                        Router().onCloseMenu()
                    }
            )
        }
        .edgesIgnoringSafeArea(.all)
        .frame(maxWidth: .infinity,
               maxHeight: .infinity)
    }
}
