//
//  WeatherService.swift
//  Weatherly
//
//  Created by Gurunarayanan Muthurakku on 14/03/25.
//


import Foundation

class WeatherService {
    private let apiRepository: APIRepository
    private let apiKey = "202847a7cc5369d9b5bbff9270986a24"

    init(apiRepository: APIRepository = APIRepository.shared) {
        self.apiRepository = apiRepository
    }

    func fetchWeather(for city: String, completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&appid=\(apiKey)&units=metric"
        apiRepository.get(url: urlString, completion: completion)
    }
}
