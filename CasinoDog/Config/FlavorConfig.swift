//
//
//

import Foundation

struct FlavorConfig {
    /// Flavor
    let flavor: Flavor
    /// スプラッシュ画面APIのURL
    let splashConfigUrl: String
    /// 開発者TwitterのURL
    let developerTwitterUrl: String
    /// 利用規約URL
    let termsOfServiceUrl: String
}

func flavorConfig() -> FlavorConfig {
    let flavor = flavor()
    let config = flavorConfigs.first(where: {$0.flavor == flavor})!
    return config
}

let flavorConfigs: [FlavorConfig] = [
    FlavorConfig(
        flavor: .develop,
        splashConfigUrl: "https://rbdog.github.io/casino-dog/static/splash_config.json",
        developerTwitterUrl: "https://twitter.com/rubydog725",
        termsOfServiceUrl: "https://rbdog.github.io/casino-dog/"
    )
]
