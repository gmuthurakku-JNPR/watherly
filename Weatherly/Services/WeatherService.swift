//
//  WeatherService.swift
//  Weatherly
//
//  Created by Gurunarayanan Muthurakku on 14/03/25.
//


import Foundation

class WeatherService {
    private let apiRepository: APIRepository

    init(apiRepository: APIRepository = APIRepository.shared) {
        self.apiRepository = apiRepository
    }

    func fetchWeather(for city: String, completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        RemoteConfigService.shared.fetchAPIKey { [weak self] apiKey in
            guard let apiKey, !apiKey.isEmpty else { return }
            let urlString = "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&appid=\(apiKey)&units=metric"
            self?.apiRepository.get(url: urlString, completion: completion)
        }
    }
}



// Other Use cases

// 1. App Mode
//    *) Staging, production, QA, Beta Features can be handled
// 2. Can Hide the API Keys via the code, So that Exposed API Key issue will be resolved.
// 3. In general
//      If we want to make the changes in the app with out interaction to the code, best option is Firebase Remote Config.
