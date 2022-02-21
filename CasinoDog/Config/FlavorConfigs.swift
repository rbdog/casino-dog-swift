//
//
//

import Foundation

func flavorConfig() -> FlavorConfig {
    let defaultFlavor: Flavor = .develop
    // MARK: - 移植版では ここで環境変数やビルドコンフィグを読み取る
    let flavor = defaultFlavor
    let config = flavorConfigs.first(where: {$0.flavor == flavor})!
    return config
}

let flavorConfigs: [FlavorConfig] = [
    FlavorConfig(
        flavor: .develop,
        splashConfigUrl: "https://rbdog.github.io/casino-dog-swift/static/splash_config.json",
        developerTwitterUrl: "https://twitter.com/rubydog725",
        termsOfServiceUrl: "https://rbdog.github.io/casino-dog-swift/"
    )
]
