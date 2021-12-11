//
//
//

import SwiftUI

struct ScoreListView: View {
    @StateObject var scoreUiState: PokerPlusScoreUiState = appState.pokerPlusScoreUi
    
    var body: some View {
        
        ScrollViewReader { (scroller: ScrollViewProxy) in
            ScrollView {
                VStack(spacing: 40) {
                    Text("得点")
                        .font(.system(size: 22))
                        .foregroundColor(.white)
                        .frame(width: 200, height: 50)
                    
                    ForEach(scoreUiState.items.indices) { index in
                        if scoreUiState.items[index].isMyScore {
                            if scoreUiState.showMyScore {
                                ScoreItem(scoreUiItem: scoreUiState.items[index])
                                    .frame(width: UIScreen.main.bounds.width - 10, height: 120)
                                    .id(ScoreListView.Const.OK_BUTTON)
                                    .transition(.move(edge: .trailing))
                            } else {
                                EmptyView()
                            }
                        } else {
                            ScoreItem(scoreUiItem: scoreUiState.items[index])
                                .frame(width: UIScreen.main.bounds.width - 10, height: 120)
                                .id("ELSE")
                        }
                    }
                    
                }
                .onChange(of: scoreUiState.idToScroll) { newID in
                    DispatchQueue.main.async {
                        withAnimation {
                            scroller.scrollTo(newID, anchor: .center)
                        }
                    }
                }
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Color.black.opacity(0.5)
        )
    }
}

extension ScoreListView {
    
    enum Const {
        static let OK_BUTTON = "OK_BUTTON"
    }
}
