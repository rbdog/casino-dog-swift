//
//
//

import SwiftUI

struct Header: View {
    @StateObject var playUiState: PartycakePlayUiState = appState.partycakePlayUi
    let betController: PartycakeBetController = PartycakeBetController()
    
    var body: some View {
        HStack {
            Button {
                betController.onTapExit()
            } label: {
                Text("Exit")
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                    .frame(maxWidth: 100, maxHeight: .infinity)
                    .background(playUiState.canExit ? .red : .gray)
                    .cornerRadius(10)
            }
            .disabled(!playUiState.canExit)
            .alert(isPresented: $playUiState.showExitModal) {
                Alert(
                    title: Text("Exit"),
                    message: Text("ゲームを抜けますか?"),
                    primaryButton: .default(Text("No"), action: {
                        betController.onTapExitNo()
                    }),
                    secondaryButton: .destructive(Text("Yes"), action: {
                        betController.onTapExitYes()
                    })
                )
            }
            .padding()
            Spacer()
        }
    }
}

extension Header {
    class State: ObservableObject {
        @Published var isShowingAlert: Bool = false
        var onTapExit: (() -> Void)?
    }
}
