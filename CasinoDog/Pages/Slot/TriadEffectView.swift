//
//
//

import SwiftUI
import Center

struct TriadEffectView: View {
    let triadAnimation: SlotTriadAnimation = appState.slotMachine!.triadAnimation!
  
    var body: some View {
        VStack {
            Text("GET !")
                .font(.system(size: 40, weight: .bold, design: .default))
                .foregroundColor(Color.white)
            Text(triadAnimation.title)
                .font(.system(size: 20, weight: .regular, design: .default))
                .foregroundColor(Color.white)
            ImageProvider(url: triadAnimation.image_url).view()
                .frame(width: 150, height: 150)
                .shine(.gold)
            Text(triadAnimation.description)
                .font(.system(size: 18, weight: .regular, design: .default))
                .foregroundColor(Color.white)
            
            Button {
                SpinSlotController().onTapTriadOK()
            } label: {
                Text("OK")
                    .font(.system(size: 22))
                    .foregroundColor(.white)
                    .frame(width: 200, height: 50)
                    .background(Color.plusBlue)
                    .cornerRadius(14)
            }
        }
        .frame(height: 500)
    }
}
