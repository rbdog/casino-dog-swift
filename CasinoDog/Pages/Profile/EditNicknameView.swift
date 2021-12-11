//
//
//

import SwiftUI

struct EditNicknameView: View {
    @StateObject var editUser: EditUserState = appState.editUser
    var body: some View {
        VStack {
            
            TextField(
                appState.account.loginUser.nickname,
                text: $editUser.nickname,
                onEditingChanged: { onEditing in
                    print("onEditingChanged: \(onEditing)")
                },
                onCommit: {
                    print("onCommit")
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button {
                EditUserController().onUpdateUser()
            } label: {
                Text("Save")
                    .font(.system(size: 26))
                    .foregroundColor(.white)
                    .frame(width: 250, height: 50)
                    .background(Color.plusBlue)
                    .cornerRadius(10)
            }
            .buttonStyle(ScaleButtonStyle())
        }
        .background(
            Color.plusAutoBlack
                .edgesIgnoringSafeArea(.all)
                .frame(height: 250)
                .cornerRadius(12)
        )
        .background(
            Color.plusAutoWhite.opacity(0.5)
                .edgesIgnoringSafeArea(.all)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        )
    }
}
