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
    
    func fetchWeather() {
        let apiKey = "202847a7cc5369d9b5bbff9270986a24"
        let city = "Madurai"
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&appid=\(apiKey)&units=metric"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Network error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                let result = try JSONDecoder().decode(WeatherResponse.self, from: data)
                DispatchQueue.main.async {
                    self.forecasts = result.list
                    self.cityName = result.city.name
                }
            } catch {
                print("Decoding error: \(error)")
            }
        }.resume()
    }
}
