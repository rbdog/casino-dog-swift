//
//
//

import SwiftUI

extension UINavigationController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIColor.clear
        navigationBar.standardAppearance = appearance
        self.view.backgroundColor = .clear
    }
}

struct SplashView: View {
    @StateObject var splash: SplashState = appState.splash
    
    init() {
        SplashController().initSplashState()
    }

    var body: some View {
        ZStack {
            Color.plusRed
                .ignoresSafeArea(.all)

            Image(ImageName.Splash.splash.rawValue)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: splash.width,
                       height: splash.width,
                       alignment: .center)
                .opacity(splash.alpha)
        }
        .onAppear {
            SplashController().onSplashAppear()
        }
    }
}
