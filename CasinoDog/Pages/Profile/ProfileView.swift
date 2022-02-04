//
//
//

import SwiftUI

struct ProfileView: View {
    @StateObject var loginUser: AccountState = appState.account
    @StateObject var editUser: EditUserState = appState.editUser
    
    var body: some View {
        
        GeometryReader { proxy in
            
            ZStack {
                
                VStack {
                    HStack {
                        // 左上にユーザー名
                        Button {
                            EditUserController().onTapNickname()
                        } label: {
                            Text(loginUser.loginUser.nickname)
                                .font(.system(size: 35))
                                .foregroundColor(.plusAutoBlack)
                                .frame(width: 250, height: 50, alignment: .leading)
                                .shadow(color: .black.opacity(0.5), radius: 2, x: 2, y: 2)
                                .minimumScaleFactor(0.5)
                        }
                        .padding(20)
                        .padding(.top, 20)
                        
                        Spacer()
                        
                        // 右上にメニューボタン
                        Button {
                        Router().onOpenMenu()
                        } label: {
                            Image(systemName: "sidebar.trailing")
                                .foregroundColor(.plusAutoBlack)
                                .imageScale(.large)
                                .frame(width: 32.0)
                                .padding(.trailing, 8)
                        }
                    }
                    .frame(width: proxy.size.width, height: 40)
                    .shadow(color: .black.opacity(0.5), radius: 2, x: 2, y: 2)
                    
                    Spacer()
                    
                    // ユーザーアイコン
                    Button {
                        EditUserController().onTapUserIcon()
                    } label: {
                        ImageProvider(url: loginUser.loginUser.icon_url).view()
                            .frame(width: 100, height: 100)
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                            .shadow(color: .black.opacity(0.5), radius: 2, x: 2, y: 2)
                    }
                    .padding(20)
                    
                    // チップ枚数
                    ChipCountView(count: loginUser.loginUser.chips)
                        .frame(height: 60)
                        .padding(.horizontal, 40)
                        .shadow(color: .black.opacity(0.5), radius: 2, x: 2, y: 2)
                    
                    Spacer()
                    
                    // 集めたシンボル ラベル
                    HStack {
                        Text("シンボル コレクション")
                            .font(.system(size: 18))
                            .foregroundColor(.plusAutoBlack)
                            .minimumScaleFactor(0.1)
                        Spacer()
                    }
                    .padding(.horizontal, 40)
                    .shadow(color: .black.opacity(0.5), radius: 2, x: 2, y: 2)
                    
                    // 集めたシンボル コレクション
                    SymbolCollectionView(pockets: loginUser.loginUser.symbol_pockets)
                        .frame(
                            width: proxy.size.width - 80,
                            height: (proxy.size.width - 80) * 0.45
                        )
                        .shadow(color: .black.opacity(0.5), radius: 2, x: 2, y: 2)
                    
                    Spacer()
                    
                } // VStack
                
                if editUser.mode == .edittingNickname {
                    EditNicknameView()
                        
                }
                
                if editUser.mode == .edittingIcon {
                    SelectIconView()
                }
                
            } // ZStack
        }
    }
}
