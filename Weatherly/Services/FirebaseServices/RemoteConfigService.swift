//
//  RemoteConfigService.swift.swift
//  Weatherly
//
//  Created by Gurunarayanan Muthurakku on 15/03/25.
//


import FirebaseRemoteConfig

class RemoteConfigService {
    static let shared = RemoteConfigService()
    private let remoteConfig = RemoteConfig.remoteConfig()

    init() {
        let settings = RemoteConfigSettings()
        remoteConfig.configSettings = settings
    }

    func fetchAPIKey(completion: @escaping (String?) -> Void) {
        remoteConfig.fetchAndActivate { status, error in
            if let error = error {
                print("Remote Config fetch failed: \(error.localizedDescription)")
                completion(nil)
                return
            }

            let apiToken = self.remoteConfig["WeatherlyAPIKey"].stringValue
            completion(apiToken)
        }
    }
}
