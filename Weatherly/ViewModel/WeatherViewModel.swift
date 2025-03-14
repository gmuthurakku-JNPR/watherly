//
//  WeatherViewModel.swift
//  Weatherly
//
//  Created by Gurunarayanan Muthurakku on 09/03/25.
//

import Foundation
import SwiftUI

// MARK: - ViewModel for Fetching Weather
class WeatherViewModel: ObservableObject {
    @Published var forecasts: [WeatherItem] = []
    @Published var cityName: String = ""

    private let weatherService: WeatherService

    init(weatherService: WeatherService = WeatherService()) {
        self.weatherService = weatherService
    }

    func fetchWeather() {
        let city = "Madurai"
        weatherService.fetchWeather(for: city) { [weak self] result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self?.forecasts = response.list
                    self?.cityName = response.city.name
                }
            case .failure(let error):
                print("API Error: \(error)")
            }
        }
    }
}
